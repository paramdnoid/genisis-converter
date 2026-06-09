import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
} from "@nestjs/common";

import { RequirePermissions } from "../common/decorators/require-permissions.decorator";
import { TenantId } from "../common/decorators/tenant-id.decorator";
import { EntityCrudService } from "../entities/entity-crud.service";
import { ReportsService } from "./reports.service";

@Controller("reports")
export class ReportsController {
  constructor(
    private readonly crud: EntityCrudService,
    private readonly reports: ReportsService,
  ) {}

  @RequirePermissions("reports:generate")
  @Post("generate")
  generate(
    @TenantId() tenantId: string,
    @Body() body: Record<string, unknown>,
  ) {
    return this.reports.generate(tenantId, body);
  }

  @RequirePermissions("entity:reports:read")
  @Get()
  list(@TenantId() tenantId: string, @Query() query: Record<string, string>) {
    return this.crud.list("reports", tenantId, query);
  }

  @RequirePermissions("entity:reports:write")
  @Post()
  create(@TenantId() tenantId: string, @Body() body: Record<string, unknown>) {
    return this.crud.create("reports", tenantId, body);
  }

  @RequirePermissions("entity:reports:read")
  @Get(":id")
  get(@TenantId() tenantId: string, @Param("id") id: string) {
    return this.crud.get("reports", tenantId, id);
  }

  @RequirePermissions("entity:reports:write")
  @Patch(":id")
  update(
    @TenantId() tenantId: string,
    @Param("id") id: string,
    @Body() body: Record<string, unknown>,
  ) {
    return this.crud.update("reports", tenantId, id, body);
  }

  @RequirePermissions("entity:reports:delete")
  @Delete(":id")
  delete(@TenantId() tenantId: string, @Param("id") id: string) {
    return this.crud.softDelete("reports", tenantId, id);
  }
}
