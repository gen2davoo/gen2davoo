BEGIN
	SET NOCOUNT ON	
	IF OBJECT_ID('tempdb..##purchaseTransDup') is not null 
		drop table ##purchaseTransDup

	select p.TransID,p.OrderID,p.AccountNumber,p.Supplier,p.City,p.DueDate,p.OrderDate,p.Lastupdate into ##purchaseTransDup
	from  PurchaseTransDup p 

	IF OBJECT_ID('tempdb..##DuplicateOnly') is not null 
		 drop table ##DuplicateOnly

	Select p.TransID,p.OrderID,p.AccountNumber,p.Supplier,p.City,p.DueDate,p.OrderDate,p.Lastupdate into ##DuplicateOnly from  ##purchaseTransDup p
	Where p.OrderID in (
					select OrderId from ##purchaseTransDup 
					group by OrderID
				 	having Count(*)>1
					)

	IF OBJECT_ID('tempdb..##deduplicate') is not null 
		drop table ##deduplicate

 	Select  Max(TransID) TransID,OrderID,AccountNumber,Supplier,City,DueDate,OrderDate into ##deduplicate from ##DuplicateOnly
	group by OrderID,AccountNumber,Supplier,City,DueDate,OrderDate

	IF OBJECT_ID('tempdb..##validPurchaseTrans') is not null 
		drop table ##validPurchaseTrans
	select   a.TransID,a.OrderID, a.AccountNumber,a.Supplier,a.City,a.DueDate,a.OrderDate,a.LastUpdate into ##validPurchaseTrans from  
	(
   
		Select  TransID ,OrderID,AccountNumber,Supplier,City,DueDate,OrderDate, GETDATE() as LastUpdate from ##deduplicate 
			union all		
		Select p.TransID,p.OrderID,p.AccountNumber,p.Supplier,p.City,p.DueDate,p.OrderDate,p.Lastupdate  from  ##purchaseTransDup p
		Where p.OrderID in (
					select OrderId from ##purchaseTransDup 
					group by OrderID
				 	having Count(*)=1
	  		)
	) a 

	insert into AuditControl.dbo.PurchaseTransAudit(TransID,OrderID,AccountNumber,Supplier,City,DueDate,OrderDate,Lastupdate,LogDate)
Select  TransID,OrderID,AccountNumber,Supplier,City,DueDate,OrderDate,Lastupdate, getdate() from ##DuplicateOnly 

	delete from PurchaseTransDup where  TransID not in (select TransID from ##validPurchaseTrans)
END

select * from AuditControl.dbo.PurchaseTransAudit order by Logdate desc


select  * from  AuditControl.dbo.PurchaseTransAudit
