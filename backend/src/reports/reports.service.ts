import { Injectable, NotFoundException } from "@nestjs/common";

import { EntityCrudService } from "../entities/entity-crud.service";

@Injectable()
export class ReportsService {
  constructor(private readonly crud: EntityCrudService) {}

  async generate(tenantId: string, body: Record<string, unknown>) {
    const workOrderId = body.workOrderId?.toString();
    if (!workOrderId) {
      throw new NotFoundException(
        "workOrderId is required to generate a report.",
      );
    }

    const workOrder = await this.crud.get("work_orders", tenantId, workOrderId);
    const reportNumber =
      body.reportNumber?.toString() ??
      `R-${new Date().toISOString().slice(0, 10).replaceAll("-", "")}-${String(
        workOrder.orderNumber ?? workOrderId.slice(0, 8),
      )}`;

    return this.crud.create("reports", tenantId, {
      workOrderId,
      reportNumber,
      status: body.status?.toString() ?? "generated",
      pdfLocalPath: body.pdfLocalPath ?? null,
      pdfRemoteUrl: body.pdfRemoteUrl ?? null,
      generatedAt: new Date(),
      signedAt: body.signedAt ?? null,
      customerNameSigned: body.customerNameSigned ?? null,
    });
  }
}
