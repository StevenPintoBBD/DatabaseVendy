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

	SELECT @MostBoughtItemId = COUNT(Item_ID) FROM Transactions
	WHERE Employee_ID = @EmployeeId;

	SELECT @MostBoughtItemName = Item_name FROM Item
	WHERE Item_ID = @MostBoughtItemId;

	RETURN @MostBoughtItemName;
END
GO

-- get the most used days along with transaction amount per vending machine 
CREATE FUNCTION [dbo].[udfMostTransactionOnDatePerVmachine](
)
RETURNS TABLE
AS
RETURN

SELECT i.Vmachine_ID, t.Transaction_date, COUNT(t.Transaction_date) AS total_transactions
FROM transactions t
LEFT JOIN Item i
ON i.Item_ID = t.Item_ID
GROUP BY i.Vmachine_ID, t.Transaction_date
HAVING count(t.Transaction_date) = (
    SELECT MAX(count_transactions) 
    FROM (
        SELECT COUNT(*) AS count_transactions , i.Vmachine_ID
        FROM transactions t
		left join Item i
		on i.Item_ID = t.Item_ID
        GROUP BY i.Vmachine_ID, transaction_date
    ) AS subtable 
    WHERE subtable.Vmachine_ID = i.Vmachine_ID
)
