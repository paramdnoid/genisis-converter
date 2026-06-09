import {
  MiddlewareConsumer,
  Module,
  NestModule,
  RequestMethod,
} from "@nestjs/common";
import { ConfigModule } from "@nestjs/config";
import { APP_GUARD } from "@nestjs/core";
import { JwtModule } from "@nestjs/jwt";

import { AuthModule } from "./auth/auth.module";
import { JwtAuthGuard } from "./common/guards/jwt-auth.guard";
import { PermissionGuard } from "./common/guards/permission.guard";
import { TenantMiddleware } from "./common/middleware/tenant.middleware";
import { envValidation } from "./config/env";
import { DispositionModule } from "./disposition/disposition.module";
import { EntitiesModule } from "./entities/entities.module";
import { FilesModule } from "./files/files.module";
import { HealthModule } from "./health/health.module";
import { PrismaModule } from "./prisma/prisma.module";
import { PushModule } from "./push/push.module";
import { ReportsModule } from "./reports/reports.module";
import { SyncModule } from "./sync/sync.module";
import { TenancyModule } from "./tenancy/tenancy.module";

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: [".env", ".env.local"],
      isGlobal: true,
      validate: envValidation,
    }),
    JwtModule.register({ global: true }),
    PrismaModule,
    HealthModule,
    AuthModule,
    PushModule,
    EntitiesModule,
    ReportsModule,
    FilesModule,
    SyncModule,
    DispositionModule,
    TenancyModule,
  ],
  providers: [
    {
      provide: APP_GUARD,
      useClass: JwtAuthGuard,
    },
    {
      provide: APP_GUARD,
      useClass: PermissionGuard,
    },
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(TenantMiddleware)
      .exclude(
        { path: "health", method: RequestMethod.GET },
        { path: "auth/login", method: RequestMethod.POST },
        { path: "auth/refresh", method: RequestMethod.POST },
      )
      .forRoutes("*");
  }
}
