-- Step 1: Create Schema
CREATE DATABASE IF NOT EXISTS inventory_db;
USE inventory_db;

-- Step 2: Create Tables
CREATE TABLE Customer (
  CustomerID INT PRIMARY KEY,
  CustomerName VARCHAR(100),
  CustomerEmail VARCHAR(100),
  CustomerPhone VARCHAR(20),
  CustomerAddress VARCHAR(255),
  CustomerCreditLimit DECIMAL(10,2)
);

CREATE TABLE Employee (
  EmployeeJobTitle VARCHAR(100),
  WarehouseID INT
);


CREATE TABLE Product (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(100),
  CategoryName VARCHAR(100),
  ProductDescription TEXT,
  ProductStandardCost DECIMAL(10,2),
  ProductListPrice DECIMAL(10,2),
  Profit DECIMAL(10,2)
);


CREATE TABLE Region (
  RegionID INT PRIMARY KEY,
  RegionName VARCHAR(100),
  CountryName VARCHAR(100),
  State VARCHAR(100),
  City VARCHAR(100),
  PostalCode VARCHAR(20)
);


CREATE TABLE Warehouse (
  WarehouseID INT PRIMARY KEY,
  WarehouseName VARCHAR(100),
  WarehouseAddress VARCHAR(255),
  RegionID INT,
  FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);


CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  OrderDate DATE,
  CustomerID INT,
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE TABLE OrderDetails (
  OrderDetailsID INT PRIMARY KEY,
  ProductID INT,
  OrderItemQuantity INT,
  PerUnitPrice DECIMAL(10,2),
  OrderStatus VARCHAR(50),
  OrderID INT,
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Load CSV Data (adjust file paths)
LOAD DATA LOCAL INFILE 'data/Customer.csv'
INTO TABLE Customer
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'data/Employee.csv'
INTO TABLE Employee
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'data/Product.csv'
INTO TABLE Product
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'data/Region.csv'
INTO TABLE Region
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'data/Warehouse.csv'
INTO TABLE Warehouse
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'data/Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'data/OrderDetails.csv'
INTO TABLE OrderDetails
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- SQL Analysis Queries

-- Descriptive Statistics

-- Total number of customers
SELECT COUNT(*) AS total_customers FROM Customer;


-- Total products and average price
SELECT COUNT(*) AS total_products, AVG(ProductListPrice) AS avg_price FROM Product;


-- Total sales revenue
SELECT SUM(OrderItemQuantity * PerUnitPrice) AS total_revenue FROM OrderDetails;


-- Average order value
SELECT AVG(order_total) AS avg_order_value
FROM (
SELECT OrderID, SUM(OrderItemQuantity * PerUnitPrice) AS order_total
FROM OrderDetails
GROUP BY OrderID
) t;

-- Data Cleaning

-- Identify NULL values
SELECT * FROM Customer WHERE CustomerName IS NULL OR CustomerEmail IS NULL;


-- Find invalid prices
SELECT * FROM Product WHERE ProductListPrice <= 0;

-- Aggregation & Grouping

-- Total sales by category
SELECT p.CategoryName, SUM(od.OrderItemQuantity * od.PerUnitPrice) AS total_sales
FROM OrderDetails od
JOIN Product p ON od.ProductID = p.ProductID
GROUP BY p.CategoryName
ORDER BY total_sales DESC;


-- Sales by Region
SELECT r.RegionName, SUM(od.OrderItemQuantity * od.PerUnitPrice) AS total_sales
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN Warehouse w ON w.RegionID = (SELECT RegionID FROM Warehouse LIMIT 1)
JOIN Region r ON w.RegionID = r.RegionID
GROUP BY r.RegionName;

-- Joins & Relationships

-- Orders with customer and employee details
SELECT o.OrderID, o.OrderDate, c.CustomerName, e.EmployeeName
FROM Orders o
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN Employee e ON e.WarehouseID IN (SELECT WarehouseID FROM Warehouse);

-- Subqueries & CTEs
-- Month with highest total sales
WITH MonthlySales AS (
SELECT DATE_FORMAT(o.OrderDate, '%Y-%m') AS month,
SUM(od.OrderItemQuantity * od.PerUnitPrice) AS total_sales
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY month
)
SELECT month, total_sales
FROM MonthlySales
ORDER BY total_sales DESC
LIMIT 5;

-- Advanced SQL Functions (Window)

-- Running total of sales per month
WITH MonthlySales AS (
SELECT DATE_FORMAT(o.OrderDate, '%Y-%m') AS month,
SUM(od.OrderItemQuantity * od.PerUnitPrice) AS total_sales
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY month
)
SELECT month, total_sales,
SUM(total_sales) OVER (ORDER BY month) AS running_total
FROM MonthlySales;