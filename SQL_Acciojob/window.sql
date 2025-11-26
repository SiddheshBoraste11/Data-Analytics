use window_functions

create table salesdemo (
	SaleID int primary key,
    Region varchar(20),
    SalesPerson varchar(50),
    Product varchar(50),
    SaleData Date,
    SalesAmount int
);

INSERT INTO SalesDemo VALUES
(1,'North','Alice','Laptop','2025-01-01',500),
(2,'North','Alice','Laptop','2025-01-02',700),
(3,'North','Bob','Tablet','2025-01-03',400),
(4,'South','Carol','Laptop','2025-01-01',800),
(5,'South','Dave','Tablet','2025-01-04',900),
(6,'South','Dave','Laptop','2025-01-05',1200),
(7,'East','Eve','Tablet','2025-01-01',300),
(8,'East','Eve','Laptop','2025-01-03',600),
(9,  'North', 'Frank',  'Tablet', '2025-01-03', 700),   
(10, 'North', 'Grace',  'Laptop', '2025-01-04', 700),   
(11, 'South', 'Helen',  'Laptop', '2025-01-02', 1200),
(12, 'South', 'Ian',    'Tablet', '2025-01-03', 900)

SELECT * FROM SalesDemo;

/*AVG by region + product*/
Select 
Region,
product,
SalesPerson ,
SalesAmount,
Avg(SalesAmount)
over(partition by region ,product ) as "Average Sales By Region and product"
from SalesDemo;

/*MIN and MAX sales amount of each sales persons*/

Select 
Region,
SalesPerson ,
SalesAmount,
MIN(SalesAmount) over(partition by SalesPerson ) as " Min_Sales ",
MAX(SalesAmount) over(partition by SalesPerson ) as " Max_Sales "
from SalesDemo;


/*....Rank Function....*/

/*1.Row_Number*/

Select 
Region,
SalesPerson ,
SalesAmount,
row_number() over(partition by Region order by SalesAmount DESC) as " rownum "
from SalesDemo;

/*2.Rank*/

Select 
Region,
SalesPerson ,
SalesAmount,
rank() over(partition by Region order by SalesAmount DESC) as " ranksales"
from SalesDemo;

/*3.Dense_Rank*/

Select 
Region,
SalesPerson ,
SalesAmount,
dense_rank() over(partition by Region order by SalesAmount DESC) as " dense rank sales"
from SalesDemo;

/*4.Cume_Dist*/

Select 
Region,
SalesPerson ,
SalesAmount,
cume_dist() over( order by SalesAmount ASC) as " Cume Dist sales"
from SalesDemo;

/*4.Percentile_rank*/

Select 
Region,
SalesPerson ,
SalesAmount,
percent_rank() over( order by SalesAmount DESC) as " percentile ranksales"
from SalesDemo;

/*5.Ntile ... divides row into buckets (qurtile , deciles , etc)*/ 

Select 
Region,
SalesPerson ,
SalesAmount,
ntile(7) over( order by SalesAmount DESC) as Qurtile
from SalesDemo;

/*....Value Function....*/

/*1.Lead_Value.... Next one*/

Select 
Region,
SalesPerson ,
SalesAmount,
lead(SalesAmount,4) over( order by SalesAmount DESC) as "leadvalue"
from SalesDemo;

/*1.Lag_Value.... Previous one*/

Select 
Region,
SalesPerson ,
SalesAmount,
lag(SalesAmount,5) over( order by SalesAmount DESC) as "lagvalue"
from SalesDemo;

-- *** INDEX ***

 use salesdb;
 show indexes from salesdb.customers;
 show keys from salesdb.customers;
 
  use salesdb;
 drop table if exists DemoCustomers;
 create table DemoCustomers as
 select* from customers;
 
 alter table DemoCustomers add primary key (CustomerID);
 
 create	index idx_lastname on DemoCustomers (lastname);
create index idx_firstname on DemoCustomers (firstname);

drop index idx_lastname on DemoCustomers ;

show indexes from salesdb.DemoCustomers;
-- composite index
create index idx_CountryScore on DemoCustomers (Country, Score);
-- Query using composite order
select * 
from DemoCustomers
where Country= 'USA' and Score> 500;

-- *** STORE PROCEDURE ***
DELIMITER //
create procedure Getcustomersummary()
BEGIN
select count(*) as totalcustomers ,
avg(score) as average
from customers
where country = 'USA';
END //

DELIMITER ;

