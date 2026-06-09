export type AppPermission = string;

const ROLE_PERMISSIONS: Record<string, AppPermission[]> = {
  admin: ["*"],
  dispatcher: [
    "tenancy:read",
    "disposition:read",
    "disposition:write",
    "sync:pull",
    "files:write",
    "reports:generate",
    "push:device_tokens:write",
    "entity:customers:read",
    "entity:customers:write",
    "entity:objects:read",
    "entity:objects:write",
    "entity:installations:read",
    "entity:installations:write",
    "entity:work_orders:read",
    "entity:work_orders:write",
    "entity:work_order_installations:read",
    "entity:work_order_installations:write",
    "entity:checklist_templates:read",
    "entity:checklist_template_items:read",
    "entity:checklist_answers:read",
    "entity:measurements:read",
    "entity:defects:read",
    "entity:photos:read",
    "entity:time_entries:read",
    "entity:materials:read",
    "entity:materials:write",
    "entity:work_order_materials:read",
    "entity:tariff_catalog_items:read",
    "entity:object_tariff_assignments:read",
    "entity:work_order_service_lines:read",
    "entity:report_templates:read",
    "entity:reports:read",
    "entity:reports:write",
    "entity:legacy_import_records:read",
  ],
  technician: [
    "tenancy:read",
    "sync:pull",
    "sync:push",
    "files:write",
    "reports:generate",
    "push:device_tokens:write",
    "entity:tenants:read",
    "entity:customers:read",
    "entity:objects:read",
    "entity:installations:read",
    "entity:work_orders:read",
    "entity:work_orders:write",
    "entity:work_order_installations:read",
    "entity:checklist_templates:read",
    "entity:checklist_template_items:read",
    "entity:checklist_answers:read",
    "entity:checklist_answers:write",
    "entity:measurements:read",
    "entity:measurements:write",
    "entity:defects:read",
    "entity:defects:write",
    "entity:photos:read",
    "entity:photos:write",
    "entity:time_entries:read",
    "entity:time_entries:write",
    "entity:materials:read",
    "entity:work_order_materials:read",
    "entity:work_order_materials:write",
    "entity:tariff_catalog_items:read",
    "entity:object_tariff_assignments:read",
    "entity:work_order_service_lines:read",
    "entity:work_order_service_lines:write",
    "entity:report_templates:read",
    "entity:reports:read",
    "entity:reports:write",
    "entity:legacy_import_records:read",
  ],
};

export function roleHasPermission(role: string, permission: AppPermission) {
  const permissions = ROLE_PERMISSIONS[role] ?? [];
  return permissions.includes("*") || permissions.includes(permission);
}

export function roleHasAllPermissions(
  role: string,
  permissions: AppPermission[],
) {
  return permissions.every((permission) => roleHasPermission(role, permission));
}

export function permissionsForRole(role: string) {
  return [...(ROLE_PERMISSIONS[role] ?? [])];
}
