-- Creating a Library Database Management 

-- Database Structure

-- Create Books Table
CREATE TABLE Books (
	BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Genre VARCHAR(50),
    PublishedDate DATE
);

-- Create Table for Authors section
CREATE TABLE Authors (
	AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Biography TEXT
);

-- BookAuthors (pulling info from both tables
CREATE TABLE BookAuthors (
	BookID INT,
    AuthorID INT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    PRIMARY KEY (BookID, AuthorID)
);

-- DROP TABLE Members;

-- Members Table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15),
    JoinDate DATE NOT NULL
);


-- Loans Table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    MemberID INT,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Adding Books
INSERT INTO Books (Title, ISBN, Genre, PublishedDate)
VALUES
    ('The Great Gatsby', '9780743273565', 'Fiction', '1925-04-10'),
    ('Pride and Prejudice', '9781503290563', 'Romance', '1813-01-28'),
    ('The Hobbit', '9780547928227', 'Fantasy', '1937-09-21'),
    ('War and Peace', '9780199232765', 'Historical', '1869-01-01'),
    ('Great Expectations', '9780141439563', 'Fiction', '1861-01-01'),
    ('The Odyssey', '9780140268867', 'Epic', '800-01-01');

-- Disable foreign key checksum table
SET FOREIGN_KEY_CHECKS = 0; 

-- Truncate the table
TRUNCATE TABLE Books;
TRUNCATE TABLE Authors;
TRUNCATE TABLE Members;
TRUNCATE TABLE Loans;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS =1;


ALTER TABLE Books AUTO_INCREMENT = 1;
ALTER TABLE Authors AUTO_INCREMENT = 1;

  SELECT * FROM BOOKS;

-- Adding authors
INSERT INTO Authors (Name, Biography)
VALUES 
	('F. Scott Fitzgerald', 'American novelist and short story writer'),
	('Jane Austen', 'An English novelist known for her six major novels interpreting and critiquing the British landed gentry at the end of the 18th century.'),
    ('J.R.R. Tolkien', 'An English writer, poet, philologist, and university professor best known for writing The Hobbit and The Lord of the Rings.'),
    ('Leo Tolstoy', 'A Russian writer widely regarded as one of the greatest authors of all time, known for War and Peace and Anna Karenina.'),
    ('Charles Dickens', 'An English writer and social critic, he created some of the world\'s best-known fictional characters.'),
    ('Homer', 'An ancient Greek poet traditionally said to be the author of The Iliad and The Odyssey.');

-- Linking Books and Authors
INSERT INTO BookAuthors (BookID, AuthorID)
VALUES 
    (1, 1), -- 'The Great Gatsby' by F. Scott Fitzgerald
    (2, 2), -- 'Pride and Prejudice' by Jane Austen
    (3, 3), -- 'The Hobbit' by J.R.R. Tolkien
    (4, 4), -- 'War and Peace' by Leo Tolstoy
    (5, 5), -- 'Great Expectations' by Charles Dickens
    (6, 6); -- 'The Odyssey' by Homer
    
    SELECT * FROM AUTHORS;
    
-- Adding members
INSERT INTO Members (FullName, Email, PhoneNumber, JoinDate)
VALUES 
	('Grace Ake', 'Gracake@exmaple.com', '123-444-5555', CURDATE()),
    ('John Doe', 'johndoe@example.com', '555-123-4567', '2023-01-15'),
    ('Jane Smith', 'janesmith@example.com', '555-234-5678', '2023-02-20'),
    ('Michael Brown', 'michaelbrown@example.com', '555-345-6789', '2023-03-10'),
    ('Emily Davis', 'emilydavis@example.com', '555-456-7890', '2023-04-05'),
    ('Chris Wilson', 'chriswilson@example.com', '555-567-8901', '2023-05-18'),
    ('Sarah Miller', 'sarahmiller@example.com', '555-678-9012', '2023-06-12'),
    ('David Martinez', 'davidmartinez@example.com', '555-789-0123', '2023-07-25'),
    ('Emma Garcia', 'emmagarcia@example.com', '555-890-1234', '2023-08-30'),
    ('Oliver Johnson', 'oliverjohnson@example.com', '555-901-2345', '2023-09-15'),
    ('Sophia Lee', 'sophialee@example.com', '555-012-3456', '2023-10-10');

SELECT * FROM Members;

-- Adding loan records
INSERT INTO Loans (BookID, MemberID, LoanDate, DueDate, ReturnDate)
VALUES     
	(1, 1, '2023-11-01', '2023-11-14', '2023-11-13'),  -- 'The Great Gatsby' loaned to John Doe
    (2, 2, '2023-11-05', '2023-11-19', '2023-11-17'),  -- 'Pride and Prejudice' loaned to Jane Smith
    (3, 3, '2023-11-08', '2023-11-22', '2023-11-20'),  -- 'The Hobbit' loaned to Michael Brown
    (4, 4, '2023-11-10', '2023-11-24', '2023-11-23'),  -- 'War and Peace' loaned to Emily Davis
    (5, 5, '2023-11-12', '2023-11-26', '2023-11-25'),  -- 'Great Expectations' loaned to Chris Wilson
    (6, 6, '2023-11-15', '2023-11-29', '2023-11-28');  -- 'The Odyssey' loaned to Sarah Miller
    
    SELECT * FROM Loans;
    
    -- Library Management
    
    -- Find books by author
    SELECT b.Title, b.ISBN, b.Genre, b.PublishedDate
    FROM Books b 
    JOIN BookAuthors ba ON b.BookID = ba.BookID
    JOIN Authors a ON ba.AuthorID = a.AuthorID
    WHERE a.NAME = 'Jane Smith';
    
    -- List all overdue books
 SELECT b.Title, b.ISBN, l.LoanDate, l.DueDate, l.ReturnDate, m.FullName
 FROM Loans l
 JOIN Books b ON l.BookID = b.BookID
 JOIN Members m ON l.MemberID = m.MemberID
 WHERE l.DueDate < CURDATE() -- Due date is in the past
 AND (l.ReturnDate IS NULL OR l.ReturnDate > l.DueDate);
 
 -- Count Books in each Genre
 
 
 -- Track all loans for a specific member
 
    