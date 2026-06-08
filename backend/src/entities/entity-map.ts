export type EntityKey =
  | "tenants"
  | "users"
  | "customers"
  | "objects"
  | "installations"
  | "work_orders"
  | "work_order_installations"
  | "checklist_templates"
  | "checklist_template_items"
  | "checklist_answers"
  | "measurements"
  | "defects"
  | "photos"
  | "time_entries"
  | "materials"
  | "work_order_materials"
  | "reports";

export interface EntityDefinition {
  key: EntityKey;
  route: string;
  delegate: string;
  singular: string;
  collection: string;
  scope: "tenantRecord" | "tenantColumn";
}

export const ENTITY_DEFINITIONS: Record<EntityKey, EntityDefinition> = {
  tenants: {
    key: "tenants",
    route: "tenants",
    delegate: "tenant",
    singular: "tenant",
    collection: "tenants",
    scope: "tenantRecord",
  },
  users: {
    key: "users",
    route: "users",
    delegate: "user",
    singular: "user",
    collection: "users",
    scope: "tenantColumn",
  },
  customers: {
    key: "customers",
    route: "customers",
    delegate: "customer",
    singular: "customer",
    collection: "customers",
    scope: "tenantColumn",
  },
  objects: {
    key: "objects",
    route: "objects",
    delegate: "customerObject",
    singular: "object",
    collection: "objects",
    scope: "tenantColumn",
  },
  installations: {
    key: "installations",
    route: "installations",
    delegate: "installation",
    singular: "installation",
    collection: "installations",
    scope: "tenantColumn",
  },
  work_orders: {
    key: "work_orders",
    route: "work-orders",
    delegate: "workOrder",
    singular: "work_order",
    collection: "work_orders",
    scope: "tenantColumn",
  },
  work_order_installations: {
    key: "work_order_installations",
    route: "work-order-installations",
    delegate: "workOrderInstallation",
    singular: "work_order_installation",
    collection: "work_order_installations",
    scope: "tenantColumn",
  },
  checklist_templates: {
    key: "checklist_templates",
    route: "checklist-templates",
    delegate: "checklistTemplate",
    singular: "checklist_template",
    collection: "checklist_templates",
    scope: "tenantColumn",
  },
  checklist_template_items: {
    key: "checklist_template_items",
    route: "checklist-template-items",
    delegate: "checklistTemplateItem",
    singular: "checklist_template_item",
    collection: "checklist_template_items",
    scope: "tenantColumn",
  },
  checklist_answers: {
    key: "checklist_answers",
    route: "checklist-answers",
    delegate: "checklistAnswer",
    singular: "checklist_answer",
    collection: "checklist_answers",
    scope: "tenantColumn",
  },
  measurements: {
    key: "measurements",
    route: "measurements",
    delegate: "measurement",
    singular: "measurement",
    collection: "measurements",
    scope: "tenantColumn",
  },
  defects: {
    key: "defects",
    route: "defects",
    delegate: "defect",
    singular: "defect",
    collection: "defects",
    scope: "tenantColumn",
  },
  photos: {
    key: "photos",
    route: "photos",
    delegate: "photo",
    singular: "photo",
    collection: "photos",
    scope: "tenantColumn",
  },
  time_entries: {
    key: "time_entries",
    route: "time-entries",
    delegate: "timeEntry",
    singular: "time_entry",
    collection: "time_entries",
    scope: "tenantColumn",
  },
  materials: {
    key: "materials",
    route: "materials",
    delegate: "material",
    singular: "material",
    collection: "materials",
    scope: "tenantColumn",
  },
  work_order_materials: {
    key: "work_order_materials",
    route: "work-order-materials",
    delegate: "workOrderMaterial",
    singular: "work_order_material",
    collection: "work_order_materials",
    scope: "tenantColumn",
  },
  reports: {
    key: "reports",
    route: "reports",
    delegate: "report",
    singular: "report",
    collection: "reports",
    scope: "tenantColumn",
  },
};

const aliases = new Map<string, EntityKey>();
for (const definition of Object.values(ENTITY_DEFINITIONS)) {
  aliases.set(definition.key, definition.key);
  aliases.set(definition.route, definition.key);
  aliases.set(definition.singular, definition.key);
  aliases.set(definition.collection, definition.key);
}
aliases.set("workOrders", "work_orders");
aliases.set("workOrder", "work_orders");
aliases.set("customerObjects", "objects");
aliases.set("object", "objects");
aliases.set("checklistTemplates", "checklist_templates");
aliases.set("checklistTemplate", "checklist_templates");
aliases.set("checklistTemplateItems", "checklist_template_items");
aliases.set("checklistTemplateItem", "checklist_template_items");
aliases.set("checklistAnswers", "checklist_answers");
aliases.set("checklistAnswer", "checklist_answers");
aliases.set("workOrderInstallations", "work_order_installations");
aliases.set("workOrderInstallation", "work_order_installations");
aliases.set("timeEntries", "time_entries");
aliases.set("timeEntry", "time_entries");
aliases.set("workOrderMaterials", "work_order_materials");
aliases.set("workOrderMaterial", "work_order_materials");

export function normalizeEntityKey(value: string): EntityKey | undefined {
  return aliases.get(value.trim());
}

export const SYNC_ENTITY_KEYS: EntityKey[] = [
  "tenants",
  "users",
  "customers",
  "objects",
  "installations",
  "work_orders",
  "work_order_installations",
  "checklist_templates",
  "checklist_template_items",
  "checklist_answers",
  "measurements",
  "defects",
  "photos",
  "time_entries",
  "materials",
  "work_order_materials",
  "reports",
];
