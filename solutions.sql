--SOLUTION
CREATE TABLE Customer( 
CustomerID INT PRIMARY KEY NOT NULL,
FirstName VARCHAR (20) NOT NULL,
LastName VARCHAR (20) NOT NULL,
Email VARCHAR (50) NOT NULL,
PhoneNumber VARCHAR (20) NOT NULL
); 
INSERT INTO Customer( CustomerID, FirstName, LastName, Email,PhoneNumber ) VALUES
(1, 'Alice','Kim', 'alice@example.com', '070-00-0001'),
(2, 'Nancy', 'Drew', 'nancy@example.com', '070-00-0002'),
(3, 'Will', 'Smith', 'will@example.com', '070-00-0003');

-- customerAddress table
CREATE TABLE CustomerAddress( 
AddressID INT PRIMARY KEY NOT NULL,
Zipcode VARCHAR (20) NOT NULL,
CustomerID INT,
FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
);
INSERT INTO CustomerAddress( AddressID, Zipcode, CustomerID) VALUES
( 1, 'A001', 1 ),
( 2, 'A002', 2 ),
( 3, 'A003', 3);

-- coutry table
CREATE TABLE Country(
CountryID INT PRIMARY KEY NOT NULL,
CountryName VARCHAR (30) NOT NULL);
INSERT INTO Country(CountryID, CountryName ) VALUES
(1, 'Kenya'),
(2, 'South Africa'),
(3, 'Nigeria'); 

-- address status table
CREATE TABLE AddressStatus(
StatusID INT PRIMARY KEY NOT NULL, 
StatusName VARCHAR (20)NOT NULL);
INSERT INTO  AddressStatus(StatusID, StatusName ) VALUES
(1, 'current'), 
(2, 'old'),
(3, 'current');

-- address table
CREATE TABLE Address( 
AddressID INT PRIMARY KEY NOT NULL,
Street VARCHAR (30) NOT NULL,
City VARCHAR (30) NOT NULL,
StatusID INT,
CountryID INT,
FOREIGN KEY(StatusID) REFERENCES AddressStatus(StatusID),
FOREIGN KEY(CountryID ) REFERENCES Country(CountryID)
);
INSERT INTO Address(AddressID,Street,City,StatusID,CountryID) VALUES
(1, '12 Main street', 'Nairobi', 1, 1),
(2, '42 Uptown', 'Cape Town', 2, 2),
(3, '10 Expressway ', 'Lagos', 3, 3);

-- shipping table
CREATE TABLE ShippingMethod(
MethodID INT PRIMARY KEY NOT NULL,
MethodName VARCHAR (50) NOT NULL);
INSERT INTO ShippingMethod(MethodID ,MethodName) VALUES
(1,'Express Delivery'),
(2,'Standard Shipping'),
(3,'Pickup In-store');

-- order status table
CREATE TABLE OrderStatus(
StatusID INT PRIMARY KEY NOT NULL,
StatusName VARCHAR (30) NOT NULL);
INSERT INTO OrderStatus(StatusID,StatusName) VALUES
(1, 'Delivered'),
(2, 'Canceled'),
(3, 'Shipped'),
(4, 'Pending');

-- customer orders table
CREATE TABLE CustomerOrders(
OrderID INT PRIMARY KEY NOT NULL,
OrderDate DATE NOT NULL,
CustomerID INT,
MethodID INT,
StatusID INT,
FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID),
FOREIGN KEY(MethodID ) REFERENCES ShippingMethod(MethodID ),
FOREIGN KEY(StatusID ) REFERENCES OrderStatus(StatusID)
);
INSERT INTO CustomerOrders(OrderID, OrderDate, CustomerID, MethodID, StatusID ) VALUES
(1,'2025-01-03', 1 ,3, 2),
(2,'2025-03-05', 3 ,1, 3),
(3,'2025-02-10', 2,2, 1);

--- - order line table
 CREATE TABLE OrderLine (
OrderLineID INT PRIMARY KEY NOT NULL,
Quantity VARCHAR (30) NOT NULL,
OrderID INT,
BookID INT AUTO_INCREMENT,
FOREIGN KEY(BookID) REFERENCES Book(BookID),
FOREIGN KEY(OrderID) REFERENCES CustomerOrders(OrderID)
 );
INSERT INTO OrderLine (OrderLineID,Quantity,OrderID,BookID) VALUES
(1, 3, 2, 1),
(2, 2, 1, 2),
(3, 1, 2, 3);

-- order history table
CREATE TABLE OrderHistory( 
HistoryID INT PRIMARY KEY NOT NULL,
DateUpdate DATE NOT NULL,
OrderID INT,
StatusID INT,
FOREIGN KEY(OrderID) REFERENCES CustomerOrders(OrderID),
FOREIGN KEY(StatusID ) REFERENCES OrderStatus(StatusID)
);
INSERT INTO OrderHistory(HistoryID,DateUpdate, OrderID,StatusID )
VALUES
(1, '2025-02-02',1, 1),
(2, '2025-02-04',2, 3),
(3, '2025-02-05',1, 2),
(4, '2025-02-08',3, 1);
 
