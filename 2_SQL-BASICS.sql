---#DDL/DML

---1. How to insert multiple records in a table in sql ?	

INSERT INTO EMPLOY (EMP_ID,EMP_NAME,SALARY)VALUES
(123,'EMP1',45000),
(132,'EMP2',50000),
(141,'EMP3',45000),
(143,'EMP4',60000);

---2. How to add additional column in a table?

ALTER TABLE EMPLOYEE ADD COLUMN HIRE_DATE DATE;		

---3. how to change the constraint in a table?

ALTER TABLE EMPLOYEE MODIFY HIRE_DATE VARCHAR(20);	

---4. How to alter the column name in a table?

ALTER TABLE EMPLOYEE RENAME COLUMN HIRE_DATE TO HIREDATE;	

---5. How to change the table naame in sql?

ALTER TABLE EMPLOYEE RENAME TO EMPLO;		

---6. How to update a partiular value in a table

UPDATE EMPLO SET SALARY = 150000 WHERE EMP_ID=437;	

---CONSTRAINTS

/*Create a table called 'Employees' with the following columns:	
EmployeeID' as an integer primary key with auto-increment					
Name' as a non-null varchar(50)					
Age' as an integer with a check constraint that ensures the age is greater than or equal to 18					
Department' as a varchar(50) with a default value of 'IT'.*/					


CREATE TABLE EMPLOYEES1(
EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
Name varchar(50) not null ,
AGE INT CHECK(AGE<=18),
DEPARTMENT VARCHAR(50) DEFAULT 'IT');


/*Create a customer table with following columns in SQL QUERIES						
cust_id,cust_name,date,city,state,email_id,device,channel, in_time, out_time							
contsraint:  cust_id should be a primary key							
date should be between the first and second quarter of 2023							
in_time and out_time should be in time stamp and should have minor varitions between 1- 2 hours							
insert 50 values for a time period of 4 months one customer can have multiple different data within this specified 3 MONTHS							
channel can be any social media platform (istagram, youtube, hathway,pinterest, twitter, facebook and randomly arrange them							
contsraint:  cust_id should be a primary key							
date should be between the first and second quarter of 2023*/	

CREATE TABLE customer (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    date DATE CHECK (date BETWEEN '2023-01-01' AND '2023-06-30'),
    city VARCHAR(50),
    state VARCHAR(50),
    email_id VARCHAR(100),
    device VARCHAR(50),
    channel VARCHAR(50),
    in_time TIMESTAMP,
    out_time TIMESTAMP
);

INSERT INTO customer (cust_id, cust_name, date, city, state, email_id, device, channel, in_time, out_time)
VALUES
    (1, 'SHIVA', '2023-02-15', 'Chennai', 'NY', 'trident@example.com', 'Mobile', 'Facebook', '2023-02-15 09:00:00', '2023-02-15 17:00:00'),
    (2, 'JAMES', '2023-04-10', 'Kerala', 'CA', 'james@example.com', 'Laptop', 'Instagram', '2023-04-10 10:30:00', '2023-04-10 19:30:00'),
	(3, 'Johnson', '2023-01-20', 'Kerala', 'IL', 'johnson@example.com', 'Tablet', 'Twitter', '2023-01-20 08:30:00', '2023-01-20 16:30:00'),
    (4, 'William', '2023-03-05', 'Hydrabad', 'TX', 'willi@example.com', 'Desktop', 'YouTube', '2023-03-05 11:45:00', '2023-03-05 20:00:00'),
    (5, 'RAJA RAJAN', '2023-06-15', 'Mumbai', 'FL', 'rajan@example.com', 'Mobile', 'Pinterest', '2023-06-15 09:30:00', '2023-06-15 18:30:00');


---KEYS

/*1.)The "Customers" table with a primary key,The "CustomerID" column is set as the primary key, ensuring uniqueness for each customer.:*/

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);
								
/*2.)Create the "Orders" table with a foreign key,The "OrderID" column is set as the primary key,The "CustomerID" column is set as a foreign key referencing the 
"CustomerID" column in the "Customers" table,establishing a relationship between the two tables:*/

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
								
/*3.)The "Products" table with a composite primary key,The "ProductID" and "VariantID" columns together form a composite primary key, ensuring uniqueness for each
combination of "ProductID" and "VariantID":*/

CREATE TABLE Products (
    ProductCategory VARCHAR(50),
    ProductID INT,
    VariantID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    PRIMARY KEY (ProductID,VariantID)
);