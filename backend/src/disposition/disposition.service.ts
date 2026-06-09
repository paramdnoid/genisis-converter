import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
  Optional,
} from "@nestjs/common";
import { Prisma } from "@prisma/client";

import { RequestUser } from "../common/types/request-user";
import { PrismaService } from "../prisma/prisma.service";
import { PushService } from "../push/push.service";
import {
  DispositionSnapshot,
  DispositionUserSummary,
  DispositionWorkOrderSummary,
  UpdateDispositionWorkOrderRequest,
} from "./disposition.types";

type WorkOrderWithRelations = Prisma.WorkOrderGetPayload<{
  include: {
    customer: true;
    object: true;
  };
}>;

const DISPATCH_ROLES = new Set(["admin", "dispatcher"]);
const ALLOWED_STATUSES = new Set([
  "scheduled",
  "in_progress",
  "paused",
  "completed",
  "cancelled",
]);
const ALLOWED_PRIORITIES = new Set(["low", "normal", "high", "urgent"]);

@Injectable()
export class DispositionService {
  constructor(
    private readonly prisma: PrismaService,
    @Optional() private readonly push?: PushService,
  ) {}

  async snapshot(
    tenantId: string,
    user: RequestUser,
  ): Promise<DispositionSnapshot> {
    this.assertCanDispatch(user);

    const [workOrders, users] = await Promise.all([
      this.prisma.workOrder.findMany({
        where: { tenantId, deletedAt: null },
        include: { customer: true, object: true },
        orderBy: [
          { scheduledStart: "asc" },
          { priority: "desc" },
          { orderNumber: "asc" },
        ],
        take: 500,
      }),
      this.prisma.user.findMany({
        where: { tenantId, deletedAt: null },
        orderBy: [{ isActive: "desc" }, { lastName: "asc" }],
      }),
    ]);

    const technicians = users
      .filter((candidate) => candidate.role === "technician")
      .map((candidate) => this.mapUser(candidate));
    const userNameById = new Map(
      users.map((candidate) => [
        candidate.id,
        `${candidate.firstName} ${candidate.lastName}`.trim(),
      ]),
    );
    const mappedWorkOrders = workOrders.map((workOrder) =>
      this.mapWorkOrder(workOrder, userNameById),
    );

    return {
      generatedAt: new Date().toISOString(),
      tenantId,
      user: {
        id: user.id,
        email: user.email,
        role: user.role,
      },
      metrics: {
        total: mappedWorkOrders.length,
        open: mappedWorkOrders.filter(
          (workOrder) =>
            workOrder.status !== "completed" &&
            workOrder.status !== "cancelled",
        ).length,
        scheduled: mappedWorkOrders.filter(
          (workOrder) => workOrder.status === "scheduled",
        ).length,
        inProgress: mappedWorkOrders.filter(
          (workOrder) => workOrder.status === "in_progress",
        ).length,
        completed: mappedWorkOrders.filter(
          (workOrder) => workOrder.status === "completed",
        ).length,
        overdue: mappedWorkOrders.filter((workOrder) => workOrder.isOverdue)
          .length,
        unassigned: mappedWorkOrders.filter(
          (workOrder) => !workOrder.assignedUserId,
        ).length,
      },
      technicians,
      workOrders: mappedWorkOrders,
    };
  }

  async updateWorkOrder(
    tenantId: string,
    user: RequestUser,
    workOrderId: string,
    body: UpdateDispositionWorkOrderRequest,
  ): Promise<DispositionWorkOrderSummary> {
    this.assertCanDispatch(user);
    const data = this.cleanUpdatePayload(body);

    if (Object.keys(data).length === 0) {
      throw new BadRequestException("No dispatch fields supplied.");
    }

    if (typeof data.assignedUserId === "string") {
      const assignee = await this.prisma.user.findFirst({
        where: {
          id: data.assignedUserId,
          tenantId,
          deletedAt: null,
          isActive: true,
          role: "technician",
        },
      });
      if (!assignee) {
        throw new BadRequestException("Assigned technician is not available.");
      }
    }

    const existing = await this.prisma.workOrder.findFirst({
      where: { id: workOrderId, tenantId, deletedAt: null },
      select: { assignedUserId: true },
    });
    if (!existing) {
      throw new NotFoundException("Work order not found.");
    }

    const updateResult = await this.prisma.workOrder.updateMany({
      where: { id: workOrderId, tenantId, deletedAt: null },
      data,
    });

    if (updateResult.count === 0) {
      throw new NotFoundException("Work order not found.");
    }

    const updated = await this.prisma.workOrder.findFirst({
      where: { id: workOrderId, tenantId },
      include: { customer: true, object: true },
    });
    if (!updated) {
      throw new NotFoundException("Work order not found.");
    }
    if (
      updated.assignedUserId &&
      existing.assignedUserId !== updated.assignedUserId
    ) {
      void this.push?.queueNewWorkOrderNotification(tenantId, updated.id, {
        previousAssignedUserId: existing.assignedUserId,
      });
    }

    const users = await this.prisma.user.findMany({
      where: { tenantId, deletedAt: null },
    });
    const userNameById = new Map(
      users.map((candidate) => [
        candidate.id,
        `${candidate.firstName} ${candidate.lastName}`.trim(),
      ]),
    );

    return this.mapWorkOrder(updated, userNameById);
  }

  private assertCanDispatch(user: RequestUser) {
    if (!DISPATCH_ROLES.has(user.role)) {
      throw new ForbiddenException(
        "Disposition portal requires office access.",
      );
    }
  }

  private cleanUpdatePayload(body: UpdateDispositionWorkOrderRequest) {
    const data: Prisma.WorkOrderUpdateManyMutationInput = {};

    if ("assignedUserId" in body) {
      data.assignedUserId = this.nullableString(body.assignedUserId);
    }
    if ("scheduledStart" in body) {
      data.scheduledStart = this.nullableDate(body.scheduledStart);
    }
    if ("scheduledEnd" in body) {
      data.scheduledEnd = this.nullableDate(body.scheduledEnd);
    }
    if (body.status !== undefined) {
      if (!ALLOWED_STATUSES.has(body.status)) {
        throw new BadRequestException("Invalid work order status.");
      }
      data.status = body.status;
    }
    if (body.priority !== undefined) {
      if (!ALLOWED_PRIORITIES.has(body.priority)) {
        throw new BadRequestException("Invalid work order priority.");
      }
      data.priority = body.priority;
    }

    return data;
  }

  private nullableString(value: string | null | undefined) {
    if (value === null || value === undefined || value.trim() === "") {
      return null;
    }
    return value.trim();
  }

  private nullableDate(value: string | null | undefined) {
    if (value === null || value === undefined || value.trim() === "") {
      return null;
    }
    const date = new Date(value);
    if (Number.isNaN(date.getTime())) {
      throw new BadRequestException("Invalid schedule date.");
    }
    return date;
  }

  private mapUser(user: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
    role: string;
    isActive: boolean;
  }): DispositionUserSummary {
    return {
      id: user.id,
      name: `${user.firstName} ${user.lastName}`.trim(),
      email: user.email,
      role: user.role,
      isActive: user.isActive,
    };
  }

  private mapWorkOrder(
    workOrder: WorkOrderWithRelations,
    userNameById: Map<string, string>,
  ): DispositionWorkOrderSummary {
    const scheduledEnd = workOrder.scheduledEnd;
    const isClosed =
      workOrder.status === "completed" || workOrder.status === "cancelled";
    const address = [
      workOrder.object.street,
      workOrder.object.houseNumber,
      `${workOrder.object.postalCode} ${workOrder.object.city}`.trim(),
    ]
      .filter(Boolean)
      .join(" ");

    return {
      id: workOrder.id,
      orderNumber: workOrder.orderNumber,
      title: workOrder.title,
      status: workOrder.status,
      priority: workOrder.priority,
      type: workOrder.type,
      scheduledStart: workOrder.scheduledStart?.toISOString() ?? null,
      scheduledEnd: scheduledEnd?.toISOString() ?? null,
      assignedUserId: workOrder.assignedUserId,
      assignedUserName: workOrder.assignedUserId
        ? (userNameById.get(workOrder.assignedUserId) ?? null)
        : null,
      customerName: workOrder.customer.displayName,
      objectName: workOrder.object.name,
      address,
      city: workOrder.object.city,
      isOverdue: Boolean(
        scheduledEnd && !isClosed && scheduledEnd.getTime() < Date.now(),
      ),
    };
  }
}
