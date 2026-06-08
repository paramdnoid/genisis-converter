import { createParamDecorator, ExecutionContext } from "@nestjs/common";

import { AuthenticatedRequest, RequestUser } from "../types/request-user";

export const CurrentUser = createParamDecorator(
  (_data: unknown, context: ExecutionContext): RequestUser | undefined => {
    const request = context.switchToHttp().getRequest<AuthenticatedRequest>();
    return request.user;
  },
);
