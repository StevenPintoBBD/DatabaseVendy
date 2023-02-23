USE VendyDB;
Go

-- View to display all drinks available in Gauteng offices
CREATE VIEW vGautengDrinks
AS
SELECT Item_ID, Item_name, vMachine_ID, Category_ID
FROM [dbo].[Item]
WHERE vMachine_ID BETWEEN 1 AND 3
AND Category_ID = 2;
GO

-- View to show the more expensive items in all current vending machines
CREATE VIEW vExpensiveItems
AS
SELECT Item_ID, Item_name, Price
FROM [dbo].[Item]
WHERE Price > (SELECT AVG(Price) FROM Item);
GO


-- View to show the best performing vending machines 
CREATE VIEW vBestPerformingVendingMAchines
AS
SELECT vMachine_ID, Total_revenue
FROM [dbo].[VendingMachine]
WHERE Total_revenue >= 150  
GO

