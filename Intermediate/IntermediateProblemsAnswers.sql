USE northwind;

# Question 20
SELECT C.CategoryName, COUNT(*) AS TotalProducts
FROM products AS P
JOIN categories AS C on C.CategoryID = P.CategoryID
GROUP BY CategoryName
ORDER BY TotalProducts DESC;

# Question 21
SELECT Country, City, COUNT(*) AS TotalCustomers
FROM customers
GROUP BY Country, City
ORDER BY TotalCustomers DESC;

# Question 22
SELECT ProductID, ProductName, UnitsInStock, ReorderLevel
FROM products
WHERE UnitsInStock < ReorderLevel
ORDER BY ProductID;

# Question 23
SELECT ProductID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
FROM products
WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel AND Discontinued = 0;

# Question 24
SELECT CustomerID, CompanyName, Region
FROM customers
ORDER BY (CASE WHEN Region IS NULL THEN 1 ELSE 0 END), Region, CustomerID;

# Question 25
SELECT ShipCountry, AVG(Freight) AS AverageFreight
FROM orders
GROUP BY ShipCountry
ORDER BY AverageFreight DESC LIMIT 3;

# Question 26
SELECT ShipCountry, AVG(Freight) AS AverageFreight
FROM orders
WHERE YEAR(OrderDate)= '2015'
GROUP BY ShipCountry
ORDER BY AverageFreight DESC LIMIT 3;

# Question 27
SELECT ShipCountry, AVG(Freight) AS AverageFreight
FROM orders
WHERE OrderDate >= DATE_ADD((SELECT MAX(OrderDate) FROM orders), INTERVAL -12 MONTH)
GROUP BY ShipCountry
ORDER BY AverageFreight DESC LIMIT 3;

# Question 28
SELECT E.EmployeeID, E.LastName, O.OrderID, P.ProductName, OD.Quantity
FROM employees AS E JOIN orders AS O ON E.EmployeeID = O.EmployeeID
JOIN orderdetails AS OD ON O.OrderID = OD.OrderID
JOIN products AS P ON OD.ProductID = P.ProductID
ORDER BY O.OrderID, P.ProductID;

# Question 29
SELECT C.CustomerID AS Customers_CustomerID, O.OrderID AS Orders_CustomerID
FROM customers AS C LEFT JOIN orders AS O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;

# Question 30
SELECT C.CustomerID, O.OrderID 
FROM customers AS C LEFT JOIN orders AS O ON C.CustomerID = O.CustomerID AND O.EmployeeID = 4
WHERE O.CustomerID IS NULL;
