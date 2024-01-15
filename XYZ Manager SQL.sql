2. Want to know the anomalous vendors  include total quantity and total amount ( quantity*Unit

select VendorID,sum(Quantity) as TotalQuantity, Sum(Qunatity*UnitPrice) as TotalAmount
from salesTransaction 
Where VendorID not in (select vendorId from Vendor)
Group by VendorID

select VendorID,sum(Quantity) as TotalQuantity, Sum(Qunatity*UnitPrice) as TotalAmount
from salesTransaction s
Where not exist (select 1 from Vendor  v where v.vendorid=s.vendorid)
Group by VendorID

3. To retrieve all the sales transaction includes the anomalous vendors  and valid vendors

select  s.vendorid, s.quantity,s.uniprice, v.firstname, v.lastname  
from Salestransaction s  left join vendor v 
on s.vendorid=v.vendorid



select  s.vendorid, s.quantity,s.uniprice, CONCAT_WS(',',v.firstname, v.lastname) as fullname
from Salestransaction s 
left join vendor v  on s.vendorid=v.vendorid


-- Wrong 
select  s.vendorid, quantity,s.uniprice, CONCAT_WS(',',v.firstname, v.lastname) as fullname
from Salestransaction s 
Where  s.vendorId in (select v.vendorId from Vendor v)

---right
select  s.vendorid, quantity,s.uniprice, CONCAT_WS(',',v.firstname, v.lastname) as fullname
from Salestransaction s  inner join vendor v  on s.vendorid=v.vendorid



select  s.vendorid, s.quantity,s.uniprice, CONCAT(v.firstname,' ', v.lastname) as fullname
from Salestransaction s 
left join vendor v  on s.vendorid=v.vendorid

select  s.vendorid, s.quantity,s.uniprice, v.firstname +','+ v.lastname as fullname
from Salestransaction s 
left join vendor v  on s.vendorid=v.vendorid


4. To retrieve valid sales transaction by Year, by Month with vendor full name


select  s.saleID, s.quantity,s.uniprice, CONCAT_WS(',',v.firstname, v.lastname) as fullname, Year(TransDate) as TransYear,
Month(Trandate) as TransMonth
from Salestransaction s  inner join vendor v 
on s.vendorid=v.vendorid

select  s.saleID, s.quantity,s.uniprice, CONCAT_WS(',',v.firstname, v.lastname) as fullname, DatePart(Year,TransDate) as TransYear,
DatePart(Month,Trandate) as TransMonth
from Salestransaction s  inner join vendor v 
on s.vendorid=v.vendorid



select  s.saleID, s.quantity,s.uniprice, CONCAT_WS(',',v.firstname, v.lastname) as fullname, DatePart(Year,TransDate) as TransYear,
DateName(Month,Trandate) as TransMonth
from Salestransaction s  inner join vendor v 
on s.vendorid=v.vendorid


5. Want to know the total anomalous sales transactions with  quantity and total amount  by Year by month

select VendorID, Year(TransDate) TransYear, DateName(MONTH,TransDate) TransMonth,
sum(Quantity) as TotalQuantity, Sum(Qunatity*UnitPrice) as TotalAmount
from salesTransaction 
Where VendorID not in (select vendorId from Vendor)
Group by VendorID,Year(TransDate),DateName(MONTH,TransDate)
order by TransYear




select DatePart(Month,GETDATE())

select DatePart(YEAR,GETDATE())

select DateName(YEAR,GETDATE())

select DateName(Month,GETDATE())


salestransaction     vendor 























