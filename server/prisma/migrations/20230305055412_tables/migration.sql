/*
  Warnings:

  - The `role` column on the `User` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Added the required column `description` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `logged_in` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `profile_picture` to the `User` table without a default value. This is not possible if the table is not empty.
  - Made the column `password` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- CreateEnum
CREATE TYPE "RoleEnum" AS ENUM ('USER', 'STUDENT', 'ADMIN');

-- CreateEnum
CREATE TYPE "MonthEnum" AS ENUM ('JANUARY', 'FEBUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER');

-- CreateEnum
CREATE TYPE "VehicleTypeEnum" AS ENUM ('BIKE', 'MOTORCYCLE', 'TRICYCLE', 'CAR', 'PUH', 'AUV', 'BUS', 'VAN', 'TRUCK');

-- CreateEnum
CREATE TYPE "AgeTypeEnum" AS ENUM ('TEEN', 'YOUNG_ADULT', 'ADULT', 'OLDER_ADULT', 'ELDER');

-- CreateEnum
CREATE TYPE "CollisionTypeEnum" AS ENUM ('ANGLE_IMPACT', 'HEAD_ON', 'HIT_AND_RUN', 'HIT_PEDESTRIAN', 'HIT_PARKED_VEHICLE', 'MULTIPLE_COLLISION', 'REAR_END', 'SIDE_SWIPE', 'HIT_OBJECT', 'NO_COLLISION_STATED', 'NOT_STATED', 'SELF_ACCIDENT');

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "description" TEXT NOT NULL,
ADD COLUMN     "logged_in" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "profile_picture" BYTEA NOT NULL,
DROP COLUMN "role",
ADD COLUMN     "role" "RoleEnum" NOT NULL DEFAULT 'USER',
ALTER COLUMN "password" SET NOT NULL;

-- DropEnum
DROP TYPE "Role";

-- CreateTable
CREATE TABLE "Hourly" (
    "id" SERIAL NOT NULL,
    "year" INTEGER NOT NULL,
    "time_hour" TEXT NOT NULL,
    "damage_to_property" INTEGER,
    "fatal" INTEGER,
    "non_fatal_injury" INTEGER,
    "grand_total" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_id" INTEGER NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by_id" INTEGER NOT NULL,
    "file" BYTEA,
    "description" TEXT,

    CONSTRAINT "Hourly_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Monthly" (
    "id" SERIAL NOT NULL,
    "year" INTEGER NOT NULL,
    "month" "MonthEnum" NOT NULL,
    "damage_to_property" INTEGER,
    "fatal" INTEGER,
    "non_fatal_injury" INTEGER,
    "grand_total" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_id" INTEGER NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by_id" INTEGER NOT NULL,
    "description" TEXT,
    "file" BYTEA,

    CONSTRAINT "Monthly_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CollisionType" (
    "id" SERIAL NOT NULL,
    "year" INTEGER NOT NULL,
    "collision_type" "CollisionTypeEnum" NOT NULL DEFAULT 'HIT_AND_RUN',
    "damage_to_property" INTEGER,
    "fatal" INTEGER,
    "non_fatal_injury" INTEGER,
    "grand_total" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_id" INTEGER NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by_id" INTEGER NOT NULL,
    "description" TEXT,
    "file" BYTEA,

    CONSTRAINT "CollisionType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Age" (
    "id" SERIAL NOT NULL,
    "year" INTEGER NOT NULL,
    "age" "AgeTypeEnum" NOT NULL DEFAULT 'TEEN',
    "damage_to_property" INTEGER,
    "fatal" INTEGER,
    "non_fatal_injury" INTEGER,
    "grand_total" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_id" INTEGER NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by_id" INTEGER NOT NULL,
    "description" TEXT,
    "file" BYTEA,

    CONSTRAINT "Age_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VehicleType" (
    "id" SERIAL NOT NULL,
    "year" INTEGER NOT NULL,
    "vehicle_type" "VehicleTypeEnum" NOT NULL DEFAULT 'CAR',
    "damage_to_property" INTEGER,
    "fatal" INTEGER,
    "non_fatal_injury" INTEGER,
    "grand_total" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_id" INTEGER NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "updated_by_id" INTEGER NOT NULL,
    "description" TEXT,
    "file" BYTEA,

    CONSTRAINT "VehicleType_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Hourly" ADD CONSTRAINT "Hourly_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Hourly" ADD CONSTRAINT "Hourly_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Monthly" ADD CONSTRAINT "Monthly_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Monthly" ADD CONSTRAINT "Monthly_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CollisionType" ADD CONSTRAINT "CollisionType_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CollisionType" ADD CONSTRAINT "CollisionType_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Age" ADD CONSTRAINT "Age_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Age" ADD CONSTRAINT "Age_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VehicleType" ADD CONSTRAINT "VehicleType_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VehicleType" ADD CONSTRAINT "VehicleType_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
