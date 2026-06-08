import { Module } from "@nestjs/common";

import { EntitiesModule } from "../entities/entities.module";
import { SyncController } from "./sync.controller";
import { SyncService } from "./sync.service";

@Module({
  imports: [EntitiesModule],
  controllers: [SyncController],
  providers: [SyncService],
})
export class SyncModule {}
