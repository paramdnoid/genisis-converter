-- CreateTable
CREATE TABLE "tariff_catalog_items" (
    "id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "tariff_system" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "default_price" DOUBLE PRECISION,
    "tax_category" TEXT,
    "tax_points" DOUBLE PRECISION,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "version" INTEGER NOT NULL DEFAULT 1,
    "sync_status" TEXT NOT NULL DEFAULT 'synced',
    "last_synced_at" TIMESTAMP(3),
    "source_system" TEXT,
    "source_file" TEXT,
    "source_table" TEXT,
    "source_key" TEXT,

    CONSTRAINT "tariff_catalog_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "object_tariff_assignments" (
    "id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "object_id" TEXT,
    "tariff_catalog_item_id" TEXT,
    "tariff_system" TEXT NOT NULL,
    "code" TEXT,
    "description" TEXT NOT NULL,
    "position" INTEGER,
    "default_quantity" DOUBLE PRECISION,
    "unit" TEXT,
    "price_override" DOUBLE PRECISION,
    "tax_points" DOUBLE PRECISION,
    "billing_code" TEXT,
    "interval_code" TEXT,
    "flag_13" TEXT,
    "flag_14" TEXT,
    "flag_15" TEXT,
    "notes" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "version" INTEGER NOT NULL DEFAULT 1,
    "sync_status" TEXT NOT NULL DEFAULT 'synced',
    "last_synced_at" TIMESTAMP(3),
    "source_system" TEXT,
    "source_file" TEXT,
    "source_table" TEXT,
    "source_key" TEXT,

    CONSTRAINT "object_tariff_assignments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "work_order_service_lines" (
    "id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "work_order_id" TEXT NOT NULL,
    "object_tariff_assignment_id" TEXT,
    "tariff_catalog_item_id" TEXT,
    "installation_id" TEXT,
    "code" TEXT,
    "name" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION NOT NULL,
    "unit" TEXT NOT NULL,
    "unit_price" DOUBLE PRECISION,
    "total_price" DOUBLE PRECISION,
    "tax_points" DOUBLE PRECISION,
    "status" TEXT NOT NULL DEFAULT 'performed',
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "version" INTEGER NOT NULL DEFAULT 1,
    "sync_status" TEXT NOT NULL DEFAULT 'synced',
    "last_synced_at" TIMESTAMP(3),

    CONSTRAINT "work_order_service_lines_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "tariff_catalog_tenant_source_key" ON "tariff_catalog_items"("tenant_id", "source_system", "source_key");

-- CreateIndex
CREATE INDEX "tariff_catalog_tenant_system_code_idx" ON "tariff_catalog_items"("tenant_id", "tariff_system", "code");

-- CreateIndex
CREATE INDEX "tariff_catalog_items_tenant_id_updated_at_idx" ON "tariff_catalog_items"("tenant_id", "updated_at");

-- CreateIndex
CREATE UNIQUE INDEX "object_tariffs_tenant_source_key" ON "object_tariff_assignments"("tenant_id", "source_system", "source_key");

-- CreateIndex
CREATE INDEX "object_tariffs_tenant_object_idx" ON "object_tariff_assignments"("tenant_id", "object_id");

-- CreateIndex
CREATE INDEX "object_tariffs_tenant_system_code_idx" ON "object_tariff_assignments"("tenant_id", "tariff_system", "code");

-- CreateIndex
CREATE INDEX "object_tariff_assignments_tenant_id_updated_at_idx" ON "object_tariff_assignments"("tenant_id", "updated_at");

-- CreateIndex
CREATE INDEX "work_order_service_lines_tenant_order_idx" ON "work_order_service_lines"("tenant_id", "work_order_id");

-- CreateIndex
CREATE INDEX "work_order_service_lines_tenant_id_updated_at_idx" ON "work_order_service_lines"("tenant_id", "updated_at");

-- AddForeignKey
ALTER TABLE "tariff_catalog_items" ADD CONSTRAINT "tariff_catalog_items_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "object_tariff_assignments" ADD CONSTRAINT "object_tariff_assignments_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "object_tariff_assignments" ADD CONSTRAINT "object_tariff_assignments_object_id_fkey" FOREIGN KEY ("object_id") REFERENCES "objects"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "object_tariff_assignments" ADD CONSTRAINT "object_tariff_assignments_tariff_catalog_item_id_fkey" FOREIGN KEY ("tariff_catalog_item_id") REFERENCES "tariff_catalog_items"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "work_order_service_lines" ADD CONSTRAINT "work_order_service_lines_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "work_order_service_lines" ADD CONSTRAINT "work_order_service_lines_work_order_id_fkey" FOREIGN KEY ("work_order_id") REFERENCES "work_orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "work_order_service_lines" ADD CONSTRAINT "work_order_service_lines_object_tariff_assignment_id_fkey" FOREIGN KEY ("object_tariff_assignment_id") REFERENCES "object_tariff_assignments"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "work_order_service_lines" ADD CONSTRAINT "work_order_service_lines_tariff_catalog_item_id_fkey" FOREIGN KEY ("tariff_catalog_item_id") REFERENCES "tariff_catalog_items"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "work_order_service_lines" ADD CONSTRAINT "work_order_service_lines_installation_id_fkey" FOREIGN KEY ("installation_id") REFERENCES "installations"("id") ON DELETE SET NULL ON UPDATE CASCADE;
