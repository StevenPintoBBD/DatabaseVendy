--StoredProc tester

USE VendyDB;
GO

SELECT * FROM Transactions;
GO

SELECT * FROM Employee;
GO

SELECT * FROM Item;
GO

SELECT * FROM VendingMachine;
GO

EXEC dbo.uspAddTransactionNewEmployee @TransactionDate = '2023-01-07', @ItemId = 12, @FirstName = 'James', @LastName = 'Thomas', @AllocatedCredits = 10;
GO

SELECT * FROM Transactions;
GO

SELECT * FROM Employee;
GO

SELECT * FROM Item;
GO

SELECT * FROM VendingMachine;
GO

EXEC dbo.uspAddTransactionPastEmployee @TransactionDate = '2023-01-20', @ItemId = 34, @EmployeeId = 2;
GO

SELECT * FROM Transactions;
GO

SELECT * FROM Employee;
GO

SELECT * FROM Item;
GO

SELECT * FROM VendingMachine;
GO

SELECT * FROM VendingMachine;
GO

SELECT * FROM Branch;
GO
SELECT * FROM BranchLocation;
GO

SELECT * FROM Room;
GO

EXEC dbo.uspAddVendingMachineNewLocation @PostCode = 1234, @City = 'Bloemfontein', @BranchName = 'BBD Bloem', @RoomFloor = 2,@RoomName ='Kitchen', @TotalRevenue = 0, @Capacity = 200;
GO

SELECT * FROM VendingMachine;
GO

SELECT * FROM Branch;
GO

SELECT * FROM BranchLocation;
GO

SELECT * FROM Room;
GO

EXEC dbo.uspAddVendingMachinePastLocation @RoomId = 2, @TotalRevenue = 0.00, @Capacity = 200;
GO

SELECT * FROM VendingMachine;
GO

SELECT * FROM Branch;
GO

SELECT * FROM BranchLocation;
GO

SELECT * FROM Room;
GO

EXEC dbo.uspUpdateVendingMachine @VendingMachineId = 9, @RoomId =3, @TotalRevenue = 100.00, @Capacity = 200; 
GO

SELECT * FROM VendingMachine;
GO