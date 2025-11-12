drop database datadigger;

create database datadigger;

use datadigger;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE,
    Address VARCHAR(255)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(12,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(150) NOT NULL,
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    Stock INT NOT NULL DEFAULT 0 CHECK (Stock >= 0)
    
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    SubTotal DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers (Name, Email, Address) VALUES
('Alice Johnson', 'alice.j@example.com', '12 Rose Street, Rajkot'),
('Bob Mehta', 'bob.m@example.com', '45 Lake View, Rajkot'),
('Charlie Patel', 'charlie.p@example.com', '78 Hill Road, Rajkot'),
('Dinesh Shah', 'dinesh.s@example.com', '9 Market Lane, Rajkot'),
('Esha Gupta', 'esha.g@example.com', '101 River Drive, Rajkot');

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, DATE_SUB(CURRENT_DATE(), INTERVAL 5 DAY), 2850.00),
(2, DATE_SUB(CURRENT_DATE(), INTERVAL 40 DAY), 450.00),
(1, DATE_SUB(CURRENT_DATE(), INTERVAL 20 DAY), 1999.00),
(3, DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), 1500.00),
(5, DATE_SUB(CURRENT_DATE(), INTERVAL 10 DAY), 750.00);

INSERT INTO Products (ProductName, Price, Stock) VALUES
('Pan Delight', 1200.00, 50),
('Mukhwas Mix', 450.00, 30),
('Royal Pan', 1999.00, 10),
('Fresh Pan', 299.00, 0),    
('Spicy Twist', 750.00, 25);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal) VALUES
(1, 1, 2, 2400.00),  
(1, 2, 1, 450.00),  
(2, 2, 1, 450.00),   
(3, 3, 1, 1999.00),  
(4, 5, 2, 1500.00),  
(5, 5, 1, 750.00);  


select * from customers;
UPDATE Customers SET Address = '99 New Market, Rajkot' WHERE CustomerID = 2;
DELETE FROM Customers WHERE CustomerID = 4;
SELECT * FROM Customers WHERE Name LIKE 'Alice%';


SELECT * FROM Orders WHERE CustomerID = 1;
UPDATE Orders SET TotalAmount = 500.00 WHERE OrderID = 2;
DELETE FROM Orders WHERE OrderID = 2;
SELECT * FROM Orders WHERE OrderDate >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY);


SELECT * FROM Products ORDER BY Price DESC;
UPDATE Products SET Price = ROUND(Price * 1.10, 2) WHERE ProductID = 5;
DELETE FROM Products WHERE Stock = 0;
SELECT * FROM Products WHERE Price BETWEEN 500 AND 2000;
SELECT MAX(Price) AS MostExpensive, MIN(Price) AS Cheapest FROM Products;


select * from orderdetails where orderid = 1;
select sum(subtotal) as totalrevenue from orderdetails;
SELECT ProductID, SUM(Quantity) AS TotalQuantitySold FROM OrderDetails GROUP BY ProductID ORDER BY TotalQuantitySold DESC LIMIT 3;
SELECT COUNT(*) AS TimesProductAppearedInOrders FROM OrderDetails WHERE ProductID = 2;
