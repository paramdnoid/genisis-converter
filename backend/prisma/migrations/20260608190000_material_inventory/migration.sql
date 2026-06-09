-- Add optional stock management fields to the material catalog.
ALTER TABLE "materials" ADD COLUMN "stock_quantity" DOUBLE PRECISION;
ALTER TABLE "materials" ADD COLUMN "min_stock_quantity" DOUBLE PRECISION;
