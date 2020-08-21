USE northwind;

# Question 1
SELECT * FROM shippers;

# Question 2
SELECT CategoryName, Description FROM categories;

# Question 3
SELECT FirstName, LastName, HireDate
FROM employees
WHERE Title="Sales Representative";

# Question 4
SELECT FirstName, LastName, HireDate
FROM employees
WHERE Title="Sales Representative" AND Country="USA";

# Question 5
SELECT OrderID, OrderDate 
FROM orders
WHERE EmployeeID=5;

# Question 6
SELECT SupplierID, ContactName, ContactTitle
FROM suppliers
WHERE NOT ContactTitle="Marketing Manager";

SELECT SupplierID, ContactName, ContactTitle
FROM suppliers
WHERE ContactTitle <> "Marketing Manager";

# Question 7
SELECT ProductID, ProductName
FROM products
WHERE ProductName LIKE '%queso%';

# Question 8
SELECT OrderID, CustomerID, ShipCountry
FROM orders
WHERE ShipCountry IN ("France", "Belgium");

# Question 9
SELECT OrderID, CustomerID, ShipCountry
FROM orders
WHERE ShipCountry IN ("Brazil","Mexico","Argentina","Venezuela");

# Question 10
SELECT FirstName, LastName, Title, BirthDate
FROM employees
ORDER BY BirthDate;

# Question 11
SELECT FirstName, LastName, Title, DATE(BirthDate) as DateOnlyBirthDate
FROM employees
ORDER BY DateOnlyBirthDate;

# Question 12
SELECT FirstName, LastName, CONCAT(FirstName, ' ', LastName) as FullName
FROM employees;

# Question 13
SELECT OrderID, ProductID, UnitPrice, Quantity, (UnitPrice*Quantity) AS TotalPrice
FROM orderdetails
GROUP BY OrderID, ProductID;

# Question 14
SELECT COUNT(*) AS TotalCustomers
FROM customers;

# Question 15
SELECT OrderDate
FROM orders
ORDER BY OrderDate
LIMIT 1;

SELECT MIN(OrderDate) AS FirstOrder
FROM orders;

# Question 16
SELECT DISTINCT Country 
FROM customers
ORDER BY Country;

# Question 17
SELECT ContactTitle, COUNT(*) AS TotalContactTitle
FROM customers
GROUP BY ContactTitle
ORDER BY TotalContactTitle DESC;

# Question 18
SELECT products.ProductID, products.ProductName, suppliers.CompanyName AS Supplier
FROM products INNER JOIN suppliers ON products.SupplierID = suppliers.SupplierID
ORDER BY products.ProductID;

# Question 19
SELECT orders.OrderID, DATE(orders.OrderDate) AS OrderDate, shippers.CompanyName AS Shipper
FROM orders INNER JOIN shippers ON orders.ShipVia = shippers.ShipperID
WHERE orders.OrderID < 10300
ORDER BY orders.OrderID;