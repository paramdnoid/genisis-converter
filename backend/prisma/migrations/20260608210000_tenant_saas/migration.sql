-- Add SaaS tenant identity and lifecycle fields.
ALTER TABLE "tenants" ADD COLUMN "slug" TEXT;
ALTER TABLE "tenants" ADD COLUMN "plan" TEXT NOT NULL DEFAULT 'starter';
ALTER TABLE "tenants" ADD COLUMN "status" TEXT NOT NULL DEFAULT 'active';

UPDATE "tenants"
SET "slug" = COALESCE(
    NULLIF(
        TRIM(BOTH '-' FROM regexp_replace(lower("name"), '[^a-z0-9]+', '-', 'g')),
        ''
    ),
    "id"
)
WHERE "slug" IS NULL;

ALTER TABLE "tenants" ALTER COLUMN "slug" SET NOT NULL;

CREATE UNIQUE INDEX "tenants_slug_key" ON "tenants"("slug");
CREATE INDEX "tenants_status_idx" ON "tenants"("status");
