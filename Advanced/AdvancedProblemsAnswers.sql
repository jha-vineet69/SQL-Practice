USE northwind;

# Question 31
SELECT C.CustomerID, C.CompanyName, O.OrderID, SUM(OD.Quantity * OD.UnitPrice) AS TotalOrderAmount
FROM customers AS C JOIN orders AS O ON C.CustomerID = O.CustomerID
JOIN orderdetails AS OD ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 2016
GROUP BY C.CustomerID, C.CompanyName, O.OrderID
HAVING TotalOrderAmount>10000
ORDER BY TotalOrderAmount DESC;

# Question 32
SELECT C.CustomerID, C.CompanyName, SUM(OD.Quantity * OD.UnitPrice) AS TotalOrderAmount
FROM customers AS C JOIN orders AS O ON C.CustomerID = O.CustomerID
JOIN orderdetails AS OD ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 2016
GROUP BY C.CustomerID, C.CompanyName
HAVING TotalOrderAmount>15000
ORDER BY TotalOrderAmount DESC;

# Question 33
SELECT EmployeeID, OrderID, OrderDate
FROM orders
WHERE DATE(OrderDate) = LAST_DAY(OrderDate)
ORDER BY EmployeeID, OrderID;

# Question 34
SELECT O.OrderId, COUNT(*) AS TotalOrderDetails
FROM orders AS O 
JOIN orderdetails AS OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID
ORDER BY TotalOrderDetails DESC LIMIT 10;

# Question 35
SELECT OrderID
FROM orderdetails
WHERE Quantity >= 60
GROUP By OrderID, Quantity
HAVING COUNT(*) > 1;

# Question 36
SELECT OrderID, DATE(OrderDate) AS OrderDate, DATE(RequiredDate) AS RequiredDate, DATE(ShippedDate) AS ShippedDate
FROM orders
WHERE ShippedDate >= RequiredDate;

# Question 37
SELECT E.EmployeeID, E.LastName, COUNT(O.OrderID) AS TotalLateOrders
FROM employees AS E
JOIN orders AS O 
WHERE E.EmployeeID = O.EmployeeID AND O.ShippedDate >= O.RequiredDate
GROUP BY E.EmployeeID
ORDER BY TotalLateOrders DESC;

# Question 38
SELECT E.EmployeeID AS EmployeeID, E.LastName, (SELECT COUNT(*) FROM orders WHERE O.EmployeeID = EmployeeID) AS AllOrders, COUNT(O.OrderID) AS LateOrders
FROM employees AS E
JOIN orders AS O 
WHERE E.EmployeeID = O.EmployeeID AND O.ShippedDate >= O.RequiredDate
GROUP BY EmployeeID
ORDER BY EmployeeID;

# Question 39
SELECT EmployeeID, TotalOrders.LastName, TotalOrders.AllOrders, TotalLateOrders.LateOrders
FROM
(SELECT O.EmployeeID, E.LastName, COUNT(*) AS AllOrders
FROM orders AS O 
JOIN employees AS E
ON O.EmployeeID = E.EmployeeID
GROUP BY EmployeeID
ORDER BY EmployeeID) AS TotalOrders

LEFT JOIN
(SELECT E.EmployeeID AS TheEmployeeID, E.LastName, (SELECT COUNT(*) FROM orders WHERE O.EmployeeID = TheEmployeeID) AS AllOrders, COUNT(OrderID) AS LateOrders
FROM employees AS E
JOIN orders AS O 
WHERE E.EmployeeID = O.EmployeeID AND O.ShippedDate >= O.RequiredDate
GROUP BY O.EmployeeID
ORDER BY TheEmployeeID) AS TotalLateOrders

ON TotalOrders.EmployeeID = TotalLateOrders.TheEmployeeID;

# Question 40
SELECT EmployeeID, TotalOrders.LastName, TotalOrders.AllOrders, 
CASE 
	WHEN TotalLateOrders.LateOrders IS NULL THEN 0
    ELSE TotalLateOrders.LateOrders	
END AS LateOrders
FROM
(SELECT O.EmployeeID, E.LastName, COUNT(*) AS AllOrders
FROM orders AS O 
JOIN employees AS E
ON O.EmployeeID = E.EmployeeID
GROUP BY EmployeeID
ORDER BY EmployeeID) AS TotalOrders

LEFT JOIN
(SELECT E.EmployeeID AS TheEmployeeID, E.LastName, (SELECT COUNT(*) FROM orders WHERE O.EmployeeID = TheEmployeeID) AS AllOrders, COUNT(OrderID) AS LateOrders
FROM employees AS E
JOIN orders AS O 
WHERE E.EmployeeID = O.EmployeeID AND O.ShippedDate >= O.RequiredDate
GROUP BY O.EmployeeID
ORDER BY TheEmployeeID) AS TotalLateOrders

ON TotalOrders.EmployeeID = TotalLateOrders.TheEmployeeID;

# Question 41
SELECT EmployeeID, TotalOrders.LastName, TotalOrders.AllOrders, 
CASE 
	WHEN TotalLateOrders.LateOrders IS NULL THEN 0
    ELSE TotalLateOrders.LateOrders	
END AS LateOrders,
CASE
	WHEN TotalLateOrders.LateOrders IS NULL THEN 0
    ELSE LateOrders/TotalOrders.AllOrders
END AS PercentLateOrders
FROM
(SELECT O.EmployeeID, E.LastName, COUNT(*) AS AllOrders
FROM orders AS O 
JOIN employees AS E
ON O.EmployeeID = E.EmployeeID
GROUP BY EmployeeID
ORDER BY EmployeeID) AS TotalOrders

LEFT JOIN
(SELECT E.EmployeeID AS TheEmployeeID, E.LastName, (SELECT COUNT(*) FROM orders WHERE O.EmployeeID = TheEmployeeID) AS AllOrders, COUNT(OrderID) AS LateOrders
FROM employees AS E
JOIN orders AS O 
WHERE E.EmployeeID = O.EmployeeID AND O.ShippedDate >= O.RequiredDate
GROUP BY O.EmployeeID
ORDER BY TheEmployeeID) AS TotalLateOrders

ON TotalOrders.EmployeeID = TotalLateOrders.TheEmployeeID;

# Question 42
SELECT EmployeeID, TotalOrders.LastName, TotalOrders.AllOrders, 
CASE 
	WHEN TotalLateOrders.LateOrders IS NULL THEN 0
    ELSE TotalLateOrders.LateOrders	
END AS LateOrders,
CASE
	WHEN TotalLateOrders.LateOrders IS NULL THEN 0
    ELSE ROUND((LateOrders/TotalOrders.AllOrders),2)
END AS PercentLateOrders
FROM
(SELECT O.EmployeeID, E.LastName, COUNT(*) AS AllOrders
FROM orders AS O 
JOIN employees AS E
ON O.EmployeeID = E.EmployeeID
GROUP BY EmployeeID
ORDER BY EmployeeID) AS TotalOrders

LEFT JOIN
(SELECT E.EmployeeID AS TheEmployeeID, E.LastName, (SELECT COUNT(*) FROM orders WHERE O.EmployeeID = TheEmployeeID) AS AllOrders, COUNT(OrderID) AS LateOrders
FROM employees AS E
JOIN orders AS O 
WHERE E.EmployeeID = O.EmployeeID AND O.ShippedDate >= O.RequiredDate
GROUP BY O.EmployeeID
ORDER BY TheEmployeeID) AS TotalLateOrders

ON TotalOrders.EmployeeID = TotalLateOrders.TheEmployeeID;