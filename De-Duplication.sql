USE [SQL ESSENTIALS]

SELECT TransID, OrderID, AccountNumber, Supplier, City, DueDate, OrderDate,getdate() AS LastUpdate INTO PurchaseTransDup FROM PurchaseTrans

BEGIN	
	SET NOCOUNT ON
	BEGIN TRANS;

--- move data to a temp table
IF OBJECT_ID('tempdb..##PurchaseTransDup') IS NOT NULL
DROP TABLE ##PurchaseTransDup

SELECT * into ##PurchaseTransDup FROM PurchaseTransDup

--- Seperate ##WtDuplicate from ##PurchaseTransDup
IF OBJECT_ID('tempdb..##WtDuplicate') IS NOT NULL
DROP TABLE ##WtDuplicate

SELECT TransID, OrderID, AccountNumber, Supplier, City, DueDate, OrderDate, GetDate() as LastUpdate INTO ##WtDuplicate from ##PurchaseTransDup
WHERE OrderID IN (
					SELECT OrderID FROM ##PurchaseTransDup
					GROUP BY OrderID
					HAVING COUNT(*) > 1
				  )

--- Seperate ##WtOutDuplicate from ##PurchaseTransDup
IF OBJECT_ID('tempdb..##WtOutDuplicate') IS NOT NULL
DROP TABLE ##WtOutDuplicate

SELECT TransID, OrderID, AccountNumber, Supplier, City, DueDate, OrderDate, LastUpdate INTO ##WtOutDuplicate from ##PurchaseTransDup
WHERE OrderID IN (
					SELECT OrderID FROM ##PurchaseTransDup
					GROUP BY OrderID
					HAVING COUNT(*) = 1
				  )

--- Remove Duplicates and store in ##DeDuplicate
--- Assume Business rule says retain last entry
IF OBJECT_ID('tempdb..##DeDuplicate') IS NOT NULL
DROP TABLE ##DeDuplicate

SELECT MAX(TransID) AS TransID, OrderID, AccountNumber, Supplier, City, DueDate, OrderDate,LastUpdate INTO ##DeDuplicate from ##WtDuplicate
GROUP BY OrderID, AccountNumber, Supplier, City, DueDate, OrderDate,LastUpdate
ORDER BY OrderID

--- Merge ##DeDuplicate wt ##WtoutDuplicate
--- Move the Merged into ##ValidPurchaseTrans
IF OBJECT_ID('tempdb..##ValidPurchaseTrans') IS NOT NULL
DROP TABLE ##ValidPurchaseTrans

SELECT a.TransID, a.OrderID, a.AccountNumber, a.Supplier, a.City, a.DueDate, a.OrderDate, a.LastUpdate INTO ##ValidPurchaseTrans 
FROM (
		SELECT TransID, OrderID, AccountNumber, Supplier, City, DueDate, OrderDate, LastUpdate from ##DeDuplicate
		UNION all
		SELECT TransID, OrderID, AccountNumber, Supplier, City, DueDate, OrderDate, LastUpdate from ##WtOutDuplicate
	  ) a
				

INSERT INTO AuditControl.dbo.PurchaseTransAudit(TransID, OrderID, AccountNumber, Supplier, City, DueDate, OrderDate, LastUpdate_
SELECT TransID, OrderID, AccountNumber, Supplier, City, DueDate, OrderDate, LastUpdate FROM ##WtDuplicate

---Effect Change on Main Table
DELETE FROM PurchaseTransDup WHERE TransID NOT IN (SELECT TransID FROM ##ValidPurchaseTrans)

COMMIT;

END




IF OBJECT_ID('tempdb..') IS NOT NULL
DROP TABLE









---FOR AUDIT PURPOSES, Keep ##WtDuplicate Records

--- Created Table with No Data
SELECT TransID, OrderID, AccountNumber, Supplier, City, DueDate, OrderDate, LastUpdate, LogDate INTO AuditControl.dbo.PurchaseTransAudit 
FROM ##PurchaseTransDup
WHERE 1=2

drop table PurchaseTransAudit

select*from PurchaseTransAudit


---
INSERT INTO AuditControl.dbo.PurchaseTransAudit(TransID, OrderID, AccountNumber, Supplier, City, DueDate, OrderDate, LastUpdate_
SELECT TransID, OrderID, AccountNumber, Supplier, City, DueDate, OrderDate, LastUpdate FROM ##WtDuplicate