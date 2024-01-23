CREATE DATABASE K2A;

USE K2A

----Float Category Table-----
 CREATE TABLE FloatTable (
    FloatCategoryID INT,
    FloatRate FLOAT,
    FloatExceedQty FLOAT,
    FloatExceedRate FLOAT
);

 INSERT INTO FloatTable (FloatCategoryID, FloatRate, FloatExceedQty, FloatExceedRate)
VALUES
    (1, 0.4, 15, 0.7),
    (2, 0.1, 15, 0.6),
    (3, 0.2, 50, 0.75),
    (4, 0.24, 68, 0.9),
    (5, 0.12, 100, 1.8);
 

-- Create the Equipment table
CREATE TABLE Equipment (
    EquipmentID INT,
    EquipmentName VARCHAR(255),
    UnitPrice DECIMAL(12, 2),
    DiscountPercent FLOAT,
    FloatCategoryID INT
);

-- Insert Equipment data
INSERT INTO Equipment (EquipmentID, EquipmentName, UnitPrice, DiscountPercent, FloatCategoryID)
VALUES
    (1, 'Cup-Lock System of Shuttering – 3.2 M high', 122.50, 0.015, 1),
    (2, 'Steel Props – 4.2 M High', 100.00, 0.02, 1),
    (3, 'Steel shuttering plates – 3 ft x 2 ft', 1000.50, 0.05, 1),
    (4, 'Steel section Girders – 8ft to 12 ft', 1700.00, 0.01, 1),
    (5, 'Steel pipes for scaffolding', 15000.00, 0.08, 1),
    (6, 'Telescopic Girders', 200.00, 0.4, 1),
    (7, 'Tower Crane', 233.00, 0.14, 1),
    (8, 'Tractor mounted Crane', 105.00, 0.4, 1),
    (9, 'Concrete batching plant', 1325.70, 0.015, 1),
    (10, 'Mobile batching plant', 99.87, 0.011, 1),
    (11, 'Concrete Pump (Greaves – 40 cum/hr)', 1500.50, 0.095, 1),
    (12, 'Tremix machine set with trowel & floater', 700.69, 0.15, 1),
    (13, 'Concrete mixers', 120.00, 0.15, 1),
    (14, 'D.G. Set – 82.KVA', 12.50, 0.15, 1),
    (15, 'Vibrators (Electrical)', 200.99, 0.001, 1),
    (16, 'Vibrators (Petrol)', 4100.90, 0.03, 1),
    (17, 'Stone cutting machine (Platform type)', 1200.56, 0.09, 1),
    (18, 'Stone cutting machine (hand type)', 1780.00, 0.0094, 1),
    (19, 'Groove cutting machine', 122.50, 0.5, 1),
    (20, 'Builder’s Hoist with winch', 122.50, 0.5, 1),
    (21, 'Bar Bending & cutting machine', 122.50, 0.5, 1),
    (22, 'Truck', 122.50, 0.5, 1),
    (23, 'Air Compressor', 122.50, 0.5, 1),
    (24, 'Road Roller', 122.50, 0.5, 1),
    (25, 'Vibro-Roller', 122.50, 0.5, 1),
    (26, 'Tipper – Tata', 122.50, 0.5, 1),
    (27, 'Excavator – ACE', 122.50, 0.5, 1),
    (28, 'Tractor with trolly – 40 HP', 122.50, 0.5, 1),
    (29, 'Water pump', 122.50, 0.5, 1),
    (30, 'Cutter Hitachi – Model CM 45', 122.50, 0.5, 1),
    (31, 'Welding Set – Aircooled', 122.50, 0.5, 1),
    (32, 'Drilling Machine Bosch – GSB – 16', 122.50, 0.5, 1),
    (33, 'Mud pump – GEC – 1 HP 2 HP', 122.50, 0.5, 1),
    (34, 'Floor Grinding machine – 2 HP', 122.50, 0.5, 1),
    (35, 'Earth Compactor – 7.5 HP motor', 122.50, 0.5, 1),
    (36, 'CGI Sheets – 10′, 12′ Long', 122.50, 0.5, 1);

-- Create the Customer table
CREATE TABLE Customer (
    CustomerID INT,
    CustomerName VARCHAR(255),
    Category VARCHAR(255),
    PrimaryContact VARCHAR(255),
    ReferenceNo VARCHAR(255),
    PaymentDays INT,
    PostalCode INT
);

-- Insert Customer data
INSERT INTO Customer (CustomerID, CustomerName, Category, PrimaryContact, ReferenceNo, PaymentDays, PostalCode)
VALUES
    (1, 'A Datum Corporation', 'Novelty Goods Supplier', 'Reio Kabin', 'AA20384', 14, 46077),
    (2, 'Woodgrove Bank', 'Financial Services Supplier', 'Hubert Helms', '28034202', 7, 94101),
    (3, 'Consolidated Messenger', 'Courier', 'Kerstin Parn', '209340283', 30, 94101),
    (4, 'Litware Inc.', 'Packaging Supplier', 'Elias Myllari', 'BC0280982', 30, 95245),
    (5, 'Humongous Insurance', 'Insurance Services Supplier', 'Madelaine Cartier', '82420938', 14, 37770),
    (6, 'Graphic Design Institute', 'Novelty Goods Supplier', 'Penny Buck', '8803922', 14, 64847),
    (7, 'Fabrikam Inc.', 'Clothing Supplier', 'Bill Lawson', '293092', 30, 40351),
    (8, 'The Phone Company', 'Novelty Goods Supplier', 'Hai Dam', '237408032', 30, 56732),
    (9, 'Trey Research', 'Marketing Services Supplier', 'Donald Jones', '82304822', 7, 57543),
    (10, 'Lucerne Publishing', 'Novelty Goods Supplier', 'Prem Prabhu', 'JQ082304802', 30, 37659),
    (11, 'Contoso Ltd.', 'Novelty Goods Supplier', 'Hanna Mihhailov', 'B2084020', 7, 98253),
    (12, 'Nod Publishers', 'Novelty Goods Supplier', 'Marcos Costa', 'GL08029802', 7, 27906),
    (13, 'Northwind Electric Cars', 'Toy Supplier', 'Eliza Soderberg', 'ML0300202', 30, 7860),
    (14, 'A Datum Corporation', 'Novelty Goods Supplier', 'Reio Kabin', 'AA20384', 14, 46077),
    (15, 'Contoso Ltd.', 'Novelty Goods Supplier', 'Hanna Mihhailov', 'B2084020', 7, 98253),
    (16, 'Consolidated Messenger', 'Courier', 'Kerstin Parn', '209340283', 30, 94101),
    (17, 'Fabrikam Inc.', 'Clothing Supplier', 'Bill Lawson', '293092', 30, 40351),
    (18, 'Graphic Design Institute', 'Novelty Goods Supplier', 'Penny Buck', '8803922', 14, 64847),
    (19, 'Humongous Insurance', 'Insurance Services Supplier', 'Madelaine Cartier', '82420938', 14, 37770),
    (20, 'Litware Inc.', 'Packaging Supplier', 'Elias Myllari', 'BC0280982', 30, 95245),
    (21, 'Lucerne Publishing', 'Novelty Goods Supplier', 'Prem Prabhu', 'JQ082304802', 30, 37659),
    (22, 'Nod Publishers', 'Novelty Goods Supplier', 'Marcos Costa', 'GL08029802', 7, 27906),
    (23, 'Northwind Electric Cars', 'Toy Supplier', 'Eliza Soderberg', 'ML0300202', 30, 7860),
    (24, 'Trey Research', 'Marketing Services Supplier', 'Donald Jones', '82304822', 7, 57543),
    (25, 'The Phone Company', 'Novelty Goods Supplier', 'Hai Dam', '237408032', 30, 56732),
    (26, 'Woodgrove Bank', 'Financial Services Supplier', 'Hubert Helms', '28034202', 7, 94101),
    (27, 'Consolidated Messenger', 'Courier Services Supplier', 'Kerstin Parn', '209340283', 30, 94101);



--- Create Equipment Transaction Table

CREATE TABLE EquipmentTransaction (
    TransID INT IDENTITY(1,1) PRIMARY KEY,
    TransDate DATETIME,
    CustomerID INT,
    EquipmentID INT,
    Quantity FLOAT,
    GrossAmount DECIMAL(12, 2),
    DiscountAmount DECIMAL(12, 2),
    FloatRateAmount DECIMAL(12, 2),
    FloatExceededAmount DECIMAL(12, 2),
    PostalVariationAmount DECIMAL(12, 2)
);






----T-SQL


DECLARE @TransDate DATETIME
DECLARE @CustomerID INT
DECLARE @EquipmentID INT
DECLARE @Quantity FLOAT
DECLARE @GrossAmount DECIMAL(12, 2)
DECLARE @DiscountAmount DECIMAL(12, 2)
DECLARE @FloatRateAmount DECIMAL(12, 2)
DECLARE @FloatExceededAmount DECIMAL(12, 2)
DECLARE @PostalVariationAmount DECIMAL(12, 2)
DECLARE @VarRate FLOAT
DECLARE @CurrentYear INT = 2015
DECLARE @MaxYear INT = 2019
DECLARE @CurrentRecord INT
DECLARE @TotalRecord INT

WHILE @CurrentYear <= @MaxYear 
BEGIN
    SET NOCOUNT ON
    SELECT @CurrentRecord = 1
    SELECT @TotalRecord = 100 ---(100 was used as a testcase)
    
    WHILE @CurrentRecord <= @TotalRecord
    BEGIN
        SELECT @TransDate = DATEADD(day, CAST(RAND() * DATEDIFF(day, '2015-01-01', '2019-05-31') AS INT), '2015-01-01')
        SELECT @CustomerID = CAST(RAND() * (SELECT MAX(CustomerID) FROM Customer) AS INT) + 1
        SELECT @EquipmentID = CAST(RAND() * (SELECT MAX(EquipmentID) FROM Equipment) AS INT) + 1
        SELECT @Quantity = CAST(RAND() * 250 AS INT) + 1
        
        SELECT @GrossAmount = UnitPrice * @Quantity FROM Equipment WHERE EquipmentID = @EquipmentID
        SELECT @DiscountAmount = @GrossAmount * (1 - DiscountPercent) FROM Equipment WHERE EquipmentID = @EquipmentID
        SELECT @FloatRateAmount = @GrossAmount * (1 - (SELECT FloatRate FROM FloatTable WHERE FloatCategoryID IN (SELECT FloatCategoryID FROM Equipment WHERE EquipmentID = @EquipmentID))) WHERE @Quantity BETWEEN 100 AND 150
        SELECT @FloatExceededAmount = @GrossAmount * (1 - (SELECT FloatExceedRate FROM FloatTable WHERE FloatCategoryID IN (SELECT FloatCategoryID FROM Equipment WHERE EquipmentID = @EquipmentID))) WHERE @Quantity > 150
        
        SELECT @VarRate = 
            CASE 
                WHEN PostalCode BETWEEN 7000 AND 50000 THEN 0.002 
                WHEN PostalCode BETWEEN 50001 AND 70000 THEN 0.05
                WHEN PostalCode BETWEEN 70001 AND 90000 THEN 0.062
                ELSE 0.0078
            END 
        FROM Customer 
        WHERE CustomerID = @CustomerID;
        
        SELECT @PostalVariationAmount = @GrossAmount * (1 - @VarRate)

        -- Insert the generated values into EquipmentTransaction table
        INSERT INTO EquipmentTransaction (
            TransDate,
            CustomerID,
            EquipmentID,
            Quantity,
            GrossAmount,
            DiscountAmount,
            FloatRateAmount,
            FloatExceededAmount,
            PostalVariationAmount
        )
        VALUES (
            @TransDate,
            @CustomerID,
            @EquipmentID,
            @Quantity,
            @GrossAmount,
            @DiscountAmount,
            @FloatRateAmount,
            @FloatExceededAmount,
            @PostalVariationAmount
        )

        -- Increment the current record counter
        SELECT @CurrentRecord = @CurrentRecord + 1
    END

    -- Increment the current year
    SELECT @CurrentYear = @CurrentYear + 1	
END

---- TEST WITH THIS

select*from EquipmentTransaction
Order by TransDate

truncate table equipmenttransaction