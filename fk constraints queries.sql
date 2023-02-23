USE VendyDB
GO

ALTER TABLE dbo.VendingMachine 
	ADD CONSTRAINT fk_VendingMachine_Room
	FOREIGN KEY (RoomId)
	REFERENCES dbo.Room (RoomId)


ALTER TABLE dbo.Room
	ADD CONSTRAINT fk_Room_Branch
	FOREIGN KEY (BranchId)
	REFERENCES dbo.Branch (BranchId)

ALTER TABLE dbo.Branch
	ADD CONSTRAINT fk_Branch_BranchLocation
	FOREIGN KEY (Postcode)
	REFERENCES dbo.BranchLocation (Postcode)

ALTER TABLE dbo.Item
	ADD CONSTRAINT fk_Item_VendingMachine
	FOREIGN KEY (VmachineId)
	REFERENCES dbo.VendingMachine (VmachineId)


ALTER TABLE dbo.Item 
	ADD CONSTRAINT fk_Item_ItemCategory
	FOREIGN KEY (CategoryId)
	REFERENCES dbo.ItemCategory (CategoryId)


ALTER TABLE dbo.Transactions 
	ADD CONSTRAINT fk_Transactions_Item
	FOREIGN KEY (ItemId)
	REFERENCES dbo.Item (ItemId)

ALTER TABLE dbo.Transactions
	ADD CONSTRAINT fk_Transactions_Employee
	FOREIGN KEY (EmployeeId)
	REFERENCES dbo.Employee (EmployeeId)
