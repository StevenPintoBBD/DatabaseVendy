--Stored Procedures
USE VendyDB;
GO
--Add Transaction to table When a new employee interacts)
CREATE PROCEDURE [dbo].[uspAddTransactionNewEmployee]
	@TransactionDate Date,
	@ItemId int,
	@FirstName varChar(50),
	@LastName varChar(50),
	@AllocatedCredits int
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO [dbo].[Employee]
				([First_name]
				,[Last_name]
				,[Allocated_credits])
			VALUES
				(@FirstName,@LastName,@AllocatedCredits)

			DECLARE @EmployeeId int
			SET @EmployeeId = SCOPE_IDENTITY()

			INSERT INTO [dbo].[Transactions]
				([Transaction_date]
				,[Item_ID]
				,[Employee_ID])
			VALUES
				(@TransactionDate, @ItemId, @EmployeeId)

				COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
END
GO

CREATE PROCEDURE [dbo].[uspAddTransactionPastEmployee]
	@TransactionDate Date,
	@ItemId int,
	@EmployeeId int
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO [dbo].[Transactions]
				([Transaction_date]
				,[Item_ID]
				,[Employee_ID])
			VALUES
				(@TransactionDate, @ItemId, @EmployeeId)

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
END
GO

--Add Vending machine new locations
CREATE PROCEDURE [dbo].[uspAddVendingMachineNewLocation]
	@PostCode int,
	@City varchar(50),
	@BranchName varchar(100),
	@RoomFloor int,
	@RoomName varchar(50),
	@TotalRevenue float,
	@Capacity int
AS

BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			--First insert into location
			INSERT INTO [dbo].[BranchLocation]
				([Postcode]
				,[City])
			VALUES
				(@PostCode, @City)

			INSERT INTO [dbo].[Branch]
				([Branch_name]
				,[Postcode])
			VALUES
				(@BranchName, @PostCode)
			
			DECLARE @BranchId int;
			SET @BranchId = SCOPE_IDENTITY()

			INSERT INTO [dbo].[Room]
				([Branch_ID]
				,[Room_name]
				,[Room_floor]
				)
			VALUES
				(@BranchId, @RoomName, @RoomFloor)

			DECLARE @RoomId int;
			SET @RoomId = SCOPE_IDENTITY();

			INSERT INTO [dbo].[VendingMachine]
				([Room_ID]
				,[Capacity]
				,[Total_revenue])
			VALUES 
				(@RoomId, @Capacity, @TotalRevenue)
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
END
GO
--Add vendingmachine to prev room
CREATE PROCEDURE [dbo].[uspAddVendingMachinePastLocation]
	@RoomId int,
	@TotalRevenue float,
	@Capacity int
AS

BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO [dbo].[VendingMachine]
				([Room_ID]
				,[Capacity]
				,[Total_revenue])
			VALUES 
				(@RoomId, @Capacity, @TotalRevenue)
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
END
GO
--Update vending machine
CREATE PROCEDURE [dbo].[uspUpdateVendingMachine]
	@VendingMachineId int,
	@RoomId int,
	@TotalRevenue float,
	@Capacity int
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			UPDATE [dbo].[VendingMachine]
			SET [Room_ID] = @RoomId, [Total_revenue] = @TotalRevenue, [Capacity] = @Capacity
			WHERE [Vmachine_ID] = @VendingMachineId;
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
END
GO