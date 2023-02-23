--Stored Procedures
USE VendyDB;
GO
--Add Transaction to table When a new employee attempts to get an item (NO validation for enough creditss)
IF OBJECT_ID ( '[dbo].[uspAddTransactionNewEmployee]', 'P' ) IS NOT NULL   
    DROP PROCEDURE [dbo].[uspAddTransactionNewEmployee];  
GO
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

			UPDATE [dbo].[Item]
			SET [Quantity] = Quantity - 1
			WHERE [Item_ID] = @ItemID;

			UPDATE [dbo].[Employee]
			SET Employee.Allocated_credits = Employee.Allocated_credits -  Item.Price
			FROM dbo.Employee, dbo.Item
			WHERE Item.Item_ID = @ItemID AND Employee.Employee_ID = @EmployeeId;

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
END
GO

--Add Transaction to table When a past employee attempts to get an item (NO validation for enough creditss) 
--(THESE CHECKS SHOULD HAPPEN ON BACKEND)
IF OBJECT_ID ( '[dbo].[uspAddTransactionPastEmployee]', 'P' ) IS NOT NULL   
    DROP PROCEDURE [dbo].[uspAddTransactionPastEmployee]  
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

			UPDATE [dbo].[Item]
			SET [Quantity] = Quantity - 1
			WHERE [Item_ID] = @ItemID;

			UPDATE [dbo].[Employee]
			SET Employee.Allocated_credits = Employee.Allocated_credits -  Item.Price
			FROM dbo.Employee, dbo.Item
			WHERE Item.Item_ID = @ItemID AND Employee.Employee_ID = @EmployeeId;

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
END
GO

--Add Vending machine new locations
IF OBJECT_ID ( '[dbo].[uspAddVendingMachineNewLocation]', 'P' ) IS NOT NULL   
    DROP PROCEDURE [dbo].[uspAddVendingMachineNewLocation]  
GO
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

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
END
GO
--Add vendingmachine to a location in the table.
IF OBJECT_ID ( '[dbo].[uspAddVendingMachinePastLocation]', 'P' ) IS NOT NULL   
    DROP PROCEDURE [dbo].[uspAddVendingMachinePastLocation]  
GO
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

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
END
GO

--Update vending machine
IF OBJECT_ID ( '[dbo].[uspUpdateVendingMachine]', 'P' ) IS NOT NULL   
    DROP PROCEDURE [dbo].[uspUpdateVendingMachine]  
GO
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

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
END
GO