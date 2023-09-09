/*1.)Given an "Employees" table with columns (EmployeeID, Name, Salary), write a SQL query
to rank employees based on their salary in descending order, using the RANK() window function. 
If employees have the same salary, give them the same rank.*/	

CREATE TABLE EMPLOYE AS 
SELECT id as emp_id, 
first_name as Name,
salary from employees;

SELECT emp_id,
Name,
salary,
RANK()OVER(ORDER BY salary DESC) AS Sal_Rank	
FROM employe;									

/*2.)Running Total of Sales:											
Given a "Sales" table with columns (TransactionID, Date, Amount), write a SQL query to calculate the
running total of sales for each date, using the SUM() window function with the ORDER BY clause.*/											

CREATE TABLE sales(
TransactionID varchar(10), 
S_Date Date,
Amount int);

INSERT INTO sales values
('4331','2020-11-10',5000),
('4332','2020-12-10',4500),
('4333','2020-12-17',6000),
('4334','2020-11-12',5500),
('4335','2020-11-17',3000),
('4336','2020-11-27',7000);

SELECT TransactionID,
 S_Date,
 Amount,
 SUM(Amount)OVER(ORDER BY S_Date)AS Running_Tot
 FROM sales;

/*3.)Finding the Top N Products in Each Category:												
Given a "Products" table with columns (ProductID, ProductName, Category, Sales), write a SQL
query to retrieve the top N products with the highest sales in each category, using the ROW_NUMBER() window function.*/

CREATE TABLE Products(Product_id int,Product_Name varchar(29),Category varchar(30),Sales int);

INSERT INTO Products VALUES
    (1, 'Realme 8i', 'Mobile_Ph', 15000),
    (2, 'Realme Narzo 60 pro', 'Mobile_Ph', 23000),
    (3, 'HP Pavilion', 'Laptop', 80000),
    (4, 'Asus Vivo book 15', 'Laptop', 75000),
    (5, 'Oppo F12', 'Mobile_Ph', 25000),
    (6, 'AC', 'Electronics', 38000),
	(7, 'Refrigerator', 'Electronics', 19000);
     
WITH TOP AS(
SELECT 
Product_Name,
Category,
Sales,
ROW_NUMBER()OVER(PARTITION BY Category ORDER BY Sales DESC) AS Top_Products
FROM Products) SELECT 
Product_Name,
Category,
Sales FROM TOP WHERE Top_Products  = 1;

/*4.)Calculating the Difference in Revenue between Years:										
Given a "Revenue" table with columns (Year, Revenue), write a SQL query to calculate 
the year-on-year revenue growth (or decline) using the LAG() or LEAD() window function.*/	

CREATE TABLE Revenue (Year YEAR, Revenue INT);	

INSERT INTO Revenue (Year, Revenue) VALUES
(2018, 95000),
(2019, 100000),
(2020, 120000),
(2021, 150000),
(2022, 180000);

SELECT
Year,
Revenue,
LAG(Revenue) OVER (ORDER BY Year) AS PreviousYearRevenue,
(Revenue - LAG(Revenue) OVER (ORDER BY Year)) AS RevenueGrowth
FROM Revenue;

SELECT 
year,
Revenue,
LEAD(Revenue) OVER (ORDER BY YEAR) AS This_Year_Growth,
(Revenue - LEAD(Revenue)OVER(ORDER BY YEAR)) as GROWTH_DIFF_NEXT_YEAR
FROM Revenue;

/*5.)Calculating Average Monthly Sales:													
Given a "Sales" table with columns (TransactionID, Date, Amount), write a
SQL query to calculate the average monthly sales for each product, using 
the AVG() window function along with the PARTITION BY and GROUP BY clauses.*/
	
CREATE TABLE Sales(Product VARCHAR(20),TransactionID INT, Date DATE, Amount INT);
	
INSERT INTO Sales (TransactionID, Date, Amount, Product) VALUES
(1, '2023-08-01', 100000, 'Vehicles'),
(2, '2023-08-12', 150000, 'Laptop'),
(3, '2023-08-03', 200000, 'Vehicles'),
(4, '2023-08-04', 250000, 'Mobiles'),
(5, '2023-08-05', 120000, 'Vehicles'),
(6, '2023-08-06', 180000, 'Laptop'),
(7, '2023-08-07', 220000, 'Mobiles'),
(8, '2023-08-06', 170000, 'Laptop'),
(9, '2023-08-18', 260000, 'Mobiles');

SELECT 
    Product,
    AVG(Avg_Products) AS Avg_Products
FROM (
    SELECT 
        Product,
        AVG(Amount) OVER (PARTITION BY Product, MONTH(Date)) AS Avg_Products
    FROM Sales
) AS Subquery
GROUP BY Product;

/*6.)Query to get the top 5 employee salary from table				
Given a "employee" table with column (emp_id, name, department,salary)*/	

CREATE TABLE employee(emp_id int, name varchar(20), department varchar(10),salary int);	

INSERT INTO employee 
VALUES 
(431,'sam','Developing',85000),
(432,'San','Testing',50000),
(433,'Ram','Developing',60000),
(434,'Surya','Testing',55000),
(435,'Mani','Developing',95000),
(436,'Ragul','Developing',80000),
(437,'Vishnu','Testing',120000),
(438,'Dharsan','Developing',980000),
(439,'Muthu','Testing',65000),
(440,'Selvin','Developing',50000),
(441,'Ragu','Developing',60000),
(442,'Vino','Testing',125000),
(443,'Dhamu','Developing',100000),
(444,'Mone','Testing',60000),
(445,'Selvi','Developing',80000);

 WITH CTE AS(
            SELECT emp_id, 
            name,
            Department,
            salary,
            Row_Number() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC)AS RN_TOP
FROM employee)SELECT * FROM CTE WHERE RN_TOP<=5;


---7.)					
									
CREATE TABLE Customer(customer_id int,date DATE,Transaction VARCHAR(20));
INSERT INTO Customer VALUES
(1, '2021-01-01','Endorsement'),
(1, '2021-02-05','Call'),
(1, '2021-07-01','Call'),
(2, '2021-02-15','New Business'),
(2, '2021-02-15','Call');

---i.)check whether customer has atleast one call in the transaction. If they have a transaction then put yes as status else no	

SELECT Transaction,
       case 
       when transaction='call' THEN 'Yes'
       else 
        'no'
	   end as status
from customer;

---ii.)List the number of call has happen for each customer	

SELECT 
distinct customer_id,
transaction,
COUNT(Transaction)OVER(PARTITION BY Customer_id)as call_count 
FROM CUSTOMER WHERE Transaction='CALL'; 

---iii.)Get the details of customer and date where their first call transcation happen		

with cte as (SELECT 
customer_id,
date,
transaction,
rank()OVER(PARTITION BY customer_id order by date)as first_call 
FROM CUSTOMER where transaction='call')SELECT Customer_id,date,transaction from cte WHERE first_call= 1;
