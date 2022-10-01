-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('client', 'driver', 'dispatcher');

-- CreateEnum
CREATE TYPE "CarType" AS ENUM ('client', 'driver', 'dispatcher');

-- CreateEnum
CREATE TYPE "ScheduleStatus" AS ENUM ('bookCarSuccess', 'bookCarFailed', 'clientCancelFailed', 'clientCancelSuccess', 'driverApproveSuccess', 'driverCancelSuccess', 'dispatcherCreateTicketFailed', 'dispatcherCreateTicketSuccess');

-- CreateEnum
CREATE TYPE "paymentType" AS ENUM ('cash', 'bankTransfer', 'momo');

-- CreateTable
CREATE TABLE "client" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "driver" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "driver_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "car" (
    "id" SERIAL NOT NULL,
    "driverId" INTEGER NOT NULL,
    "type" "CarType" NOT NULL,
    "licensePlates" TEXT NOT NULL,

    CONSTRAINT "car_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "schedule" (
    "id" SERIAL NOT NULL,
    "clientId" INTEGER NOT NULL,
    "driverId" INTEGER NOT NULL,
    "startPoint" TEXT NOT NULL,
    "endPoint" TEXT NOT NULL,
    "price" TEXT NOT NULL,
    "paymentType" "paymentType" NOT NULL DEFAULT 'cash',
    "status" "ScheduleStatus" NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "schedule_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "client_username_key" ON "client"("username");

-- CreateIndex
CREATE UNIQUE INDEX "driver_username_key" ON "driver"("username");

-- AddForeignKey
ALTER TABLE "car" ADD CONSTRAINT "car_driverId_fkey" FOREIGN KEY ("driverId") REFERENCES "driver"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "schedule" ADD CONSTRAINT "schedule_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "schedule" ADD CONSTRAINT "schedule_driverId_fkey" FOREIGN KEY ("driverId") REFERENCES "driver"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
