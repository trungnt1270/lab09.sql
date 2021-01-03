CREATE DATABASE lab09
GO
USE lab09

CREATE VIEW ProductList AS
SELECT ProductID, Name 
FROM AdventureWorks2014.Production.Product

SELECT * FROM ProductList

CREATE VIEW SalesOrderDetail AS
SELECT pr.ProductID, pr.Name, od.UnitPrice, od.OrderQty, od.UnitPrice*od.OrderQty AS [Total Price]
FROM AdventureWorks2014.Sales.SalesOrderDetail od
JOIN AdventureWorks2014.Production.Product pr
ON od.ProductID = pr.ProductID

SELECT * FROM SalesOrderDetail
------------------------------------------------------------------
CREATE DATABASE lab9
GO
USE lab9

CREATE TABLE Books(
	BookCode int CONSTRAINT pk_books PRIMARY KEY IDENTITY,
	Category varchar(50),
	Author varchar(50),
	Publisher varchar(50),
	Title varchar(100),
	Price int,
	InStore int
)

CREATE TABLE Customers(
	CustomerID int CONSTRAINT pk_customer PRIMARY KEY IDENTITY,
	CustomerName varchar(50),
	Addres varchar(100),
	Phone varchar(12)
)

CREATE TABLE BookSold(
	BookSoldID int CONSTRAINT pk_booksold PRIMARY KEY IDENTITY,
	CustomerID int UNIQUE,
	BookCode int,
	[Date] datetime,
	Price int,
	Amount int,
	CONSTRAINT fk_bookcode FOREIGN KEY (BookCode) REFERENCES Books(BookCode),
	CONSTRAINT fk_customerid FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)

SELECT * FROM Books
SELECT * FROM Customers
SELECT * FROM BookSold
--1
INSERT INTO Books(Category,Author,Publisher,Title,Price,InStore) 
VALUES ('Van Hoc','Vu Trong Phung','Kim Dong','Tieu Phu 1',100000,100),
		('Van Hoc','Vu Trong Phung','Kim Dong','Tieu Phu 2',100000,200),
		('Van Hoc','Vu Trong Phung','Kim Dong','Tieu Phu 3',100000,300),
		('Van Hoc','Vu Trong Phung','Kim Dong','Tieu Phu 4',100000,400),
		('Van Hoc','Vu Trong Phung','Kim Dong','Tieu Phu 5',100000,500)

INSERT INTO Customers(CustomerName,Addres,Phone)
VALUES ('Nguyen Van A','Ha Noi','0987654321'),
		('Nguyen Van B','Ha Noi','0987654322'),
		('Nguyen Van C','Ha Noi','0987654323'),
		('Nguyen Van D','Ha Noi','0987654324'),
		('Nguyen Van E','Ha Noi','0987654325')
		
INSERT INTO BookSold(CustomerID,BookCode,Date,Price,Amount)
VALUES (1,1,'2020-12-25',100000,20),
		(2,3,'2020-12-25',100000,20),
		(3,5,'2020-12-25',100000,20),
		(4,2,'2020-12-25',100000,20),
		(5,1,'2020-12-25',100000,20)
--2
CREATE VIEW V_Books AS
SELECT b.BookCode, b.Title, b.Price,bs.Amount
FROM Books b
JOIN BookSold bs ON b.BookCode = bs.BookCode

SELECT * FROM V_Books
--3

CREATE VIEW V_Customers AS
SELECT c.CustomerID,c.CustomerName,c.Addres, bs.Amount
FROM Customers c
JOIN BookSold bs
ON c.CustomerID=bs.CustomerID

SELECT * FROM V_Customers
--4
CREATE VIEW V_Customers_Buy_LastMonth AS
SELECT c.CustomerID,c.CustomerName,c.Addres, b.Title
FROM Customers c
JOIN BookSold bs ON c.CustomerID = bs.CustomerID
JOIN Books b ON b.BookCode = bs.BookCode
WHERE CONVERT(int,DATEPART(mm,bs.Date) = CONVERT(int,DATEPART(mm,GETDATE())-1
--5
CREATE VIEW V_Customers_Total_Buy AS

