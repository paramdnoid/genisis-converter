import { Body, Controller, Get, Patch, Post } from "@nestjs/common";

import { CurrentUser } from "../common/decorators/current-user.decorator";
import { Public } from "../common/decorators/public.decorator";
import { RequirePermissions } from "../common/decorators/require-permissions.decorator";
import { TenantId } from "../common/decorators/tenant-id.decorator";
import { RequestUser } from "../common/types/request-user";
import {
  TenancyService,
  TenantSignupRequest,
  UpdateTenantRequest,
} from "./tenancy.service";

@Controller("tenancy")
export class TenancyController {
  constructor(private readonly tenancy: TenancyService) {}

  @Public()
  @Post("signup")
  signup(@Body() body: TenantSignupRequest) {
    return this.tenancy.signup(body);
  }

  @RequirePermissions("tenancy:read")
  @Get("current")
  current(@TenantId() tenantId: string) {
    return this.tenancy.current(tenantId);
  }

  @RequirePermissions("tenancy:write")
  @Patch("current")
  updateCurrent(
    @TenantId() tenantId: string,
    @CurrentUser() user: RequestUser,
    @Body() body: UpdateTenantRequest,
  ) {
    return this.tenancy.updateCurrent(tenantId, user, body);
  }
}
