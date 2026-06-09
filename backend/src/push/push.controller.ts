import { Body, Controller, Delete, Post } from "@nestjs/common";

import { CurrentUser } from "../common/decorators/current-user.decorator";
import { RequirePermissions } from "../common/decorators/require-permissions.decorator";
import { TenantId } from "../common/decorators/tenant-id.decorator";
import { RequestUser } from "../common/types/request-user";
import { PushService, RegisterPushDeviceTokenRequest } from "./push.service";

@Controller("push/device-tokens")
export class PushController {
  constructor(private readonly push: PushService) {}

  @RequirePermissions("push:device_tokens:write")
  @Post()
  register(
    @TenantId() tenantId: string,
    @CurrentUser() user: RequestUser,
    @Body() body: RegisterPushDeviceTokenRequest,
  ) {
    return this.push.registerDeviceToken(tenantId, user, body);
  }

  @RequirePermissions("push:device_tokens:write")
  @Delete()
  revoke(
    @TenantId() tenantId: string,
    @CurrentUser() user: RequestUser,
    @Body() body: Pick<RegisterPushDeviceTokenRequest, "token">,
  ) {
    return this.push.revokeDeviceToken(tenantId, user, body);
  }
}
