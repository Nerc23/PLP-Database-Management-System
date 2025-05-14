-- Database: InventoryTrackingSystem

-- Table: Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(255) NOT NULL,
    Description TEXT,
    SKU VARCHAR(50) UNIQUE NOT NULL, -- Stock Keeping Unit
    CategoryID INT NOT NULL,
    SupplierID INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Table: Categories
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100) UNIQUE NOT NULL
);

-- Table: Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(255),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Address TEXT
);

-- Table: Inventory
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    QuantityInStock INT NOT NULL DEFAULT 0,
    LastStockUpdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    LocationID INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
    UNIQUE KEY (ProductID, LocationID) -- Ensure unique product per location
);

-- Table: Locations
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY AUTO_INCREMENT,
    LocationName VARCHAR(100) UNIQUE NOT NULL,
    Address TEXT
);

-- Table: PurchaseOrders
CREATE TABLE PurchaseOrders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(50) DEFAULT 'Pending', -- e.g., Pending, Processing, Shipped, Received
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Table: OrderItems (Details of products in each purchase order)
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL, -- Price at the time of order
    FOREIGN KEY (OrderID) REFERENCES PurchaseOrders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Table: SalesOrders
CREATE TABLE SalesOrders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE NOT NULL,
    CustomerID INT, -- Optional: if you want to track customers
    OrderStatus VARCHAR(50) DEFAULT 'Pending' -- e.g., Pending, Processing, Shipped, Delivered
    -- Add other relevant customer or sales details if needed
);

-- Table: SalesOrderItems (Details of products in each sales order)
CREATE TABLE SalesOrderItems (
    SalesOrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL, -- Price at the time of sale
    FOREIGN KEY (OrderID) REFERENCES SalesOrders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
