-- Data Analysis Queries

-- A) Descriptive statistics & basic KPIs


-- 1. Total sales (sum of quantity * price) across orders
SELECT SUM(od.OrderItemQuantity * od.PerUnitPrice) AS total_sales
FROM OrderDetails od;


-- 2. Average order value (AOV) = total sales / number of distinct orders
SELECT
SUM(od.OrderItemQuantity * od.PerUnitPrice)/COUNT(DISTINCT od.OrderID) AS avg_order_value,
COUNT(DISTINCT od.OrderID) AS number_of_orders,
SUM(od.OrderItemQuantity * od.PerUnitPrice) AS total_sales
FROM OrderDetails od;


-- 3. Total transactions and totals per status
SELECT od.OrderStatus, COUNT(*) AS transaction_count, SUM(od.OrderItemQuantity*od.PerUnitPrice) AS status_sales
FROM OrderDetails od
GROUP BY od.OrderStatus;


-- 4. Product-level statistics (sold quantity, revenue)
SELECT p.ProductID, p.ProductName, p.CategoryName,
SUM(od.OrderItemQuantity) AS total_qty_sold,
SUM(od.OrderItemQuantity * od.PerUnitPrice) AS revenue
FROM Product p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName, p.CategoryName
ORDER BY revenue DESC
LIMIT 20;

-- B) Data cleaning checks

-- 1. Find NULLs in key columns
SELECT 'OrderDetails' AS table_name, COUNT(*) AS null_count
FROM OrderDetails
WHERE ProductID IS NULL OR OrderID IS NULL OR OrderItemQuantity IS NULL OR PerUnitPrice IS NULL;


SELECT 'Orders' AS table_name, COUNT(*) AS null_count FROM Orders WHERE OrderDate IS NULL OR CustomerID IS NULL;


-- 2. Find duplicated primary keys (if CSV has duplicates)
SELECT OrderDetailsID, COUNT(*) c FROM OrderDetails GROUP BY OrderDetailsID HAVING c>1;


-- 3. Outliers check: negative or zero prices/quantities
SELECT * FROM OrderDetails WHERE OrderItemQuantity <=0 OR PerUnitPrice <= 0 LIMIT 50;


-- Action notes (not SQL):
-- - If rows with NULL in non-nullable business keys exist, either remove or fill after domain logic (e.g., missing price: set to product list price).
-- - For negative prices/qty, inspect original CSV and correct or exclude.

-- C) Aggregations and grouping

-- Total sales by product category
SELECT p.CategoryName, SUM(od.OrderItemQuantity * od.PerUnitPrice) AS category_sales,
SUM(od.OrderItemQuantity) AS total_units
FROM Product p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.CategoryName
ORDER BY category_sales DESC;


-- Sales by region (join via warehouse -> region -> employee -> ???)
-- If orders are not directly linked to warehouse, you can attribute orders to warehouses via employees if Order/Employee linkage exists;
-- If not available, aggregate customer locations instead:


SELECT r.RegionName, r.CountryName, SUM(od.OrderItemQuantity * od.PerUnitPrice) AS sales
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN Warehouse w ON w.RegionID = r.RegionID -- only possible if you can join customers to warehouses; otherwise skip
JOIN Region r ON w.RegionID = r.RegionID
GROUP BY r.RegionName, r.CountryName
ORDER BY sales DESC;


-- If customer region isn't available, derive City/State from CustomerAddress using string

