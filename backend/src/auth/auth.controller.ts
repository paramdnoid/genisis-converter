import { Body, Controller, Get, Post } from "@nestjs/common";

import { CurrentUser } from "../common/decorators/current-user.decorator";
import { Public } from "../common/decorators/public.decorator";
import { RequestUser } from "../common/types/request-user";
import { AuthService, LoginRequest, RefreshRequest } from "./auth.service";

@Controller("auth")
export class AuthController {
  constructor(private readonly auth: AuthService) {}

  @Public()
  @Post("login")
  login(@Body() body: LoginRequest) {
    return this.auth.login(body);
  }

  @Public()
  @Post("refresh")
  refresh(@Body() body: RefreshRequest) {
    return this.auth.refresh(body);
  }

  @Post("logout")
  logout() {
    return { ok: true };
  }
}

@Controller()
export class MeController {
  constructor(private readonly auth: AuthService) {}

  @Get("me")
  me(@CurrentUser() user: RequestUser) {
    return this.auth.me(user);
  }
}
