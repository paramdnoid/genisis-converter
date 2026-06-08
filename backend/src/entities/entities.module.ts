import { Module } from "@nestjs/common";

import { CRUD_CONTROLLERS } from "./crud-controllers";
import { EntityCrudService } from "./entity-crud.service";

@Module({
  controllers: [...CRUD_CONTROLLERS],
  providers: [EntityCrudService],
  exports: [EntityCrudService],
})
export class EntitiesModule {}
