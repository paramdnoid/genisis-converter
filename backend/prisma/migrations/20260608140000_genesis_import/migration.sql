-- AlterTable
ALTER TABLE "users" ADD COLUMN "source_system" TEXT,
ADD COLUMN "source_file" TEXT,
ADD COLUMN "source_table" TEXT,
ADD COLUMN "source_key" TEXT;

-- AlterTable
ALTER TABLE "customers" ADD COLUMN "source_system" TEXT,
ADD COLUMN "source_file" TEXT,
ADD COLUMN "source_table" TEXT,
ADD COLUMN "source_key" TEXT;

-- AlterTable
ALTER TABLE "objects" ADD COLUMN "source_system" TEXT,
ADD COLUMN "source_file" TEXT,
ADD COLUMN "source_table" TEXT,
ADD COLUMN "source_key" TEXT;

-- AlterTable
ALTER TABLE "installations" ADD COLUMN "source_system" TEXT,
ADD COLUMN "source_file" TEXT,
ADD COLUMN "source_table" TEXT,
ADD COLUMN "source_key" TEXT;

-- CreateTable
CREATE TABLE "legacy_import_batches" (
    "id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "source_system" TEXT NOT NULL DEFAULT 'genesis',
    "archive_path" TEXT NOT NULL,
    "archive_sha256" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "started_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completed_at" TIMESTAMP(3),
    "counts" JSONB,
    "warnings" JSONB,
    "summary" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "legacy_import_batches_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "legacy_import_records" (
    "id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "batch_id" TEXT NOT NULL,
    "source_system" TEXT NOT NULL DEFAULT 'genesis',
    "source_file" TEXT NOT NULL,
    "source_table" TEXT NOT NULL,
    "source_key" TEXT NOT NULL,
    "row_hash" TEXT NOT NULL,
    "row_index" INTEGER,
    "record_type" TEXT NOT NULL DEFAULT 'row',
    "mapped_entity_type" TEXT,
    "mapped_entity_id" TEXT,
    "payload" JSONB NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "legacy_import_records_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_tenant_source_key" ON "users"("tenant_id", "source_system", "source_key");

-- CreateIndex
CREATE UNIQUE INDEX "customers_tenant_source_key" ON "customers"("tenant_id", "source_system", "source_key");

-- CreateIndex
CREATE UNIQUE INDEX "objects_tenant_source_key" ON "objects"("tenant_id", "source_system", "source_key");

-- CreateIndex
CREATE UNIQUE INDEX "installations_tenant_source_key" ON "installations"("tenant_id", "source_system", "source_key");

-- CreateIndex
CREATE INDEX "legacy_batches_tenant_created_idx" ON "legacy_import_batches"("tenant_id", "created_at");

-- CreateIndex
CREATE INDEX "legacy_batches_archive_sha_idx" ON "legacy_import_batches"("archive_sha256");

-- CreateIndex
CREATE UNIQUE INDEX "legacy_records_batch_source_key" ON "legacy_import_records"("batch_id", "source_file", "source_table", "source_key");

-- CreateIndex
CREATE INDEX "legacy_records_source_idx" ON "legacy_import_records"("tenant_id", "source_file", "source_table");

-- CreateIndex
CREATE INDEX "legacy_records_mapped_idx" ON "legacy_import_records"("tenant_id", "mapped_entity_type", "mapped_entity_id");

-- AddForeignKey
ALTER TABLE "legacy_import_batches" ADD CONSTRAINT "legacy_import_batches_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "legacy_import_records" ADD CONSTRAINT "legacy_import_records_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "legacy_import_records" ADD CONSTRAINT "legacy_import_records_batch_id_fkey" FOREIGN KEY ("batch_id") REFERENCES "legacy_import_batches"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
