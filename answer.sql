-- WEEK 7 ASSIGNMENT: DATABASE DESIGN AND NORMALIZATION

CREATE DATABASE IF NOT EXISTS week7_normalization;
USE week7_normalization;

-- ==========================================
-- QUESTION 1: FIRST NORMAL FORM (1NF)
-- ==========================================

CREATE TABLE ProductDetail_1NF (
    OrderID INT NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Product VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID, Product)
);

INSERT INTO ProductDetail_1NF
    (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Verify Question 1
SELECT * FROM ProductDetail_1NF;


-- ==========================================
-- QUESTION 2: SECOND NORMAL FORM (2NF)
-- ==========================================

-- CustomerName depends only on OrderID.
-- This is a partial dependency.

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

CREATE TABLE OrderItems (
    OrderID INT NOT NULL,
    Product VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
);

-- Insert order information
INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Insert product information
INSERT INTO OrderItems
    (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

-- Verify Orders
SELECT * FROM Orders;

-- Verify OrderItems
SELECT * FROM OrderItems;

-- Verify relationship using INNER JOIN
SELECT
    o.OrderID,
    o.CustomerName,
    oi.Product,
    oi.Quantity
FROM Orders AS o
INNER JOIN OrderItems AS oi
    ON o.OrderID = oi.OrderID;answer.sql