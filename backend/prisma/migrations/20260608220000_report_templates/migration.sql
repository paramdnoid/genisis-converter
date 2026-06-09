CREATE TABLE "report_templates" (
    "id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "report_type" TEXT NOT NULL DEFAULT 'work_order',
    "title_prefix" TEXT NOT NULL DEFAULT 'Rapport',
    "locale" TEXT NOT NULL DEFAULT 'de',
    "primary_color" TEXT NOT NULL DEFAULT '#1f2937',
    "footer_text" TEXT,
    "include_customer" BOOLEAN NOT NULL DEFAULT true,
    "include_installations" BOOLEAN NOT NULL DEFAULT true,
    "include_measurements" BOOLEAN NOT NULL DEFAULT true,
    "include_defects" BOOLEAN NOT NULL DEFAULT true,
    "include_materials" BOOLEAN NOT NULL DEFAULT true,
    "include_time_entries" BOOLEAN NOT NULL DEFAULT true,
    "include_photos" BOOLEAN NOT NULL DEFAULT true,
    "include_signature" BOOLEAN NOT NULL DEFAULT true,
    "is_default" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "version" INTEGER NOT NULL DEFAULT 1,
    "sync_status" TEXT NOT NULL DEFAULT 'synced',
    "last_synced_at" TIMESTAMP(3),

    CONSTRAINT "report_templates_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "report_templates_tenant_name_key" ON "report_templates"("tenant_id", "name");
CREATE INDEX "report_templates_tenant_default_idx" ON "report_templates"("tenant_id", "is_default");
CREATE INDEX "report_templates_tenant_id_updated_at_idx" ON "report_templates"("tenant_id", "updated_at");

ALTER TABLE "report_templates" ADD CONSTRAINT "report_templates_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
