CREATE TABLE SalesTrans
(
    TransID INT IDENTITY(1,1) PRIMARY KEY,
    TransDate DATE,
    PharmacistID INT,
    PatientID INT,
    BranchID INT,
    DrugID INT,
    Quantity INT
);

SELECT * FROM SalesTrans

TRUNCATE TABLE SalesTrans



DECLARE @DrugID INT
DECLARE @BranchID INT
DECLARE @PharmacistID INT
DECLARE @PatientID INT
DECLARE @TransDate DATE
DECLARE @Quantity INT
DECLARE @CurrentYear INT = 2018
DECLARE @MaxYear INT = 2022
DECLARE @TotalRecord INT
DECLARE @CurrentRecord INT = 1
DECLARE @nEmpID INT

WHILE @CurrentYear <= @MaxYear
BEGIN
	SET NOCOUNT ON
    SELECT @TotalRecord = 500000
    SELECT @CurrentRecord = 1

    WHILE @CurrentRecord <= @TotalRecord
    BEGIN
        -- Generate a random PharmacistID
		IF OBJECT_ID('tempdb..#EmpTemp') IS NOT NULL
            DROP TABLE #EmpTemp

        SELECT ROW_NUMBER() OVER (ORDER BY EmpID) AS nEmpID, EmpID, LastName + ' ' + Firstname AS Name INTO #EmpTemp
        FROM Employee
        WHERE RoleID = 1

        SELECT @nEmpID = (SELECT CAST(RAND() * (SELECT MAX(nEmpID) FROM #EmpTemp) AS INT) + 1)
        SELECT @PharmacistID = (SELECT EmpID FROM #EmpTemp WHERE nEmpID = @nEmpID)
		

		-- Other randomly generated items
		SELECT @DrugID = CAST(RAND() * (SELECT MAX(DrugID) FROM Drug) AS INT) + 1
        SELECT @BranchID = CAST(RAND() * (SELECT MAX(BranchID) FROM Branch) AS INT) + 1
        SELECT @PatientID = CAST(RAND() * (SELECT MAX(PatientID) FROM Patients) AS INT) + 1
        SELECT @TransDate = DATEADD(DAY, CAST(RAND() * -1825 AS INT), GETDATE())
		SELECT @Quantity = CAST(RAND() * 5 AS INT) + 1
	

        -- Insert the random data into SalesTrans
        INSERT INTO SalesTrans (
								TransDate,
								PharmacistID,
								PatientID,
								BranchID,
								DrugID,
								Quantity
							   )
        SELECT @TransDate, @PharmacistID, @PatientID, @BranchID, @DrugID, @Quantity

        SELECT @CurrentRecord = @CurrentRecord + 1
    END

    SELECT @CurrentYear = @CurrentYear + 1
END




SELECT * FROM SalesTrans

SELECT * FROM #EmpTemp

SELECT DATEDIFF(day, '2018-01-01', '2022-12-31')


SELECT @TransDate = DATEADD(day, CAST(RAND() * (SELECT DATEDIFF(day, '2018-01-01', '2022-12-31') AS INT), GETDATE()))


SELECT CAST(RAND() * (SELECT MAX(EmpID) FROM Employee) AS INT) + 1

SELECT ROW_NUMBER() OVER (ORDER BY EmpID) AS nEmpID, EmpID, LastName, FirstName, RoleID INTO #EmpTemp FROM Employee WHERE RoleID=1

SELECT * FROM #EmpTemp