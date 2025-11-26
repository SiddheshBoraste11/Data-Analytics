-- ======================================================
-- STEP 1: Create and Use the Database
-- ======================================================

CREATE DATABASE SQLDA_MiniProject;

USE SQLDA_MiniProject;


-- ======================================================
-- Create Tables
-- ======================================================

CREATE TABLE Customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(50),
    signup_date DATE
);

CREATE TABLE Products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    cost DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id VARCHAR(10) PRIMARY KEY,
    order_id VARCHAR(10),
    amount DECIMAL(10,2),
    payment_date DATE,
    method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- ======================================================
-- Insert Data
-- ======================================================

INSERT INTO Customers VALUES
('C001','Ananya Mehta','West (Mumbai)','2023-01-12'),
('C002','Rohit Sharma','North (Delhi)','2023-02-05'),
('C003','Priya Nair','South (Bangalore)','2023-03-15'),
('C004','Karan Patel','West (Pune)','2023-04-18'),
('C005','Sneha Gupta','North (Lucknow)','2023-05-10'),
('C006','Ramesh Iyer','South (Chennai)','2023-06-22'),
('C007','Kavita Joshi','East (Kolkata)','2023-07-14'),
('C008','Arjun Verma','West (Ahmedabad)','2023-08-09'),
('C009','Deepika Rao','South (Hyderabad)','2023-09-25'),
('C010','Neha Singh','North (Chandigarh)','2023-10-04');

INSERT INTO Products VALUES
('P001','Smartphone X12','Electronics',30000,24000),
('P002','Laptop Pro 14','Electronics',65000,52000),
('P003','Mixer Grinder Deluxe','Home & Kitchen',5000,3000),
('P004','Air Fryer Compact','Home & Kitchen',7000,4000),
('P005','Sports Watch Fit+','Accessories',8000,5000),
('P006','Bluetooth Headphones','Electronics',4000,2500),
('P007','Electric Kettle Plus','Home & Kitchen',2500,1500),
('P008','Vacuum Cleaner Pro','Home Appliances',12000,8000),
('P009','DSLR Camera Zoom','Electronics',45000,37000),
('P010','Smart TV 43 inch','Electronics',38000,29000);

INSERT INTO Orders VALUES
('O001','C001','P001',2,'2023-01-20'),
('O002','C003','P003',1,'2023-02-10'),
('O003','C002','P002',1,'2023-02-25'),
('O004','C005','P004',3,'2023-03-15'),
('O005','C001','P005',1,'2023-04-02'),
('O006','C007','P006',2,'2023-04-28'),
('O007','C004','P007',4,'2023-05-14'),
('O008','C009','P008',1,'2023-05-25'),
('O009','C006','P009',1,'2023-06-04'),
('O010','C002','P010',1,'2023-07-12'),
('O011','C008','P001',1,'2023-08-05'),
('O012','C010','P003',2,'2023-09-15'),
('O013','C004','P004',2,'2023-10-03'),
('O014','C005','P005',1,'2023-10-25'),
('O015','C001','P010',1,'2023-11-10'),
('O016','C009','P006',3,'2023-11-20'),
('O017','C003','P008',2,'2023-12-01'),
('O018','C007','P009',1,'2023-12-10'),
('O019','C006','P002',2,'2023-12-18'),
('O020','C010','P007',5,'2023-12-22');

INSERT INTO Payments VALUES
('PM001','O001',60000,'2023-01-21','Credit Card'),
('PM002','O002',5000,'2023-02-10','UPI'),
('PM003','O003',65000,'2023-02-25','Credit Card'),
('PM004','O004',21000,'2023-03-15','Net Banking'),
('PM005','O005',8000,'2023-04-02','Credit Card'),
('PM006','O006',8000,'2023-04-28','UPI'),
('PM007','O007',10000,'2023-05-14','Cash'),
('PM008','O008',12000,'2023-05-25','Net Banking'),
('PM009','O009',45000,'2023-06-04','Credit Card'),
('PM010','O010',38000,'2023-07-12','UPI'),
('PM011','O011',30000,'2023-08-05','Credit Card'),
('PM012','O012',10000,'2023-09-15','Cash'),
('PM013','O013',14000,'2023-10-03','Credit Card'),
('PM014','O014',8000,'2023-10-25','UPI'),
('PM015','O015',38000,'2023-11-10','Net Banking'),
('PM016','O016',12000,'2023-11-20','UPI'),
('PM017','O017',24000,'2023-12-01','Credit Card'),
('PM018','O018',45000,'2023-12-10','Net Banking'),
('PM019','O019',130000,'2023-12-18','Credit Card'),
('PM020','O020',12500,'2023-12-22','UPI');


select * From Customers;
select * From Products;
select* from Orders;
desc Payments;
Select * From Payments;

select category ,sum(price) as Total_Revenue
from Products group by Category;

-- Total Revenue by Product Category
select ps.category, sum(p.amount)  as total_revenue
from payments p
inner join orders o ON p.order_id = o.order_id
inner join products ps ON o.product_id = ps.product_id
group by ps.category;

select * From Customers;
select * From Products;
select* from Orders;
desc Payments;
Select * From Payments;

-- Top 5 Customers by Lifetime Spend
select 
c.name as customer_name,
sum(o.quantity * p.price) as total_spent
from Orders o
join Products p on o.product_id = p.product_id
join Customers c on c.customer_id = o.customer_id
group by c.name
order by total_spent desc
limit 5;

-- Monthly Sales Trend
select * From Customers;
select * From Products;
select* from Orders;
Select * From Payments;

select 
month(pay.payment_date) AS Month,
year(pay.payment_date) AS Year,
sum(pay.amount) AS monthly_sales
from Payments pay
group by Year, Month
order by Year, Month desc;

-- Product Profitability Analysis
select * From Customers;
select * From Products;
select* from Orders;
Select * From Payments;

select p.product_name, p.Category,
sum(o.quantity),
sum(o.quantity*p.price) as total_revenue,
sum(o.quantity*p.cost)as total_cost,
(sum(o.quantity*p.price)-sum(o.quantity*p.cost)) as Profit
from orders o join products p on p.product_id=o.product_id
group by p.product_name, p.category
order by profit desc;
 
