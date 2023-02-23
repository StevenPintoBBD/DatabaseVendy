USE VendyDB;
GO

SELECT * FROM dbo.udfMostTransactionOnDatePerVmachine();
Go

SELECT FirstName, LastName, dbo.udfGetMostBoughtItemPerEmployee(2) AS MostBoughtItem
FROM Employee
WHERE EmployeeId=2;
GO