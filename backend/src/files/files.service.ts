import { Injectable, NotFoundException } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { randomUUID } from "node:crypto";

import { PrismaService } from "../prisma/prisma.service";

@Injectable()
export class FilesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly config: ConfigService,
  ) {}

  async init(tenantId: string, body: Record<string, unknown>) {
    const entityType = body.entityType?.toString();
    const entityId = body.entityId?.toString();
    const fileName = body.fileName?.toString();
    const mimeType = body.mimeType?.toString() ?? "application/octet-stream";
    if (!entityType || !entityId || !fileName) {
      throw new NotFoundException(
        "entityType, entityId and fileName are required.",
      );
    }

    const upload = await this.prisma.fileUpload.create({
      data: {
        tenantId,
        entityType,
        entityId,
        fileName,
        mimeType,
        sizeBytes: this.optionalNumber(body.sizeBytes),
        storageKey: `${tenantId}/${entityType}/${entityId}/${randomUUID()}-${fileName}`,
        status: "pending",
      },
    });

    return {
      id: upload.id,
      uploadId: upload.id,
      uploadUrl: `${this.config.get<string>("UPLOAD_BASE_URL")}/${upload.id}`,
      method: "PUT",
      storageKey: upload.storageKey,
    };
  }

  async markUploaded(tenantId: string, id: string, contentLength?: string) {
    const upload = await this.findUpload(tenantId, id);
    return this.prisma.fileUpload.update({
      where: { id: upload.id },
      data: {
        status: "uploaded",
        sizeBytes: upload.sizeBytes ?? this.optionalNumber(contentLength),
      },
    });
  }

  async complete(
    tenantId: string,
    userId: string,
    body: Record<string, unknown>,
  ) {
    const id = (body.uploadId ?? body.id)?.toString();
    if (!id) {
      throw new NotFoundException("uploadId is required.");
    }

    const upload = await this.findUpload(tenantId, id);
    const completed = await this.prisma.fileUpload.update({
      where: { id: upload.id },
      data: {
        status: "completed",
        checksum: body.checksum?.toString() ?? upload.checksum,
        completedAt: new Date(),
      },
    });

    await this.prisma.auditLog.create({
      data: {
        tenantId,
        userId,
        action: "file_upload_completed",
        entityType: upload.entityType,
        entityId: upload.entityId,
        metadata: {
          uploadId: upload.id,
          storageKey: upload.storageKey,
        },
      },
    });

    return completed;
  }

  private async findUpload(tenantId: string, id: string) {
    const upload = await this.prisma.fileUpload.findFirst({
      where: {
        id,
        tenantId,
      },
    });
    if (!upload) {
      throw new NotFoundException("Upload not found.");
    }
    return upload;
  }

  private optionalNumber(value: unknown) {
    if (value === undefined || value === null || value === "") {
      return undefined;
    }
    const parsed = Number(value);
    return Number.isFinite(parsed) ? parsed : undefined;
  }
}
