CREATE DATABASE IF NOT EXISTS SensitiveDataDB;
USE SensitiveDataDB;

CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    manager_id INT
);

-- Q1
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    designation VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    aadhaar_no CHAR(12) UNIQUE,
    email VARCHAR(100),
    doj DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    industry_type VARCHAR(50),
    contact_email VARCHAR(100),
    risk_category VARCHAR(20),
    registered_on DATE
);


CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    dept_id INT,
    project_name VARCHAR(100),
    data_classification VARCHAR(30),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE access_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    table_accessed VARCHAR(50),
    action_type VARCHAR(20),
    access_timestamp DATETIME,
    remarks VARCHAR(255),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO departments (dept_name, manager_id) VALUES
('IT Security', 1),
('Data Analytics', 2),
('Human Resources', 3);

INSERT INTO employees (emp_name, designation, dept_id, salary, aadhaar_no, email, doj) VALUES
('Rajesh Kumar', 'CISO', 1, 200000.00, '999988887777', 'rajesh@datasecure.com', '2018-03-01'),
('Priya Iyer', 'Lead Analyst', 2, 150000.00, '999977776666', 'priya@datasecure.com', '2020-01-15'),
('Meena Joshi', 'HR Head', 3, 180000.00, '999966665555', 'meena@datasecure.com', '2019-07-01'),
('Aditya Rao', 'Data Engineer', 2, 120000.00, '999955554444', 'aditya@datasecure.com', '2021-10-05'),
('Kavya Patel', 'Security Officer', 1, 110000.00, '999944443333', 'kavya@datasecure.com', '2022-05-10');

INSERT INTO clients (client_name, industry_type, contact_email, risk_category, registered_on) VALUES
('FinEdge Bank', 'Finance', 'contact@finedge.com', 'High', '2019-10-01'),
('MediCare Health', 'Healthcare', 'support@medicare.com', 'High', '2020-04-11'),
('QuickKart', 'E-commerce', 'help@quickkart.com', 'Medium', '2021-07-19');

INSERT INTO projects (client_id, dept_id, project_name, data_classification, start_date, end_date, status) VALUES
(1, 1, 'Fraud Detection', 'Restricted', '2022-01-01', NULL, 'Active'),
(2, 2, 'Patient Data Insights', 'Confidential', '2023-01-15', NULL, 'Active'),
(3, 2, 'E-cart Analytics', 'Public', '2022-10-10', '2023-03-31', 'Completed');

INSERT INTO access_logs (emp_id, table_accessed, action_type, access_timestamp, remarks) VALUES
(1, 'employees', 'SELECT', '2025-10-01 09:00:00', 'Monthly audit'),
(4, 'clients', 'SELECT', '2025-10-03 11:00:00', 'Client health check'),
(2, 'projects', 'UPDATE', '2025-10-04 14:00:00', 'Updated project status'),
(5, 'employees', 'SELECT', '2025-10-05 16:00:00', 'Verification task');

-- Q2  Modify the employees table to:
-- Add a column last_accessed DATETIME
-- Rename email to official_email
-- Drop designation column

ALTER TABLE employees
ADD COLUMN last_accessed DATETIME;
ALTER TABLE employees
RENAME COLUMN email to official_email;
ALTER TABLE employees
DROP COLUMN designation;

-- Q3  Insert a new employee into the employees table with realistic data.

INSERT INTO employees (
    emp_id, emp_name, 
    dept_id, salary, 
    aadhaar_no, 
    official_email, 
    doj, 
    last_accessed
)
VALUES (
    101,  
    'Amit Sharma', 
    3 , 75000.00 , 
    '123456789012' , 
    'amit.sharma@company.com' , 
    '2023-07-15' , 
    NOW()   
);

-- Q4 Update the salary of all employees in the “Data Analytics” department by 10%, but only if they joined before 2021.

SELECT e.emp_id, e.emp_name, e.salary, d.dept_name, e.doj
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Data Analytics'
  AND e.doj < '2021-01-01';

-- Q5 Retrieve all active projects handled by the “Data Analytics” department with their client names.

SELECT 
    p.project_id,
    p.project_name,
    c.client_name,
    d.dept_name,
    p.status
FROM projects p
JOIN departments d ON p.dept_id = d.dept_id
JOIN clients c ON p.client_id = c.client_id
WHERE d.dept_name = 'Data Analytics'
  AND p.status = 'Active';
