import {
  Body,
  Controller,
  Get,
  Header,
  Param,
  Patch,
  Res,
} from "@nestjs/common";
import { Response } from "express";

import { CurrentUser } from "../common/decorators/current-user.decorator";
import { Public } from "../common/decorators/public.decorator";
import { RequirePermissions } from "../common/decorators/require-permissions.decorator";
import { TenantId } from "../common/decorators/tenant-id.decorator";
import { RequestUser } from "../common/types/request-user";
import {
  DISPOSITION_PORTAL_CSS,
  DISPOSITION_PORTAL_HTML,
  DISPOSITION_PORTAL_JS,
} from "./disposition-portal.assets";
import { DispositionService } from "./disposition.service";
import { UpdateDispositionWorkOrderRequest } from "./disposition.types";

@Controller("disposition")
export class DispositionController {
  constructor(private readonly disposition: DispositionService) {}

  @Public()
  @Get()
  @Header("Cache-Control", "no-store")
  index(@Res() response: Response) {
    response.type("html").send(DISPOSITION_PORTAL_HTML);
  }

  @Public()
  @Get("app.css")
  @Header("Cache-Control", "public, max-age=300")
  stylesheet(@Res() response: Response) {
    response.type("css").send(DISPOSITION_PORTAL_CSS);
  }

  @Public()
  @Get("app.js")
  @Header("Cache-Control", "public, max-age=300")
  script(@Res() response: Response) {
    response.type("application/javascript").send(DISPOSITION_PORTAL_JS);
  }

  @RequirePermissions("disposition:read")
  @Get("api/snapshot")
  snapshot(@TenantId() tenantId: string, @CurrentUser() user: RequestUser) {
    return this.disposition.snapshot(tenantId, user);
  }

  @RequirePermissions("disposition:write")
  @Patch("api/work-orders/:id")
  updateWorkOrder(
    @TenantId() tenantId: string,
    @CurrentUser() user: RequestUser,
    @Param("id") workOrderId: string,
    @Body() body: UpdateDispositionWorkOrderRequest,
  ) {
    return this.disposition.updateWorkOrder(tenantId, user, workOrderId, body);
  }
}
