import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
  Type,
} from "@nestjs/common";

import { TenantId } from "../common/decorators/tenant-id.decorator";
import { EntityCrudService } from "./entity-crud.service";
import { ENTITY_DEFINITIONS, EntityKey } from "./entity-map";

function pascalCase(value: string) {
  return value
    .split(/[-_]/)
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join("");
}

function createCrudController(route: string, entity: EntityKey): Type<unknown> {
  @Controller(route)
  class GeneratedCrudController {
    constructor(private readonly service: EntityCrudService) {}

    @Get()
    list(@TenantId() tenantId: string, @Query() query: Record<string, string>) {
      return this.service.list(entity, tenantId, query);
    }

    @Post()
    create(
      @TenantId() tenantId: string,
      @Body() body: Record<string, unknown>,
    ) {
      return this.service.create(entity, tenantId, body);
    }

    @Get(":id")
    get(@TenantId() tenantId: string, @Param("id") id: string) {
      return this.service.get(entity, tenantId, id);
    }

    @Patch(":id")
    update(
      @TenantId() tenantId: string,
      @Param("id") id: string,
      @Body() body: Record<string, unknown>,
    ) {
      return this.service.update(entity, tenantId, id, body);
    }

    @Delete(":id")
    delete(@TenantId() tenantId: string, @Param("id") id: string) {
      return this.service.softDelete(entity, tenantId, id);
    }
  }

  Object.defineProperty(GeneratedCrudController, "name", {
    value: `${pascalCase(route)}Controller`,
  });
  return GeneratedCrudController;
}

export const CRUD_CONTROLLERS = Object.values(ENTITY_DEFINITIONS)
  .filter((definition) => definition.key !== "reports")
  .map((definition) => createCrudController(definition.route, definition.key));
