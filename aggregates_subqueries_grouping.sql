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
('978-0131103627', 'C Programming Language', 'Pearson'),
('978-0262033848', 'Introduction to Algorithms', 'MIT Press'),
('978-0132350884', 'Clean Code', 'Prentice Hall'),
('978-0201616224', 'The Pragmatic Programmer', 'Addison-Wesley');


INSERT INTO Book (bid, bname, author, price) VALUES
(1, 'Database Systems', 'Elmasri', 650.00),
(2, 'Operating System Concepts', 'Silberschatz', 720.00),
(3, 'Computer Networks', 'Tanenbaum', 680.00),
(4, 'Software Engineering', 'Tanenbaum', 700.00);


INSERT INTO Issues (IID, name, dateofissue,sid) VALUES
(1, 'Amit Sharma', '2024-01-10',1),
(2, 'Sita Karki', '2024-01-12',2),
(3, 'Ramesh Thapa', '2024-01-12',3),
(5, 'Anjal Singh', '2025-01-18',4);

DROP TABLE Issues;

-- 1 Find the average salary of teachers.
SELECT avg(salary) as average_salary_of_Teacher
FROM Teacher;


-- 2 Display the maximum priced book.
SELECT MAX(price) as MAXIMUM_PRICE_OF_BOOK
FROM Book;


-- 3 List employees earning more than the average employee salary.
SELECT * FROM Employee
WHERE salary>(SELECT AVG(salary) FROM Teacher);


-- 4 Display the minimum salary among teachers.
SELECT min(salary) FROM Teacher;


-- 5 Find students who have never issued a book.

SELECT *
FROM Student s
LEFT JOIN Issues i
    ON s.name = i.name
WHERE i.iid IS NULL;


-- 6 Find books that have never been issued.
SELECT *
FROM Book as b
JOIN Issues as i ON i.iid=b.bid
WHERE i.iid=NULL;


-- 7 Find students who issued books after a specific date.
SELECT * 
FROM Student as s
JOIN Issues as i ON s.name=i.name
WHERE i.dateofissue>'2024-01-09';


-- 8 Find publications that appear more than once in Booklist.
SELECT publication,count(*) as count_of_booklist
FROM Booklist
GROUP BY publication
HAVING count(*)>1;


-- 9 Find the student who issued the most books.
SELECT i.name, COUNT(*) AS total_books_issued
FROM Issues i
GROUP BY i.name
ORDER BY total_books_issued DESC
LIMIT 1;


-- 10 Find books whose price is higher than the average price of books by the same author.
SELECT b1.bname,b1.author,b1.price FROM Book as b1
WHERE b1.price>
(SELECT AVG(b2.price) 
FROM Book as b2 
WHERE b1.author=b2.author);


-- 11 Identify students who issued books on consecutive dates.
SELECT DISTINCT i1.sid 
FROM Issues as i1
JOIN Issues as i2 ON i1.sid=i2.sid
 AND i2.dateofissue=DATE_ADD(i1.dateofissue,INTERVAL 1 DAY);


-- 12 Retrieve students who issued every book issued by a specific student.
SELECT s1.name 
FROM Student as s1
JOIN Issues as i ON s1.sid=i.iid
WHERE
 (SELECT s2.name 
FROM Student as s2
WHERE s1.name=s2.name);
 

