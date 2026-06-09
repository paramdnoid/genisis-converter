import { Body, Controller, Get, Post, Query } from "@nestjs/common";

import { CurrentUser } from "../common/decorators/current-user.decorator";
import { RequirePermissions } from "../common/decorators/require-permissions.decorator";
import { TenantId } from "../common/decorators/tenant-id.decorator";
import { RequestUser } from "../common/types/request-user";
import { SyncService } from "./sync.service";

@Controller("sync")
export class SyncController {
  constructor(private readonly sync: SyncService) {}

  @RequirePermissions("sync:pull")
  @Get("pull")
  pull(@TenantId() tenantId: string, @Query() query: Record<string, string>) {
    return this.sync.pull(tenantId, query);
  }

  @RequirePermissions("sync:push")
  @Post("push")
  push(
    @TenantId() tenantId: string,
    @CurrentUser() user: RequestUser,
    @Body() body: Record<string, unknown>,
  ) {
    return this.sync.push(tenantId, user.id, body);
  }
}
