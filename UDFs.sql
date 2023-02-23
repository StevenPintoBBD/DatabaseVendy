USE [VendyDB]
GO

IF OBJECT_ID ( '[dbo].[udfGetMostBoughtItemPerEmployee]', 'FN' ) IS NOT NULL   
    DROP FUNCTION [dbo].[udfGetMostBoughtItemPerEmployee]  
GO
CREATE FUNCTION [dbo].[udfGetMostBoughtItemPerEmployee]
(
	@EmployeeId int
)
RETURNS varChar(50)
AS
BEGIN
	DECLARE @MostBoughtItemId int;
	DECLARE @MostBoughtItemName varChar(50);

	SELECT @MostBoughtItemId = COUNT(ItemId) FROM Transactions WHERE EmployeeId=@EmployeeId
	GROUP BY ItemId
	ORDER BY COUNT(ItemId)
	
	SELECT @MostBoughtItemName = ItemName FROM Item
	WHERE ItemId = @MostBoughtItemId;

	RETURN @MostBoughtItemName;
END
GO

-- get the most used days along with transaction amount per vending machine 

IF OBJECT_ID ( '[dbo].[udfMostTransactionOnDatePerVmachine]', 'FN' ) IS NOT NULL   
    DROP FUNCTION [dbo].[udfMostTransactionOnDatePerVmachine]  
GO
CREATE FUNCTION [dbo].[udfMostTransactionOnDatePerVmachine](
)
RETURNS TABLE
AS
RETURN

SELECT i.VmachineId, t.TransactionDate, COUNT(t.TransactionDate) AS TotalTransactions
FROM Transactions t
LEFT JOIN Item i
ON i.ItemId = t.ItemId
GROUP BY i.VmachineId, t.TransactionDate
HAVING count(t.TransactionDate) = (
    SELECT MAX(CountTransactions) 
    FROM (
        SELECT COUNT(*) AS CountTransactions , i.VmachineId
        FROM Transactions t
		left join Item i
		on i.ItemId = t.ItemId
        GROUP BY i.VmachineId, transactionDate
    ) AS subtable 
    WHERE subtable.VmachineId = i.VmachineId
)
