CREATE TABLE Cake (
	CakeID			VARCHAR(2)	NOT NULL,
	Type			TEXT		NOT NULL,
	Flavor			TEXT		NOT NULL,
	Size			TEXT		NOT NULL,
	CONSTRAINT PK_Cake PRIMARY KEY (CakeID)
);

CREATE Table Day_Table (
	Day				date		NOT NULL,
	CONSTRAINT		PK_Day	PRIMARY KEY (Day)
);

CREATE TABLE DAY_STOCK (
	Day				date		NOT NULL,
	CakeID			VARCHAR(2)	NOT NULL,
	Leftover		INTEGER		NOT NULL,
	AmountSold		INTEGER		NOT NULL,
	AmountDisposed	INTEGER		NOT NULL,
	ExpirationDate	date		NOT NULL,
	CONSTRAINT PK_Today PRIMARY KEY (Day, CakeID, ExpirationDate),
	CONSTRAINT FK_Date FOREIGN KEY	(Day)	REFERENCES Day_Table (Day),
	CONSTRAINT FK_Today FOREIGN KEY (CakeID) REFERENCES Cake (CakeID)
);

CREATE TABLE CakeOrder (
	OrderID			VARCHAR(2)	NOT NULL,
	CakeID			VARCHAR(2) NOT NULL,
	OrderDate		date		NOT NULL,
	PickUpDate		date		NOT NULL,
	Quantity		INTEGER		NOT NULL,
	CONSTRAINT PK_Order PRIMARY KEY (OrderID),
	CONSTRAINT FK_Order FOREIGN KEY (CakeID) REFERENCES Cake (CakeID),
	CONSTRAINT FK_Order_Day FOREIGN KEY	(OrderDate) REFERENCES Day_Table (Day)
);

INSERT INTO Cake (CakeID, Type, Flavor, Size) 
		VALUES	('01', 'Fresh Cream', 'Vanilla', 'Small'),
				('02', 'Fresh Cream', 'Vanilla', 'Medium'),
				('03', 'Fresh Cream', 'Vanilla', 'Large'),
				('11', 'Fresh Cream', 'Blueberry', 'Small'),
				('12', 'Fresh Cream', 'Blueberry', 'Medium'),
				('22', 'Fresh Cream', 'Chocolate', 'Medium'),
				('33', 'Fresh Cream', 'Strawberry', 'Large'),
				('43', 'Fresh Cream', 'Green Tea', 'Large'),
				('51', 'Mousse', 'Triple Chocolate', 'Small'),
				('62', 'Buttercream', 'Chocolate', 'Medium'),
				('63', 'Buttercream', 'Chocolate', 'Large'),
				('72', 'Buttercream', 'Strawberry', 'Medium'),
				('83', 'Buttercream', 'Caramel', 'Medium'),
				('91', 'Buttercream', 'Red Velvet', 'Small');
			
INSERT INTO Day_Table (Day) 
		VALUES	('2022-05-07'),
				('2022-05-08');

INSERT INTO DAY_STOCK (Day, CakeID, Leftover,
	AmountSold, AmountDisposed, ExpirationDate) 
		VALUES	('2022-05-07', '01', '3', '2', '0', '2022-05-08'),
				('2022-05-07', '03', '2', '1', '0', '2022-05-08'),
				('2022-05-07', '12', '0', '2', '0', '2022-05-08'),	
				('2022-05-07', '22', '0', '1', '1', '2022-05-07'),
				('2022-05-07', '33', '1', '0', '0', '2022-05-08'),
				('2022-05-07', '43', '0', '2', '0', '2022-05-08'),
				('2022-05-07', '51', '2', '0', '0', '2022-05-10'),
				('2022-05-07', '83', '1', '0', '0', '2022-05-10'),
				('2022-05-07', '91', '1', '1', '0', '2022-05-09');
	
INSERT INTO CakeOrder (OrderID, CakeID, OrderDate, 
	PickUpDate, Quantity) 
		VALUES	('01', '11', '2022-05-07', '2022-05-12', '1'),
				('02', '72', '2022-05-07', '2022-05-10', '2'),
				('03', '63', '2022-05-07', '2022-05-09', '1');
	
INSERT INTO DAY_STOCK (Day, CakeID, Leftover, 
	AmountSold, AmountDisposed, ExpirationDate)
		VALUES	('2022-05-08', '01', '0', '2', '1', '2022-05-08'),
				('2022-05-08', '01', '1', '0', '0', '2022-05-11'),
				('2022-05-08', '02', '1', '2', '0', '2022-05-11'),
				('2022-05-08', '03', '0', '3', '0', '2022-05-08'),
				('2022-05-08', '12', '1', '4', '0', '2022-05-11'),	
				('2022-05-08', '22', '1', '1', '0', '2022-05-11'),
				('2022-05-08', '33', '0', '0', '1', '2022-05-08'),
				('2022-05-08', '43', '1', '1', '0', '2022-05-11'),
				('2022-05-08', '51', '0', '2', '0', '2022-05-10'),
				('2022-05-08', '63', '1', '1', '0', '2022-05-11'),
				('2022-05-08', '83', '0', '1', '0', '2022-05-10'),
				('2022-05-08', '91', '1', '1', '0', '2022-05-09');
			
INSERT INTO CakeOrder (OrderID, CakeID, OrderDate, 
	PickUpDate, Quantity) 
		VALUES 	('04', '83', '2022-05-08', '2022-05-15', '1'),
				('05', '03', '2022-05-08', '2022-05-12', '1'),
				('06', '43', '2022-05-08', '2022-05-10', '1'),
				('07', '11', '2022-05-08', '2022-05-12', '2'),
				('08', '91', '2022-05-08', '2022-05-10', '2');
	
CREATE VIEW DAY_STOCK_VW AS
	SELECT CakeID, Leftover
	FROM DAY_STOCK 
	WHERE Leftover > 0 AND Day = '2022-05-07';
	
CREATE VIEW CakeOrder_VW AS
	SELECT OrderID, CakeID, PickUpDate, Quantity
	FROM CakeOrder 
	WHERE PickUpDate > '2022-05-10';

CREATE VIEW Cake_VW AS
	SELECT Type, Flavor, Size
	FROM Cake;
	
SELECT DAY, Leftover, AmountSold, AmountDisposed, ExpirationDate
	From DAY_STOCK
	WHERE CakeID = '01';

SELECT CakeID, Type, Flavor, Size
	FROM Cake;	
SELECT Day
	FROM Day_Table;	
SELECT DAY, CakeID, Leftover, AmountSold, AmountDisposed, ExpirationDate
	From DAY_STOCK;
SELECT OrderID, CakeID, OrderDate, PickUpDate, Quantity
	From CakeOrder;
	
	
DROP TABLE DAY_STOCK;
DROP TABLE CakeOrder;
DROP VIEW  DAY_STOCK_VW;
DROP VIEW  Cake_VW;
DROP VIEW  CakeOrder_VW;