/*
  Warnings:

  - You are about to drop the column `restaurantId` on the `Listing` table. All the data in the column will be lost.
  - You are about to drop the column `restaurantId` on the `OperatingHours` table. All the data in the column will be lost.
  - You are about to drop the column `isRestaurantHost` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `restaurantId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Restaurant` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `RestaurantImage` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[workspaceId,dayOfWeek]` on the table `OperatingHours` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `workspaceId` to the `OperatingHours` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Listing" DROP CONSTRAINT "Listing_restaurantId_fkey";

-- DropForeignKey
ALTER TABLE "OperatingHours" DROP CONSTRAINT "OperatingHours_restaurantId_fkey";

-- DropForeignKey
ALTER TABLE "Restaurant" DROP CONSTRAINT "Restaurant_hostId_fkey";

-- DropForeignKey
ALTER TABLE "RestaurantImage" DROP CONSTRAINT "RestaurantImage_restaurantId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_restaurantId_fkey";

-- DropIndex
DROP INDEX "OperatingHours_restaurantId_dayOfWeek_key";

-- AlterTable
ALTER TABLE "Listing" DROP COLUMN "restaurantId",
ADD COLUMN     "workspaceId" INTEGER;

-- AlterTable
ALTER TABLE "OperatingHours" DROP COLUMN "restaurantId",
ADD COLUMN     "workspaceId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "isRestaurantHost",
DROP COLUMN "restaurantId",
ADD COLUMN     "isWorkspaceHost" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "workspaceId" INTEGER;

-- DropTable
DROP TABLE "Restaurant";

-- DropTable
DROP TABLE "RestaurantImage";

-- CreateTable
CREATE TABLE "Workspace" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "address" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "zipCode" TEXT NOT NULL,
    "phone" TEXT,
    "email" TEXT,
    "website" TEXT,
    "workspaceType" TEXT,
    "priceRange" TEXT,
    "rating" DOUBLE PRECISION DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "hostId" INTEGER NOT NULL,

    CONSTRAINT "Workspace_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkspaceImage" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "caption" TEXT,
    "isPrimary" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "workspaceId" INTEGER NOT NULL,

    CONSTRAINT "WorkspaceImage_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Workspace_hostId_key" ON "Workspace"("hostId");

-- CreateIndex
CREATE UNIQUE INDEX "OperatingHours_workspaceId_dayOfWeek_key" ON "OperatingHours"("workspaceId", "dayOfWeek");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "Workspace"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Workspace" ADD CONSTRAINT "Workspace_hostId_fkey" FOREIGN KEY ("hostId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Listing" ADD CONSTRAINT "Listing_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkspaceImage" ADD CONSTRAINT "WorkspaceImage_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OperatingHours" ADD CONSTRAINT "OperatingHours_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;
