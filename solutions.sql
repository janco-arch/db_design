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
 

--SOLUTION
-- Create Author table
-- The Author table stores information about individual authors. 
-- Each author has a unique ID, along with their first and last name. 
-- This table connects to books through the BookAuthor junction table.

CREATE TABLE Author (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Create publisher table
-- The Publisher table contains a list of all publishers. 
-- Each book in the system is associated with one publisher using a foreign key.

CREATE TABLE Publisher (
    PublisherID INT AUTO_INCREMENT PRIMARY KEY,
    PublisherName VARCHAR(100) NOT NULL,
    ContactEmail VARCHAR(100)
);

-- Create BookLanguage table
-- The BookLanguage table stores the languages in which books are available. 
-- Each language has a unique ID and name. Books reference this table to indicate their language.

CREATE TABLE BookLanguage (
    LanguageID INT AUTO_INCREMENT PRIMARY KEY,
    LanguageName VARCHAR(50) NOT NULL
);

-- Create book table (after the two above exist)
-- The Book table holds details about each book available in the bookstore. 
-- It includes the book's title, price, and references to its publisher and language. 
-- Books are linked to their authors through the BookAuthor table.

CREATE TABLE book (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    PublisherID INT,
    LanguageID INT,
    price DECIMAL(10, 2),

    FOREIGN KEY (PublisherID) REFERENCES publisher(PublisherID),
    FOREIGN KEY (LanguageID) REFERENCES BookLanguage(LanguageID)
);

-- The BookAuthor table is a junction table that manages the many-to-many relationship 
-- between books and authors. Each record links a book to one of its authors, allowing 
-- a book to have multiple authors and an author to be associated with multiple books.

CREATE TABLE BookAuthor (
    BookAuthor INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES book(BookID),
    FOREIGN KEY (AuthorID) REFERENCES author(AuthorID)
);

-- Add some well-known authors. These will be linked to books through the BookAuthor junction table.
INSERT INTO Author (FirstName, LastName)
VALUES 
('George', 'Orwell'),
('J.K.', 'Rowling'),
('Chinua', 'Achebe');

-- Insert the available languages for books. Each language will be referenced by books through LanguageID.
INSERT INTO BookLanguage (LanguageName)
VALUES 
('English'),
('French'),
('Swahili');

-- Insert the publishers that release the books. Each book will point to one of these using publisher_id.
INSERT INTO Publisher (PublisherName, ContactEmail) VALUES
('Penguin Books', 'contact@penguin.com'),
('Macmillan Publishers', 'info@macmillan.com'),
('Heinemann', 'hello@heinemann.com');

-- Insert book records, each tied to a publisher and language using foreign keys.
-- The IDs used here (PublisherID and LanguageID) match those created above.
INSERT INTO book (title, PublisherID, LanguageID, price) VALUES
('1984', 1, 1, 12.99),                          -- Orwell, Penguin, English
('Harry Potter and the Philosopher\'s Stone', 2, 1, 15.50), -- Rowling, Macmillan, English
('Things Fall Apart', 3, 3, 10.00);            -- Achebe, Heinemann, Swahili

-- Link each book to its corresponding author.
-- This populates the many-to-many relationship between books and authors.
INSERT INTO BookAuthor (BookID, AuthorID) VALUES
(1, 1),  -- 1984 by George Orwell
(2, 2),  -- Harry Potter by J.K. Rowling
(3, 3);  -- Things Fall Apart by Chinua Achebe



