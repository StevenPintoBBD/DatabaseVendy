USE VendyDB;
Go

-- View to display all drinks available in Gauteng offices
CREATE VIEW vGautengDrinks
AS
SELECT ItemId, ItemName, vMachineId, CategoryId
FROM [dbo].[Item]
WHERE vMachineId BETWEEN 1 AND 3
AND CategoryId = 2;
GO

-- View to show the more expensive items in all current vending machines
CREATE VIEW vExpensiveItems
AS
SELECT ItemId, ItemName, Price
FROM [dbo].[Item]
WHERE Price > (SELECT AVG(Price) FROM Item);
GO


-- View to show the best performing vending machines 
CREATE VIEW vBestPerformingVendingMAchines
AS
SELECT vMachineId, TotalRevenue
FROM [dbo].[VendingMachine]
WHERE TotalRevenue >= 150  
GO

