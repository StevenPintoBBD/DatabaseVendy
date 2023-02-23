USE VendyDB;
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