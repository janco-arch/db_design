--SOLUTION
-- Create Author table
CREATE TABLE Author (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Create publisher table
CREATE TABLE Publisher (
    PublisherID INT AUTO_INCREMENT PRIMARY KEY,
    PublisherName VARCHAR(100) NOT NULL,
    ContactEmail VARCHAR(100)
);

-- Create BookLanguage table
CREATE TABLE BookLanguage (
    LanguageID INT AUTO_INCREMENT PRIMARY KEY,
    LanguageName VARCHAR(50) NOT NULL
);

-- Create book table (after the two above exist)
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

INSERT INTO Author (FirstName, LastName)
VALUES 
('George', 'Orwell'),
('J.K.', 'Rowling'),
('Chinua', 'Achebe');


INSERT INTO BookLanguage (LanguageName)
VALUES 
('English'),
('French'),
('Swahili');

INSERT INTO Publisher (PublisherName, ContactEmail) VALUES
('Penguin Books', 'contact@penguin.com'),
('Macmillan Publishers', 'info@macmillan.com'),
('Heinemann', 'hello@heinemann.com');
