import { Global, Module } from "@nestjs/common";

import { PushController } from "./push.controller";
import { FirebasePushGateway } from "./push.gateway";
import { PushService } from "./push.service";

@Global()
@Module({
  controllers: [PushController],
  providers: [FirebasePushGateway, PushService],
  exports: [PushService],
})
export class PushModule {}
