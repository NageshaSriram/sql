-- Create Schema
CREATE DATABASE IF NOT EXISTS inventory_db;
USE inventory_db;

-- 1) CREATE TABLES and LOAD DATA

-- Drop if exists (safe for re-run)
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Warehouse;
DROP TABLE IF EXISTS Region;

-- Region
CREATE TABLE Region (
  RegionID INT PRIMARY KEY,
  RegionName VARCHAR(100),
  CountryName VARCHAR(100),
  State VARCHAR(100),
  City VARCHAR(100),
  PostalCode VARCHAR(20)
);


-- Warehouse
CREATE TABLE Warehouse (
  WarehouseID INT PRIMARY KEY,
  WarehouseName VARCHAR(150),
  WarehouseAddress TEXT,
  RegionID INT,
  FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);


-- Employee
CREATE TABLE Employee (
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(150),
EmployeeEmail VARCHAR(150),
EmployeePhone VARCHAR(50),
EmployeeHireDate DATE,
EmployeeJobTitle VARCHAR(100),
WarehouseID INT,
FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);


-- Customer
CREATE TABLE Customer (
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(200),
CustomerEmail VARCHAR(150),
CustomerPhone VARCHAR(50),
CustomerAddress TEXT,
CustomerCreditLimit DECIMAL(15,2)
);


-- Product
CREATE TABLE Product (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(255),
CategoryName VARCHAR(150),
ProductDescription TEXT,
ProductStandardCost DECIMAL(15,2),
ProductListPrice DECIMAL(15,2),
Profit DECIMAL(15,2)
);


-- Orders
CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
OrderDate DATE,
CustomerID INT,
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


-- OrderDetails
CREATE TABLE OrderDetails (
OrderDetailsID INT PRIMARY KEY,
ProductID INT,
OrderItemQuantity INT,
PerUnitPrice DECIMAL(15,2),
OrderStatus VARCHAR(50),
OrderID INT,
FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- LOAD DATA (example). Adjust path and FIELDS/TERMINATED BY if CSV differs.
-- Make sure to start MySQL client with --local-infile=1 or set GLOBAL local_infile=1
SET GLOBAL local_infile = 1;
/*

If the below scripts not working, we can manually import the data by following the below steps

1. Expand the schema 'inventory_db'
2. Expand Tables
3. Right click on the table your are intended to import the data
4. Click on 'Table Data Import Wizard'
5. Browse for the CSV file which is inside data folder
6. And follow the instruction on the wizard.

*/

LOAD DATA LOCAL INFILE 'data/Region.csv'
INTO TABLE Region
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(RegionID, RegionName, CountryName, State, City, PostalCode);


LOAD DATA LOCAL INFILE 'data/Warehouse.csv'
INTO TABLE Warehouse
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(WarehouseID, WarehouseName, WarehouseAddress, RegionID);


LOAD DATA LOCAL INFILE 'data/Employee.csv'
INTO TABLE Employee
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(EmployeeID, EmployeeName, EmployeeEmail, EmployeePhone, @hiredate, EmployeeJobTitle, WarehouseID)
SET EmployeeHireDate = STR_TO_DATE(@hiredate, '%Y-%m-%d');


LOAD DATA LOCAL INFILE 'data/Customer.csv'
INTO TABLE Customer
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CustomerID, CustomerName, CustomerEmail, CustomerPhone, CustomerAddress, CustomerCreditLimit);


LOAD DATA LOCAL INFILE 'data/Product.csv'
INTO TABLE Product
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ProductID, ProductName, CategoryName, ProductDescription, ProductStandardCost, ProductListPrice, Profit);


LOAD DATA LOCAL INFILE 'data/Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrderID, @orderdate, CustomerID)
SET OrderDate = STR_TO_DATE(@orderdate, '%Y-%m-%d');


LOAD DATA LOCAL INFILE 'data/OrderDetails.csv'
INTO TABLE OrderDetails
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrderDetailsID, ProductID, OrderItemQuantity, PerUnitPrice, OrderStatus, OrderID);


-- 2) Schema exploration

-- Show columns
SHOW TABLES;

/*
Tables_in_inventory_db
'Customer'
'Employee'
'OrderDetails'
'Orders'
'Product'
'Region'
'Warehouse'
*/
DESCRIBE Product;
DESCRIBE Orders;
DESCRIBE OrderDetails;
DESCRIBE Customer;
DESCRIBE Warehouse;
DESCRIBE Employee;
DESCRIBE Region;


-- Quick row counts
SELECT 'Product' AS table_name, COUNT(*) AS rows FROM Product
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'OrderDetails', COUNT(*) FROM OrderDetails;