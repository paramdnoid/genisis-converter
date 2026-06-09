import {
  CanActivate,
  ExecutionContext,
  ForbiddenException,
  Injectable,
  UnauthorizedException,
} from "@nestjs/common";
import { Reflector } from "@nestjs/core";

import { REQUIRED_PERMISSIONS } from "../decorators/require-permissions.decorator";
import {
  AppPermission,
  roleHasAllPermissions,
} from "../permissions/permissions";
import { AuthenticatedRequest } from "../types/request-user";

@Injectable()
export class PermissionGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  canActivate(context: ExecutionContext) {
    const required = this.reflector.getAllAndOverride<AppPermission[]>(
      REQUIRED_PERMISSIONS,
      [context.getHandler(), context.getClass()],
    );
    if (!required || required.length === 0) {
      return true;
    }

    const request = context.switchToHttp().getRequest<AuthenticatedRequest>();
    const user = request.user;
    if (!user) {
      throw new UnauthorizedException("Missing authenticated user.");
    }

    if (!roleHasAllPermissions(user.role, required)) {
      throw new ForbiddenException(
        `Missing permission: ${required.join(", ")}`,
      );
    }
    return true;
  }
}
