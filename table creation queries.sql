USE master;
GO

CREATE DATABASE VendyDB
GO

USE VendyDB
GO

CREATE TABLE VendingMachine(
	VmachineId int identity (1,1) not null,
	RoomId int null,
	Capacity int null,
	TotalRevenue float null,
	constraint pk_VendingMachine primary key clustered (VmachineId asc)
);


CREATE TABLE Room(
	RoomId int identity (1,1) not null,
	BranchId int null,
	RoomName varchar(100) null,
	RoomFloor int null,
	constraint pk_Room primary key clustered (RoomId asc)
);

CREATE TABLE Branch (
	BranchId int identity (1,1) not null,
	BranchName varchar(100) null,
	Postcode varchar(10) null,
	constraint pk_Branch primary key clustered (BranchId asc)
);

CREATE TABLE BranchLocation (
	Postcode varchar(10) not null,
	City varchar(100) null,
	constraint pk_BranchLocation primary key clustered (Postcode)
);


CREATE TABLE Item (
	ItemId int identity (1,1) not null,
	VmachineId int null,
	ItemName varchar(100),
	Price float null,
	CategoryId int null,
	Quantity int null,
	ItemPosition varchar(2),
	constraint pk_Item primary key clustered (ItemId asc)
);

CREATE TABLE ItemCategory (
	CategoryId int identity (1,1) not null,
	CategoryName varchar(50) null,
	constraint pk_ItemCategory primary key clustered (CategoryId asc)
);

CREATE TABLE Transactions (
	TransactionId int identity (1,1) not null,
	TransactionDate date null, 
	ItemId int null,
	EmployeeId int null,
	constraint pk_Transactions primary key clustered (TransactionId asc)
);

CREATE TABLE Employee (
	EmployeeId int identity (1,1) not null,
	FirstName varchar(50) null,
	LastName varchar(50) null, 
	AllocatedCredits int null,
	constraint pk_Employee primary key clustered (EmployeeId)
);

