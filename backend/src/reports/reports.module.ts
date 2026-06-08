import { Module } from "@nestjs/common";

import { EntitiesModule } from "../entities/entities.module";
import { ReportsController } from "./reports.controller";
import { ReportsService } from "./reports.service";

@Module({
  imports: [EntitiesModule],
  controllers: [ReportsController],
  providers: [ReportsService],
})
export class ReportsModule {}
