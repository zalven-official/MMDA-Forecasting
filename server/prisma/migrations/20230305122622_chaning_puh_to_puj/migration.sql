/*
  Warnings:

  - The values [PUH] on the enum `VehicleTypeEnum` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "VehicleTypeEnum_new" AS ENUM ('BIKE', 'MOTORCYCLE', 'TRICYCLE', 'CAR', 'PUJ', 'AUV', 'BUS', 'VAN', 'TRUCK');
ALTER TABLE "VehicleType" ALTER COLUMN "vehicle_type" DROP DEFAULT;
ALTER TABLE "VehicleType" ALTER COLUMN "vehicle_type" TYPE "VehicleTypeEnum_new" USING ("vehicle_type"::text::"VehicleTypeEnum_new");
ALTER TYPE "VehicleTypeEnum" RENAME TO "VehicleTypeEnum_old";
ALTER TYPE "VehicleTypeEnum_new" RENAME TO "VehicleTypeEnum";
DROP TYPE "VehicleTypeEnum_old";
ALTER TABLE "VehicleType" ALTER COLUMN "vehicle_type" SET DEFAULT 'CAR';
COMMIT;
