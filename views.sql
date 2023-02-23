USE VendyDB;
Go

-- View to display all drinks available in Gauteng offices
IF OBJECT_ID ( '[dbo].[vGautengDrinks]', 'V' ) IS NOT NULL   
    DROP VIEW [dbo].[vGautengDrinks]  
GO
CREATE VIEW vGautengDrinks
AS
SELECT ItemId, ItemName, vMachineId, CategoryId
FROM [dbo].[Item]
WHERE vMachineId BETWEEN 1 AND 3
AND CategoryId = 2;
GO

-- View to show the more expensive items in all current vending machines
IF OBJECT_ID ( '[dbo].[vExpensiveItems]', 'V' ) IS NOT NULL   
    DROP VIEW [dbo].[vExpensiveItems]  
GO
CREATE VIEW vExpensiveItems
AS
SELECT ItemId, ItemName, Price, VendingMachine.VmachineId 
FROM [dbo].[Item]
INNER JOIN VendingMachine ON VendingMachine.VmachineId = Item.ItemId
WHERE Price > (SELECT AVG(Price) FROM Item);
GO




-- View to show the best performing vending machines 
IF OBJECT_ID ( '[dbo].[vBestPerformingVendingMAchines]', 'V' ) IS NOT NULL   
    DROP VIEW [dbo].[vBestPerformingVendingMAchines]  
GO
CREATE VIEW vBestPerformingVendingMAchines
AS
SELECT vMachineId, TotalRevenue, RoomName, RoomFloor, BranchName
FROM [dbo].[VendingMachine]
INNER JOIN Room ON VendingMachine.RoomId = Room.RoomId
INNER JOIN Branch ON Room.BranchId = Branch.BranchId
WHERE TotalRevenue >= 150;
GO

