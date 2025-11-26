-- create a new database db_sql_tutorial
-- (Explanation: `--` is called a **single-line comment** in SQL. 
-- Anything after `--` on the same line will not be executed. It's just for notes.)

DROP DATABASE IF EXISTS db_sql_tutorial;   
-- `DROP DATABASE` = deletes a database
-- `IF EXISTS` = only drops it if it already exists (prevents errors if it doesn't exist)
-- `db_sql_tutorial` = name of the database
-- `;` = semicolon, marks the **end of a SQL statement**

CREATE DATABASE db_sql_tutorial;   
-- `CREATE DATABASE` = command to create a new database
-- `db_sql_tutorial` = database name

USE db_sql_tutorial;   
-- `USE` = tells SQL which database we want to work in

/* ================================
   CREATE TABLE: customers
   ================================= */
-- (Explanation: `/* ... */` is called a **multi-line comment block**. 
-- It can span multiple lines. Everything inside is ignored by SQL.)

DROP TABLE IF EXISTS db_sql_tutorial.customers;  
-- `DROP TABLE` = deletes a table
-- `db_sql_tutorial.customers` = schema.table format (db name + table name)
-- `.` = dot is called the **dot operator**, used to separate database/table/column names

CREATE TABLE db_sql_tutorial.customers (
  customer_id INT(10) NOT NULL AUTO_INCREMENT, 
  -- `customer_id` = column name
  -- `INT(10)` = integer datatype with display width 10 (width is ignored in modern MySQL)
  -- `NOT NULL` = column cannot have NULL (empty) values
  -- `AUTO_INCREMENT` = automatically generates increasing numbers for new rows
  
  first_name  VARCHAR(50) NOT NULL,
  -- `VARCHAR(50)` = variable-length string up to 50 characters
  
  last_name   VARCHAR(50) NOT NULL,
  country     VARCHAR(50) NULL,
  -- `NULL` = allows the column to be empty
  
  score       INT(32) NULL,
  PRIMARY KEY (customer_id )
  -- `PRIMARY KEY` = uniquely identifies each row in the table
  -- `(customer_id)` = column chosen as the primary key
);  
-- `()` = parentheses, used to group column definitions or conditions

/* ================================
   INSERTING DATA into customers
   ================================= */
INSERT INTO db_sql_tutorial.customers VALUES (1,'Maria', 'Cramer ', 'Germany',350);  
-- `INSERT INTO` = add new records into a table
-- `VALUES` = specifies the actual values for each column
-- `'Maria'` etc. = single quotes denote string values (text data)
-- numbers (like 350) don’t need quotes
-- `,` = comma separates multiple values or items in a list

INSERT INTO db_sql_tutorial.customers VALUES (2,'John','Steel','USA', 900);
INSERT INTO db_sql_tutorial.customers VALUES (3,'Georg',' Pipps ', 'UK', 750);
INSERT INTO db_sql_tutorial.customers VALUES (4,'Martin','Müller','Germany', 500);
INSERT INTO db_sql_tutorial.customers VALUES (5,'Peter','Franken','USA', NULL);
-- `NULL` here means missing/unknown value

/* ================================
   CREATE TABLE: orders
   ================================= */
DROP TABLE IF EXISTS db_sql_tutorial.orders;

CREATE TABLE db_sql_tutorial.orders (
  order_id    INT(10) NOT NULL AUTO_INCREMENT,
  customer_id INT(10) NOT NULL,
  order_date  DATE  NULL,
  -- `DATE` = a date datatype in format 'YYYY-MM-DD'
  quantity    INT(32) NULL,
  PRIMARY KEY (order_id)
);

INSERT INTO db_sql_tutorial.orders VALUES (1001,1,'2021-01-11',250);
INSERT INTO db_sql_tutorial.orders VALUES (1002,2,'2021-04-05',1150);
INSERT INTO db_sql_tutorial.orders VALUES (1003,3,'2021-06-18',500);
INSERT INTO db_sql_tutorial.orders VALUES (1004,6,'2021-08-31',750);

/* ================================
   CREATE TABLE: employees
   ================================= */
DROP TABLE IF EXISTS db_sql_tutorial.employees;

CREATE TABLE db_sql_tutorial.employees (
  emp_id      INT(10) NOT NULL AUTO_INCREMENT,
  first_name  VARCHAR(50) NOT NULL,
  last_name   VARCHAR(50) NOT NULL,
  emp_country VARCHAR(50) NULL,
  salary      INT(32) NULL,
  PRIMARY KEY (emp_id )
);

INSERT INTO db_sql_tutorial.employees VALUES (1,'John', 'Steel', 'USA', 55000);
INSERT INTO db_sql_tutorial.employees VALUES (2,'Ann', 'Labrune', 'France', 75000);
INSERT INTO db_sql_tutorial.employees VALUES (3,'Marie', 'Bertrand', 'Brazil', 75000);
INSERT INTO db_sql_tutorial.employees VALUES (4,'Georg', 'Afonso', 'UK', 75000);
INSERT INTO db_sql_tutorial.employees VALUES (5,'Marie', 'Steel', 'UK', 75000);

desc customers;
select * from customers;
select * from orders;
select * from employees;
select
sum(score),
country
from customers
group by country;


/* Clauses */

select 
	country,
    avg(score) as avg_score
from
	customers
where
	score != 0
group by 
	country 
having
	avg_score > 400
order by
	avg_score asc;
   /*Operators*/ 
select 
	first_name,
    last_name,
    country,
    score
from customers
where first_name like '%n' ;


/* Joins */
SHOW COLUMNS FROM customers;
SHOW COLUMNS FROM orders;
SHOW COLUMNS FROM  employees;

/*INNER JOIN*/
SELECT * 
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

/*LEFT JOIN*/
SELECT * 
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id;

/*RIGHT JOIN*/
SELECT * 
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customer_id = o.customer_id;

/*FULL JOIN*/

SELECT * 
FROM customers AS c
FULL JOIN orders AS o
ON c.customer_id = o.customer_id;


SELECT * 
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
UNION	
SELECT * 
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customer_id = o.customer_id;

/*UNION ALL JOIN*/

SELECT * 
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
UNION ALL	
SELECT * 
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customer_id = o.customer_id;

/*UNION JOIN*/
SELECT 
c.first_name,
c.last_name,
c.country
FROM customers AS c
UNION
SELECT 
e.first_name,
e.last_name,
e.emp_country
FROM employees AS e;


-- Intersect
SELECT 
    s.product_name, s.region, s.salesperson
FROM
    Sales2023 AS s
Intersect
SELECT 
    ss.product_name, ss.region, ss.salesperson
FROM
    Sales2024 AS ss;

-- Except
SELECT 
    s.product_name, s.region, s.salesperson
FROM
    Sales2024 AS s
Except
SELECT 
    ss.product_name, ss.region, ss.salesperson
FROM
    Sales2023 AS ss;

-- Funcations
select*from Sales2023;
select*from Sales2024;
select *from  customers ;
-- Aggragate funcation
select count(score) 
as Count 
from customers;

select sum(score) 
as Sum
from customers;

select Avg(score) 
as Average 
from customers;

select min(score) 
as Min_no
from customers;

select max(first_name) 
as Max_no 
from customers;

-- String Funcation 
select concat(first_name," ",last_name) as FULLNAME
from customers;

select upper(first_name) as NAME
from customers;

select lower(first_name) as NAME
from customers;

select trim(first_name) as NAME
from customers;
select first_name, length(first_name) as "Length of Name"
from customers;

select replace (first_name ,"John","jon")
from customers;

select left(first_name,2) as leftExtraction from customers;

select left(first_name,2) from customers;

select right(first_name,3) as RighExtraction from  customers;

select substring(first_name,2,3) as Substring_Update from customers;