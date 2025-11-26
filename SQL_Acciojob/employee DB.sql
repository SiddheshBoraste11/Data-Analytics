CREATE DATABASE employee_db;
USE employee_db;

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    hire_date DATE,
    job_title VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO employees (first_name, last_name, email, phone, hire_date, job_title, salary)
VALUES
('John', 'Doe', 'john.doe@example.com', '9876543210', '2022-01-15', 'Manager', 75000.00),
('Jane', 'Smith', 'jane.smith@example.com', '9123456780', '2023-03-01', 'Developer', 55000.00),
('Amit', 'Kumar', 'amit.kumar@example.com', '9988776655', '2021-11-20', 'HR Executive', 40000.00);

SELECT * FROM employees;

