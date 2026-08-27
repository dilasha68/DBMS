-- ============================================
-- DATABASE MANAGEMENT SYSTEMS LAB
-- JOIN, VIEW AND SET OPERATION EXERCISES
-- ============================================

USE db1;


-- ============================================
-- TABLE CREATION
-- ============================================

CREATE TABLE Student (
    sid INT PRIMARY KEY,
    sname VARCHAR(50),
    RN INT,
    batch VARCHAR(20)
);

CREATE TABLE Teacher (
    tid INT PRIMARY KEY,
    ename VARCHAR(50),
    dateofjoin DATE,
    salary DECIMAL(10,2),
    faculty VARCHAR(40)
);

CREATE TABLE Employee (
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    dateofemploy DATE,
    salary DECIMAL(10,2)
);

CREATE TABLE Booklist (
    isbn VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    publication VARCHAR(50)
);

CREATE TABLE Book (
    bid INT PRIMARY KEY,
    bname VARCHAR(100),
    author VARCHAR(50),
    price DECIMAL(8,2)
);

CREATE TABLE Issues (
    IID INT PRIMARY KEY,
    name VARCHAR(50),
    dateofissue DATE
);


-- ============================================
-- INSERT SAMPLE DATA
-- ============================================

INSERT INTO Student VALUES
(1, 'Amit', 101, '2023'),
(2, 'Sita', 102, '2023'),
(3, 'Ram', 103, '2024'),
(4, 'Gita', 104, '2024');


INSERT INTO Teacher VALUES
(1, 'Sharma', '2020-01-15', 45000, 'science'),
(2, 'Karki', '2019-03-10', 50000, 'management'),
(3, 'Thapa', '2021-06-20', 42000, 'humanities'),
(4, 'Rai', '2018-11-05', 55000, 'science');


INSERT INTO Employee VALUES
(1, 'Hari', '2022-02-01', 30000),
(2, 'Shyam', '2021-07-15', 28000),
(3, 'Laxmi', '2020-10-10', 32000),
(4, 'Mina', '2019-12-25', 35000);


INSERT INTO Booklist VALUES
('ISBN001', 'DBMS', 'Pearson'),
('ISBN002', 'Operating System', 'McGraw Hill'),
('ISBN003', 'Computer Networks', 'OReilly'),
('ISBN004', 'Data Structures', 'Oxford');


INSERT INTO Book VALUES
(1, 'DBMS', 'Korth', 550),
(2, 'OS', 'Silberschatz', 600),
(3, 'CN', 'Tanenbaum', 650),
(4, 'DSA', 'Weiss', 500);


INSERT INTO Issues VALUES
(1, 'Amit', '2024-01-05'),
(2, 'Sita', '2024-01-10'),
(3, 'Ram', '2024-01-15'),
(4, 'Gita', '2024-01-20');


-- ============================================
-- QUESTIONS AND SOLUTIONS
-- ============================================


-- Question 1:
-- Display the employee name, faculty and salary by joining the Employee and Teacher tables.

SELECT e.ename, t.faculty, e.salary
FROM Employee AS e
JOIN Teacher AS t
ON t.tid = e.eid;


-- Question 2:
-- Display all records from the Book table along with matching records from Booklist using a LEFT JOIN.

-- NOTE:
-- Book.bid is INT while Booklist.isbn is VARCHAR.
-- These columns should not normally be used as matching keys.

SELECT *
FROM Book AS b
LEFT JOIN Booklist AS bl
ON b.bid = bl.isbn;


-- Question 3:
-- Display all records from Booklist along with matching records from Book using a RIGHT JOIN.

SELECT *
FROM Book AS b
RIGHT JOIN Booklist AS bl
ON b.bid = bl.isbn;


-- Question 4:
-- Perform a FULL OUTER JOIN between Student and Issues. Since MySQL does not directly support FULL OUTER JOIN, use LEFT JOIN and RIGHT JOIN with UNION.

SELECT s.sid, s.sname, i.IID, i.dateofissue
FROM Student AS s
LEFT JOIN Issues AS i
ON s.sname = i.name

UNION

SELECT s.sid, s.sname, i.IID, i.dateofissue
FROM Student AS s
RIGHT JOIN Issues AS i
ON s.sname = i.name;


-- Question 5:
-- Find employees whose names start with the letter 'S' and also contain the letter 'A'.

SELECT ename, salary
FROM Employee
WHERE ename LIKE 's%'
AND ename LIKE '%a%';


-- Question 6:
-- Display the names of employees whose IDs match teacher IDs using an INNER JOIN.

SELECT e.ename
FROM Employee AS e
INNER JOIN Teacher AS t
ON e.eid = t.tid;


-- Question 7:
-- Display employees whose names are not present in the Teacher table.

SELECT ename
FROM Employee
WHERE ename NOT IN (
    SELECT ename
    FROM Teacher
);


-- Question 8:
-- Create a view named Employee_view containing employee ID, employee name and salary.

CREATE VIEW Employee_view AS
SELECT eid, ename, salary
FROM Employee;


-- Question 9:
-- Insert a new employee record through Employee_view.

INSERT INTO Employee_view
VALUES (5, 'AA', 50000);


-- Question 10:
-- Display all records available in Employee_view.

SELECT *
FROM Employee_view;


-- Question 11:
-- Delete records from Employee_view where salary is less than 29000.

DELETE FROM Employee_view
WHERE salary < 29000;


-- Question 12:
-- Display the Employee_view after deleting employees whose salary is less than 29000.

SELECT *
FROM Employee_view;
