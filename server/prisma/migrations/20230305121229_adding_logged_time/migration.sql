/*
  Warnings:

  - The `logged_in` column on the `User` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "User" ADD COLUMN     "logged_time" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
DROP COLUMN "logged_in",
ADD COLUMN     "logged_in" BOOLEAN NOT NULL DEFAULT true;
