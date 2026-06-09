import { SetMetadata } from "@nestjs/common";

import { AppPermission } from "../permissions/permissions";

export const REQUIRED_PERMISSIONS = "requiredPermissions";

export const RequirePermissions = (...permissions: AppPermission[]) =>
  SetMetadata(REQUIRED_PERMISSIONS, permissions);
