/*
create database temp_db;
use temp_db;

CREATE TABLE students (
    roll_no BIGINT PRIMARY KEY,
    name VARCHAR(20),
    age INT,
    hometown VARCHAR(20),
    gender CHAR(1),
    hobbies VARCHAR(50)
);
ALTER TABLE students
ADD COLUMN (
	contact VARCHAR(15),
	address VARCHAR(50)
);
ALTER TABLE students
MODIFY address VARCHAR(100);

ALTER TABLE students
CHANGE COLUMN contact emergency_contact VARCHAR(15);

ALTER TABLE students
RENAME TO student_data;

INSERT INTO student_data (roll_no, name, age, gender, hobbies, emergency_contact,
hometown, address)
VALUES
(1,'Sachin',22,'M','Cricket','9927343524','Nashik','Kalewadi-Pune'),
(2,'Nikhil',21,'M','Football','9027341524','Kolhapur','Kothrud-Pune'),
(3,'Archana',22,'F','Gardening','8927373564','Sangali','Baner-Pune'),
(4,'Neha',21,'F','Dancing','9627543824','Mumbai','Wakad-Pune'),
(5,'Swapnil',23,'M','Reading','9928735124','Satara','Katraj-Pune');

SELECT * FROM student_data;

SELECT roll_no, name FROM student_data;

UPDATE student_data
SET hometown = 'Pune'
WHERE roll_no = 3;

DELETE FROM student_data
WHERE roll_no = 4;

TRUNCATE TABLE student_data;

DROP TABLE student_data;

*/

-- Task 16 : Create a database named sql_practice.
-- Task 17 : Create employees, departments, and projects tables.
-- Task 18 : Insert records into all three tables.
-- Task 19 : Display all data from employees table.
-- Task 20 : Display employee names and salaries only.
-- Task 21 : Display distinct departments from employees table.
-- Task 22 : Display employees who work in IT department.
-- Task 23 : Display employees with salary greater than 65000.
-- Task 24 : Display top 3 highest paid employees.
-- Task 25 : Display department-wise average salary where average > 60000.

CREATE DATABASE sql_practice;

use sql_practice;

create table employee (
	emp_id bigint PRIMARY KEY,
    name VARCHAR(20),
    age INT,
    gender CHAR(1),
    salary int
	);
    
INSERT INTO employee (emp_id, name , age, gender, salary )
VALUES
(101,'Sachin',22,'M','25000'),
(102,'Sam',23,'M','35000'),
(103,'Raj',23,'M','30000'),
(104,'Ajay',21,'M','25000'),
(105,'Priya',22,'F','35000');

select * from employee;




