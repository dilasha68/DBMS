

USE db1;

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
    faculty varchar(40)
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
DROP TABLE Teacher;
INSERT INTO Student VALUES
(1, 'Amit', 101, '2023'),
(2, 'Sita', 102, '2023'),
(3, 'Ram', 103, '2024'),
(4, 'Gita', 104, '2024');

INSERT INTO Teacher VALUES
(1, 'Sharma', '2020-01-15', 45000,'science'),
(2, 'Karki', '2019-03-10', 50000,'management'),
(3, 'Thapa', '2021-06-20', 42000,'humanities'),
(4, 'Rai', '2018-11-05', 55000,'science');

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

SELECT e.ename, t.faculty, e.salary FROM employee AS e
JOIN teacher AS t
ON t.tid = e.eid;

SELECT * 
FROM Book as b
LEFT JOIN Booklist AS bl
ON b.bid=bl.isbn;

SELECT * 
FROM Book as b
RIGHT JOIN Booklist AS bl
ON b.bid=bl.isbn;


SELECT s.sid, s.sname, i.IID, i.dateofissue
FROM student s
LEFT JOIN issues i
ON s.sname = i.name
UNION
SELECT s.sid, s.sname, i.IID, i.dateofissue
FROM student s
RIGHT JOIN issues i
ON s.sname = i.name;

SELECT ename,salary
FROM Employee
WHERE ename like 's%' AND ename LIKE '%a%'

SELECT e.ename
FROM Employee AS e
INNER JOIN Teacher AS t
ON e.eid=t.tid;

SELECT ename
FROM employee
WHERE ename NOT IN (
    SELECT ename FROM teacher
);

CREATE VIEW Employee_view AS 
SELECT eid,ename,salary
FROM Employee;

INSERT INTO Employee_view VALUES
(5,'AA',50000);

SELECT * FROM Employee_view;


DELETE FROM Employee_view
WHERE salary<29000;



