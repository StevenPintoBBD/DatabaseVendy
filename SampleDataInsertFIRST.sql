USE VendyDB;
Go

--Insert into tables that have no FK first. this prevents any referential issues.
INSERT INTO [dbo].[ItemCategory]
			(Category_name)
VALUES ('Sweets'),
	   ('Drinks'),
	   ('Chips'),
	   ('Other')
GO

--I think City and town have a similar dependance like postcode and city?
INSERT INTO [dbo].[BranchLocation]
			([Postcode]
			,[City]
			)
VALUES (2196, 'Johannesburg'),
	   (0181, 'Pretoria'),
	   (7441, 'Cape Town')
GO

INSERT INTO [dbo].[Employee]
			([First_name]
			,[Last_name]
			,[Allocated_credits]
			)
VALUES ('Steven','Pinto', 10),
	   ('Sebongile','Mazibuko',10),
	   ('Stephen','Potgieter',10),
	   ('Xander','Lubbe',10)
GO

--Insert into the tables that rely on these tables.
INSERT INTO [dbo].[Branch]
			([Branch_name]
			,[PostCode]
			)
VALUES ('BBD Rosebank HQ', 2196),
	   ('BBD Pretoria HQ', 0181),
	   ('BBD Cape Town HQ', 7441)
GO

INSERT INTO [dbo].[Room]
			([Branch_ID]
			,[Room_name]
			,[Room_floor]
			)
VALUES	(1,'Canteen',1),
		(1,'Kitchen',2),
		(2,'Canteen',1),
		(3,'Canteen',1),
		(3,'Kitchen',2)
GO

INSERT INTO [dbo].[VendingMachine]
			([Room_ID]
			,[Capacity]
			,[Total_revenue]
			)
VALUES (1, 64, 100.00),
	   (1, 64, 65.00),
	   (2, 32, 42.00),
	   (3, 64, 102.00),
	   (3, 64, 226.00),
	   (4, 64, 186.00),
	   (4, 64, 305.00),
	   (5, 32, 126.00)
GO

INSERT INTO [dbo].[Item]
			([Vmachine_ID]
			,[Item_name]
			,[Price]
			,[Category_ID]
			,[Quantity]
			,[Item_position]
			)
VALUES	(1,'Coca-cola',5,2,10,'E1'),
		(1,'Fanta Orange',5,2,10,'E2'),
		(1,'Liqui-Fruit Orange juice',5,2,10,'E3'),
		(1,'H2O still water',5,2,10,'E4'),
		(1,'Sour worms',2,1,14,'A1'),
		(1,'Salted Peanuts',2,4,6,'C4'),
		(1,'Simba salt & vinegar',4,3,4,'B2'),
		(1,'Fritos tomato',4,2,8,'B6'),
		(2,'Coca-cola',5,2,10,'E1'),
		(2,'Fanta Orange',5,2,10,'E2'),
		(2,'Liqui-Fruit Orange juice',5,2,10,'E3'),
		(2,'H2O still water',5,2,10,'E4'),
		(2,'Sour worms',2,1,14,'A1'),
		(2,'Salted Peanuts',2,4,6,'C4'),
		(2,'Simba salt & vinegar',4,3,4,'B2'),
		(2,'Fritos tomato',4,2,8,'B6'),
		(3,'Coca-cola',5,2,10,'E1'),
		(3,'Fanta Orange',5,2,10,'E2'),
		(3,'Liqui-Fruit Orange juice',5,2,10,'E3'),
		(3,'H2O still water',5,2,10,'E4'),
		(3,'Sour worms',2,1,14,'A1'),
		(3,'Salted Peanuts',2,4,6,'C2'),
		(3,'Simba salt & vinegar',4,3,4,'C4'),
		(3,'Fritos tomato',4,2,8,'B6'),
		(4,'Coca-cola',5,2,10,'E1'),
		(4,'Fanta Orange',5,2,10,'E2'),
		(4,'Liqui-Fruit Orange juice',5,2,10,'E3'),
		(4,'H2O still water',5,2,10,'E4'),
		(4,'Sour worms',2,1,14,'A1'),
		(4,'Salted Peanuts',2,4,6,'C4'),
		(4,'Simba salt & vinegar',4,3,4,'B2'),
		(4,'Fritos tomato',4,2,8,'B6'),
		(5,'Coca-cola',5,2,10,'E1'),
		(5,'Fanta Orange',5,2,10,'E2'),
		(5,'Liqui-Fruit Orange juice',5,2,10,'E3'),
		(5,'H2O still water',5,2,10,'E4'),
		(5,'Sour worms',2,1,14,'A1'),
		(5,'Salted Peanuts',2,4,6,'C4'),
		(5,'Simba salt & vinegar',4,3,4,'B2'),
		(5,'Fritos tomato',4,2,8,'B6'),
		(6,'Coca-cola',5,2,10,'E1'),
		(6,'Fanta Orange',5,2,10,'E2'),
		(6,'Liqui-Fruit Orange juice',5,2,10,'E3'),
		(6,'H2O still water',5,2,10,'E4'),
		(6,'Sour worms',2,1,14,'A1'),
		(6,'Salted Peanuts',2,4,6,'C2'),
		(6,'Simba salt & vinegar',4,3,4,'C4'),
		(6,'Fritos tomato',4,2,8,'B6'),
		(7,'Coca-cola',5,2,10,'E1'),
		(7,'Fanta Orange',5,2,10,'E2'),
		(7,'Liqui-Fruit Orange juice',5,2,10,'E3'),
		(7,'H2O still water',5,2,10,'E4'),
		(7,'Sour worms',2,1,14,'A1'),
		(7,'Salted Peanuts',2,4,6,'C4'),
		(7,'Simba salt & vinegar',4,3,4,'B2'),
		(7,'Fritos tomato',4,2,8,'B6'),
		(8,'Coca-cola',5,2,10,'E1'),
		(8,'Fanta Orange',5,2,10,'E2'),
		(8,'Liqui-Fruit Orange juice',5,2,10,'E3')
GO

INSERT INTO [dbo].[Transactions]
			([Transaction_date]
			,[Item_ID]
			,[Employee_ID]
			)
VALUES ('1 February 2023',4,3),
	   ('1 February 2023',6,2),
	   ('4 February 2023',20,1),
	   ('7 January 2023',16,2),
	   ('14 February 2023',3,4),
	   ('2 January 2023',16,2),
	   ('3 February 2023',17,4)
GO