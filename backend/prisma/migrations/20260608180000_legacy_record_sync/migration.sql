-- AlterTable
ALTER TABLE "legacy_import_records"
ADD COLUMN "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN "deleted_at" TIMESTAMP(3),
ADD COLUMN "version" INTEGER NOT NULL DEFAULT 1,
ADD COLUMN "sync_status" TEXT NOT NULL DEFAULT 'synced',
ADD COLUMN "last_synced_at" TIMESTAMP(3);

-- CreateIndex
CREATE INDEX "legacy_records_tenant_updated_idx" ON "legacy_import_records"("tenant_id", "updated_at");
