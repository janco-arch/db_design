
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



