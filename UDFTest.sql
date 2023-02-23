USE VendyDB;
GO

SELECT * FROM dbo.udfMostTransactionOnDatePerVmachine();
Go

SELECT FirstName, LastName, dbo.udfGetMostBoughtItemPerEmployee(4) AS MostBoughtItem
FROM Employee
WHERE EmployeeId=4;
GO