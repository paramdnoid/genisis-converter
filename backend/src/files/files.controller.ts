import { Body, Controller, Param, Post, Put, Req } from "@nestjs/common";
import { Request } from "express";

import { CurrentUser } from "../common/decorators/current-user.decorator";
import { RequirePermissions } from "../common/decorators/require-permissions.decorator";
import { TenantId } from "../common/decorators/tenant-id.decorator";
import { RequestUser } from "../common/types/request-user";
import { FilesService } from "./files.service";

@Controller("files/upload")
export class FilesController {
  constructor(private readonly files: FilesService) {}

  @RequirePermissions("files:write")
  @Post("init")
  init(@TenantId() tenantId: string, @Body() body: Record<string, unknown>) {
    return this.files.init(tenantId, body);
  }

  @RequirePermissions("files:write")
  @Put(":id")
  put(
    @TenantId() tenantId: string,
    @Param("id") id: string,
    @Req() request: Request,
  ) {
    return this.files.markUploaded(
      tenantId,
      id,
      request.headers["content-length"]?.toString(),
    );
  }

  @RequirePermissions("files:write")
  @Post("complete")
  complete(
    @TenantId() tenantId: string,
    @CurrentUser() user: RequestUser,
    @Body() body: Record<string, unknown>,
  ) {
    return this.files.complete(tenantId, user.id, body);
  }
}
