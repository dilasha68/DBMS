CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

CREATE TABLE Student (
    sid INT PRIMARY KEY,
    Name VARCHAR(100),
    RN VARCHAR(50),
    Batch VARCHAR(50)
);

CREATE TABLE Teacher (
    tid INT PRIMARY KEY,
    ename VARCHAR(100),
    dateofjoin DATE,
    salary DECIMAL(10,2)
);

CREATE TABLE Employee (
    eid INT PRIMARY KEY,
    ename VARCHAR(100),
    dateofemployee DATE,
    salary DECIMAL(10,2)
);

CREATE TABLE Booklist (
    isbn VARCHAR(20) PRIMARY KEY,
    name VARCHAR(200),
    publication VARCHAR(200)
);

CREATE TABLE Book (
    bid INT PRIMARY KEY,
    bname VARCHAR(200),
    author VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Issues (
    IID INT PRIMARY KEY,
    bid INT,
    sid INT,
    eid INT,
    name VARCHAR(100),
    dateofissue DATE
);


INSERT INTO Student (sid, Name, RN, Batch) VALUES
(1, 'Amit Sharma', 'RN101', '2022'),
(2, 'Sita Karki', 'RN102', '2022'),
(3, 'Ramesh Thapa', 'RN103', '2023'),
(4, 'Anjali Singh', 'RN104', '2023');


INSERT INTO Teacher (tid, ename, dateofjoin, salary) VALUES
(1, 'Rajesh Kumar', '2018-06-15', 55000.00),
(2, 'Sunita Devi', '2019-08-20', 60000.00),
(3, 'Manoj Verma', '2020-01-10', 52000.00),
(4, 'Priya Shah', '2021-07-01', 58000.00);


INSERT INTO Employee (eid, ename, dateofemployee, salary) VALUES
(1, 'Vikram Patel', '2017-03-12', 40000.00),
(2, 'Neha Joshi', '2019-11-05', 42000.00),
(3, 'Arjun Mehta', '2020-09-18', 45000.00),
(4, 'Kavita Rao', '2022-02-25', 38000.00);


INSERT INTO Booklist (isbn, name, publication) VALUES
('978-0131103627', 'Database Systems', 'Pearson'),
('978-0262033848', 'Introduction to Algorithms', 'MIT Press'),
('978-0132350884', 'Clean Code', 'Prentice Hall'),
('978-0201616224', 'The Pragmatic Programmer', 'Addison-Wesley');


INSERT INTO Book (bid, bname, author, price) VALUES
(1, 'Database Systems', 'Elmasri', 650.00),
(2, 'Operating System Concepts', 'Silberschatz', 720.00),
(3, 'Computer Networks', 'Tanenbaum', 680.00),
(4, 'Software Engineering', 'Tanenbaum', 700.00),
(5,'aa','bb',700.00);
DROP TABLE Issues;

INSERT INTO Issues (IID, name, dateofissue,sid,bid) VALUES
(1, 'Amit Sharma', '2024-01-10',1,1),
(2, 'Sita Karki', '2024-01-12',2,2),
(3, 'Ramesh Thapa', '2024-01-12',3,3),
(5, 'Anjal Singh', '2025-01-18',4,4);

DROP TABLE Booklist;
-- 1.Display student name, roll number, and book name for all students who have issued books.
SELECT s.Name,s.RN,b.bname
FROM Issues as i
JOIN Student as s ON s.sid=i.bid
JOIN Book as b ON b.bid=i.bid
WHERE i.iid IS NOT NULL;

-- 3. Show student name, batch, and date of issue for students who issued books after a given date.
SELECT s.name,s.Batch,i.dateofissue
FROM Issues as i
JOIN Student as s ON s.sid=i.iid
JOIN Book as b ON b.bid=i.iid
WHERE dateofissue>2024-01-10;

-- 5. Display employee name, designation date (dateofemployee), and book name for all employees who issued books.
SELECT e.ename, e.dateofemployee, b.bname
FROM Issues AS i
JOIN Employee e ON e.eid = i.iid
JOIN Book b ON b.bid = i.iid
WHERE i.eid IS NOT NULL;

-- 7. List all books along with publication name using Book and Booklist.
SELECT b.bname,bl.publication
FROM Booklist as bl
JOIN Book as b ON b.bid=bl.isbn;

-- 9. Find the names of students who have issued more expensive books than the average book price.
SELECT s.name,b.bname
FROM Issues as i
JOIN Student as s on s.sid=i.iid
JOIN Book as b ON b.bid=i.iid
WHERE i.sid IS NOT NULL
	AND b.price>(SELECT AVG(price) as average_price_of_book FROM Book as b2 );


-- 11.Find teachers whose salary is greater than the average salary of employees.
SELECT * 
FROM Teacher 
WHERE salary>(SELECT AVG(salary) FROM Employee);

-- 13.Retrieve books that were never issued.
SELECT b.bname 
FROM Issues as i
JOIN Book as b ON b.bid=i.iid
WHERE i.iid IS NULL;

-- 15.Display the highest priced book issued by any student.
SELECT b.bname,b.price
FROM Issues as i
JOIN Book as b ON b.bid=i.iid
JOIN Student as s ON s.sid=i.iid
ORDER BY b.price DESC
LIMIT 1;

-- 17.Write a stored procedure to display all books issued by a given student ID.
DELIMITER $$

CREATE PROCEDURE books_issued_by_students(IN p_side INT)
BEGIN
	SELECT *
	FROM Issues as i
	JOIN Student as s on s.sid=i.iid
	JOIN Book as b ON b.bid=i.iid
    WHERE i.iid= p_sid
    ORDER BY i.dateofissue DESC;
END$$

DELIMITER $$

-- 19.Write a stored procedure to insert a new book into the Book table.
DELIMITER $$

CREATE PROCEDURE insert_newbook_int0_Booktable(IN p_bid INT,
												IN p_bname VARCHAR(100),
                                                IN p_author VARCHAR(100),
                                                IN p_price DECIMAL(10,2))
BEGIN
	INSERT INTO Book(bid,bname,author,price)
    VALUES(p_bid,p_bname,p_author,p_price);
END $$
DELIMITER ;

-- 21.Write a stored procedure that returns the count of books issued by a given user (student/teacher).
DELIMITER $$

CREATE PROCEDURE sp_count_books_issued_by_user(
  IN p_role VARCHAR(20),
  IN p_id INT
)
BEGIN
  IF UPPER(p_role) = 'STUDENT' THEN
    SELECT COUNT(*) AS issued_count
    FROM Issues
    WHERE sid = p_id;

  ELSEIF UPPER(p_role) = 'TEACHER' THEN
    SELECT COUNT(*) AS issued_count
    FROM Issues
    WHERE tid = p_id;

  ELSEIF UPPER(p_role) = 'EMPLOYEE' THEN
    SELECT COUNT(*) AS issued_count
    FROM Issues
    WHERE eid = p_id;

  ELSE
    SELECT 'INVALID ROLE (use STUDENT/TEACHER/EMPLOYEE)' AS error;
  END IF;
END $$

DELIMITER ;

-- 23.Write a stored procedure that lists all users who issued books after a given date.

DELIMITER $$

CREATE PROCEDURE sp_users_after_date(IN p_date DATE)
BEGIN
	SELECT s.Name,i.dateofissue,b.bname
    FROM Issues i
    JOIN Student s ON s.sid=i.iid
    JOIN Book b  ON b.bid=i.iid
    WHERE i.dateofissue > p_date;
END$$

DELIMITER ;








