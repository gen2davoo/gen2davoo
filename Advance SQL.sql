 select  -1* cast(rand()*1000 as int )
                 0 - 999  +1    ====   1 to 1000


 select cast( 0.9999*1000 as int) +1


 select dateadd(day, -1* cast(rand()*1000 as int ) , getdate())
 
 select dateadd(day, cast(rand()*1000 as int ) , getdate())

  /*
  
  -Master  - is the heart of the sql database instance, it manages other databases, data files, logins, dictionary
  - Model - template database for user defined objects (table, view, store procedures, functions, users, schema)
  -msdb - > sql server agent configuration 
  - tempdb - varibles, temporary tables(local, global), variable tables, 
   */

  select * from INFORMATION_SCHEMA.TABLES
  select * from INFORMATION_SCHEMA.COLUMNS Where COLUMN_NAME='CountryID'

  select * from sys.database_files



  --- variables

  wallet - Note, coins, card, paper, id 
  declare @wallet int     --1 23 444 4

  solution - 1
  declare @solution char(10)      --owolabi

  bucket  -> Water, Note,Coins,card, paper
  declare @bucket varchar(1000)   - 22224 , owo --alphanumeric 

  declare @fullname nvarchar(1000) ='Temitope Babalola'
   ---select @fullname as full_name
   print(@fullname)

   select @fullname=@fullname + 'fumilade'

   print(@fullname)
  --select @fullname as full_name

  use [SQL Essentials]

  select count(*) from PurchaseTrans

  select * from PurchaseTrans

  select count(*) from CustomerShipment

  declare @countPurchase  int =26357
  
  declare @countPurchaseCanada float =(select count(*) from PurchaseTrans Where Country='Canada')
  print(@countPurchaseCanada)

  declare @countPurchase int =(select count(*) from PurchaseTrans )

  print(@countPurchase)

  declare @Ratio float 
  select @Ratio=@countPurchaseCanada/@countPurchase*100
  print(@Ratio)
  print(@countPurchase)

  ---- Table 

  --CTE
  --Variable Table
  -global temporary 
  - local temp
  - view
  - Physical table


  --- C T E -.common table expression  
  
  --- country, supplier, purchaseamount, customershipamount


  
 With transamount AS
  (

	select  Country,supplier,sum(orderQty*UnitPrice) as Amount,'Purchase' as TransType  from PurchaseTrans
	group by Country,Supplier 
		 union all

	select  Country,supplier,sum(orderQty*ListPrice) as Amount,  'Customer' as TransType  from CustomerShipment
	group by Country,Supplier
)

select * from transamount  where Country='France'


select * from transamount




--- CTE Statement----

 With transamount AS
  (

	select  Country,supplier,sum(orderQty*UnitPrice) as Amount,'Purchase' as TransType  from PurchaseTrans
	group by Country,Supplier 
		 union all

	select  Country,supplier,sum(orderQty*ListPrice) as Amount,  'Customer' as TransType  from CustomerShipment
	group by Country,Supplier
),

transCanada as
(

	select  Country,supplier,sum(orderQty*UnitPrice) as Amount,Employee  from PurchaseTrans
	where Country='Canada'
	group by Country,Supplier,Employee 	
)

select a.Country,a.TransType,a.Amount as TransAmount,c.Amount as CanadaAmount,c.employee  from transamount a 
inner join transCanada c  on a.Country=c.Country


select * from transamount  where Country='France'


select * from transamount

select * from transamount  where Country='France'


with CTE_Specialoffer
AS
(
	Select * from SpecialOffer Where SpecialOfferID=4
),

CTE_product 
AS 
(
 select  pd.ProductID,pd.ProductName,pd.ProductNumber, c.CategoryName  from Product pd
 inner join ProductCategory pc on pd.ProductID=pc.ProductID
 inner join Category c on pc.CategoryID=c.CategoryID
),

CTE_PurchaseTrans
AS
(
  select  OrderID,productID,Supplier, specialofferID,Address,City,StateProvince,Country,OrderQty   from  PurchaseTrans 

)

select t.OrderID,t.Supplier,pd.ProductName,pd.ProductNumber,pd.CategoryName,s.SpecialOffer,t.OrderQty  from CTE_PurchaseTrans t 
inner join  CTE_product pd  on pd.ProductID=t.ProductID
inner join CTE_Specialoffer s on s.SpecialOfferID=t.SpecialOfferID

select t.OrderID,t.Supplier,pd.ProductName,pd.ProductNumber,pd.CategoryName,s.SpecialOffer,t.OrderQty  from CTE_PurchaseTrans t 
inner join  CTE_product pd  on pd.ProductID=t.ProductID
inner join CTE_Specialoffer s on s.SpecialOfferID=t.SpecialOfferID

select * from CTE_Specialoffer


 ---Variable table

 select  Country,supplier,sum(orderQty*UnitPrice) as Amount,'Purchase' as TransType  from PurchaseTrans
	group by Country,Supplier 
		 union all

	select  Country,supplier,sum(orderQty*ListPrice) as Amount,  'Customer' as TransType  from CustomerShipment
	group by Country,Supplier
 

 declare @Ayodeji table
 (
  Country nvarchar(255),
  Supplier nvarchar(255),
  Amount float ,
  TransType nvarchar(50),
  KPI as case when amount <=1000000 then 'Low'  when amount>1000000 and amount<=5000000 then 'Medium' else ' High' end 
 )

 insert into  @Ayodeji(Country,Supplier,Amount, TransType)

 select  Rosie.Country,Rosie.Supplier,Rosie.Amount,Rosie.TransType
			from	( select  Country,supplier,sum(orderQty*UnitPrice) as Amount,'Purchase' as TransType  from PurchaseTrans
						group by Country,Supplier 
						union all
						Select  Country,supplier,sum(orderQty*ListPrice) as Amount,  'Customer' as TransType  from CustomerShipment
						group by Country,Supplier
				) Rosie


	select * from  @Ayodeji
	select * from @Ayodeji Where Country='France'

	----Local Temp     #


Create Table #Saheed
 (
  Country nvarchar(255),
  Supplier nvarchar(255),
  Amount float ,
  TransType nvarchar(50),
  KPI as case when amount <=1000000 then 'Low'  when amount>1000000 and amount<=5000000 then 'Medium' else ' High' end 
 )
 

 insert into  #Saheed(Country,Supplier,Amount, TransType)

 select  Rosie.Country,Rosie.Supplier,Rosie.Amount,Rosie.TransType
			from	( select  Country,supplier,sum(orderQty*UnitPrice) as Amount,'Purchase' as TransType  from PurchaseTrans
						group by Country,Supplier 
						union all
						Select  Country,supplier,sum(orderQty*ListPrice) as Amount,  'Customer' as TransType  from CustomerShipment
						group by Country,Supplier
				) Rosie


Select * from #Saheed 

Select * from #Saheed Where Amount>10000000

---global temp Table  ##

drop table ##Saheed

select * from ##Saheed

Create Table ##Saheed
 (
  Country nvarchar(255),
  Supplier nvarchar(255),
  Amount float ,
  TransType nvarchar(50),
  KPI as case when amount <=1000000 then 'Low'  when amount>1000000 and amount<=5000000 then 'Medium' else ' High' end,
  [Singleton] as case when amount <=1000000 then 1  when amount>1000000 and amount<=5000000 then 2 else 3 end
 )
 
 


 insert into  ##Saheed(Country,Supplier,Amount, TransType)

 select  Rosie.Country,Rosie.Supplier,Rosie.Amount,Rosie.TransType
			from	( select  Country,supplier,sum(orderQty*UnitPrice) as Amount,'Purchase' as TransType  from PurchaseTrans
						group by Country,Supplier 
						union all
						Select  Country,supplier,sum(orderQty*ListPrice) as Amount,  'Customer' as TransType  from CustomerShipment
						group by Country,Supplier
				) Rosie


				Select  OBJECT_ID('tempdb..##saheed1')
IF OBJECT_ID('tempdb..##saheed1')  is not null
  drop table ##saheed1


	select  Rosie.Country,Rosie.Supplier,Rosie.Amount,Rosie.TransType  into ##saheed1
			from	( select  Country,supplier,sum(orderQty*UnitPrice) as Amount,'Purchase' as TransType  from PurchaseTrans
						group by Country,Supplier 
						union all
						Select  Country,supplier,sum(orderQty*ListPrice) as Amount,  'Customer' as TransType  from CustomerShipment
						group by Country,Supplier
				) Rosie

select * from ##Saheed1

select  * from tempdb..dbo.#saheed

select *  from sys.objects


select * from [United Nation Census].dbo.tblPopulation

select * from ##Saheed

use tempdb
select *  from sys.objects


-----View



alter view  saheed_view 
as 
  select  Country,supplier,sum(orderQty*UnitPrice) as Amount,'Purchase' as TransType  from PurchaseTrans
						group by Country,Supplier 
						union all
						Select  Country,supplier,sum(orderQty*ListPrice) as Amount,  'Customer' as TransType  from CustomerShipment
						group by Country,Supplier


--- KPI as case when amount <=1000000 then 'Low'  when amount>1000000 and amount<=5000000 then 'Medium' else ' High' end,
----[Singleton] as case when amount <=1000000 then 1  when amount>1000000 and amount<=5000000 then 2 else 3 end

alter view  saheed_view 
as 

select  f.Country,f.supplier, f.Amount,f.TransType, 
    case when f.amount <=1000000 then 'Low'  when f.amount>1000000 and f.amount<=5000000 then 'Medium' else ' High' end as KPI,
	case when f.amount <=1000000 then 1  when f.amount>1000000 and f.amount<=5000000 then 2 else 3 end as [singleton]
         

		from (
			  		select  Country,supplier,sum(orderQty*UnitPrice) as Amount,'Purchase' as TransType  from PurchaseTrans
					group by Country,Supplier 
						union all
					Select  Country,supplier,sum(orderQty*ListPrice) as Amount,  'Customer' as TransType  from CustomerShipment
					group by Country,Supplier
			) f

					   

select * from saheed_view

---------  T-SQL 
  --IF,WHILE, BEGIN, END, BEGIN TRANS

 declare @Saheed nvarchar(10)='MAL4E'
 
 IF  @Saheed='Male'              ---   MAL4E=MALE 
   print('father')
 ELSE
   print('mother')


  declare @age int = 40
  declare @nofChild int = 5

  IF @age>=50 and  @nofChild<=5 
	print('Sa category')
  else 
  print('Saheed category')

  
  declare @iteration int = 100
  declare @count int=1
  While  @count <=@iteration       --- 3<=100  
  Begin 
	print(@count)    --  2
	select @count=@count+1   ----  @Count = 2+1      =3
  End
  print('end of iteration')

  

  declare @iteration int = 100
  declare @count int=1
  While  @count <=@iteration     
  Begin 
    IF @count<=50    ---  51<=50
		BEGIN
			select 'less than or equal 50' as description, @count as Counter
		END
	ELSE
		BEGIN
			select 'more than or equal 50' as description, @count as Counter
			
		END

	select @count=@count+2
  End
  

  
 IF OBJECT_ID('tempdb..##counterRecord') is null
  BEGIN 
	create table ##counterRecord
	(
		[description] nvarchar(255),
		counter int  
	);
	END
ELSE
  TRUNCATE Table ##counterRecord

  
  declare @iteration int = 100
  declare @count int=1   

  insert into ##counterRecord(description,counter) values('Fantun-Temmy',0)
  While  @count <=@iteration     
  Begin 
    IF @count<=50    ---  51<=50
		BEGIN
		    insert into ##counterRecord(description,counter)
			select 'less than or equal 50' as description, @count as Counter
		END
	ELSE
		BEGIN
			insert into ##counterRecord(description,counter)
			select 'more than or equal 50' as description, @count as Counter
			
		END

	select @count=@count+2
  End
  
  select * from ##counterRecord

  -----generate 1000 days
    declare @currentday int=0
	declare @maxday int=1000
	while @currentday<=@maxday
	BEGIN 
		
		IF  DATEPART(DW,GETDATE()+@currentday) not in (1,7)
		 BEGIN 
		    print( DATEADD(day,@currentday,GETDATE()))
			--print( GETDATE() +@currentDay)
			
		 END  
		select @currentday=@currentday+1
    END

   
   select DATEPART(DW,GETDATE())

   
  declare @iteration int = 100
  declare @count int=1
  While  @count <=@iteration       --- 2 <100
  Begin 
	print('counter :' +cast(@count as nvarchar))    --  1
  declare @age int =( select cast(rand()*100 as int))+1
  print(@age)
  declare @nofChild int = ( select cast(rand()*5 as int))+1
  print(@nofChild)
  IF @age>=50 and  @nofChild<=5 
	BEGIN
		print('Sa category')
		IF @age > 70 
		  print('Family planinig')
		Else
		   print('baby machine')
	END 

  ELSE
   BEGIN 
	print('Saheed category')
	print('machine man')
  END
  select @count=@count+1   ----1+1
  End



 --- Case study  -- Dynamic population of united nations census 2016,2017, 2018
 use [United Nation Census]
 select * from tblEthnics
 select * from tblStates
 select * from tblCountry
 select * from tblPopulation
 
 ---- Deduplication processing

 ----
 ---- Function-----

-- Scalar
-- Built in function
-- Table value function 


--- PeterAfeez 
alter function peterafeez(@peter int, @afeez int)
returns int
AS
BEGIN 
 return @peter+@Afeez
END


select dbo.peterafeez(120,8)

alter function getStatus()
returns nvarchar(10)
as 
BEGIN 
 declare @result int 
 declare @returnvalue nvarchar(10) 
 
   select @result=(select dbo.peterafeez(120,8))
   IF @result<=1000
     select @returnvalue= 'Boys'
   ELSE 
   select @returnvalue ='Men'
  
return @returnvalue
END



select dbo.getStatus()


--- Dynamic passing passing the parameters from the main function call

alter function getStatus(@peter int, @afeez int)
returns nvarchar(10)
as 
BEGIN 
 declare @result int 
 declare @returnvalue nvarchar(10) 
 
   select @result=(select dbo.peterafeez(@peter,@afeez))
   IF @result<=1000
     select @returnvalue= 'Boys'
   ELSE 
   select @returnvalue ='Men'
  
return @returnvalue
END

select dbo.getstatus(100,13)




--- test 
create function test()
returns int
AS
BEGIN 
	exec censusGenerator  1999, 2020, 50
	return 1
	 
END

select dbo.test()

Create function fnpopulation(@ethnic nvarchar(50))
Returns Table
AS
RETURN
(
	select c.Country, s.State, e.Ethnic, sum(p.Population) as TotalPopulation  from tblPopulation p
	inner join tblEthnics e  on p.EthicID=e.EthicID
	inner join  tblStates s on p.StateID=s.StateID
	inner join tblCountry c  on s.CountryID=c.CountryID
	Where Ethnic=@ethnic 
	group by  c.Country, s.State, e.Ethnic
)

select a.TotalPopulation,a.Country,* from fnpopulation('English') a

 create function topselector( @population int)
 Returns Table 
 AS
 Return 
 (
 	select c.Country, s.State, e.Ethnic, p.Population as TotalPopulation  from tblPopulation p
	inner join tblEthnics e  on p.EthicID=e.EthicID
	inner join  tblStates s on p.StateID=s.StateID
	inner join tblCountry c  on s.CountryID=c.CountryID
	Where p.Population>=@population
 )
 
 select * from topselector(5000)

 drop function test 

 alter function topValues()
 returns Table
 AS
 Return
 (
 
 	select top 100 c.Country, s.State, e.Ethnic, p.Population as TotalPopulation  from tblPopulation p
	inner join tblEthnics e  on p.EthicID=e.EthicID
	inner join  tblStates s on p.StateID=s.StateID
	inner join tblCountry c  on s.CountryID=c.CountryID
	order by Population desc
)

select * from topValues()

--- Analytical functions1
create function topPopulation(@topvalue int)
returns table 
AS
return 
(
  
  select  a.toprow,a.Country,a.State,a.Ethnic,a.TotalPopulation 
		from (
 			  SELECT ROW_NUMBER() over(order by population desc) toprow,  c.Country, s.State, e.Ethnic, p.Population as TotalPopulation 
			  FROM tblPopulation p
			  inner join tblEthnics e  on p.EthicID=e.EthicID
			  inner join  tblStates s on p.StateID=s.StateID
			  inner join tblCountry c  on s.CountryID=c.CountryID				
		 ) a  Where a.toprow<=@topvalue
)
select * from topPopulation(245)

use [SQL Essentials]

select  ROW_NUMBER() OVER(partition by orderid order by OrderID asc )  rowid, orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount from PurchaseTrans


select  ROW_NUMBER() OVER(order by OrderID asc )  rowid, 
   ROW_NUMBER() OVER(partition by orderid order by OrderID asc )  partitionID, 
orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount from PurchaseTrans

select 
   ROW_NUMBER() OVER(partition by orderid order by OrderQty*UnitPrice desc )  rowId, 
orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount from PurchaseTrans

select 
   RANK() OVER(partition by orderid order by OrderQty*UnitPrice desc )  rankID, 
orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount from PurchaseTrans

select 
   DENSE_RANK() OVER(partition by orderid order by OrderQty*UnitPrice desc )  denserankD, 
orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount from PurchaseTrans

select 
   ROW_NUMBER() OVER(order by OrderQty*UnitPrice desc )  rowId, 
   RANK() OVER(partition by orderid order by OrderQty*UnitPrice desc )  rankID, 
   DENSE_RANK() OVER(partition by orderid order by OrderQty*UnitPrice desc )  denserankD, 
orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount  from PurchaseTrans

select * from #purchaseRank order by rowId asc


use [SQL Essentials]

select 
   Ntile(5) OVER(order by OrderQty*UnitPrice desc )  bucketing,
orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount from PurchaseTrans


select 
   Ntile(5) OVER(partition by city order by OrderQty*UnitPrice desc )  bucketing,
orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount from PurchaseTrans



select  
   First_Value(orderid) OVER(partition by city order by OrderQty*UnitPrice desc )  first_Order,
 orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount from PurchaseTrans

 
 
select OrderID, City, Employee, PurchaseAmount, inital_PurchaseAmount, PurchaseAmount-inital_PurchaseAmount as BaseValuediff   from  (
select  
   First_Value(OrderQty*UnitPrice) OVER(partition by city order by OrderQty*UnitPrice desc )  inital_PurchaseAmount,
 orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount from PurchaseTrans
 ) a



 select OrderID, City, Employee, PurchaseAmount, Avg_PurchaseAmount, PurchaseAmount-Avg_PurchaseAmount as BaseValuediff 
 from  (
			select  orderID,City, Employee,   
			AVG(OrderQty*UnitPrice)  Avg_PurchaseAmount, Sum(OrderQty*UnitPrice) as PurchaseAmount from PurchaseTrans
			group by orderID,City, Employee
 ) a 

  
select  
  orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount,
   cume_dist() OVER(partition by city order by OrderQty*UnitPrice desc )  distribution_PurchaseAmount,   
 from PurchaseTrans
 

 
   
select  
  orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount,
   cume_dist() OVER( order by OrderQty*UnitPrice desc )  distribution_PurchaseAmount 
 from PurchaseTrans



 
 
select OrderID, City, Employee, PurchaseAmount, inital_PurchaseAmount, PurchaseAmount-inital_PurchaseAmount as BaseValuediff   from  (
select  
   LASt_Value(OrderQty*UnitPrice) OVER(partition by city order by OrderQty*UnitPrice desc )  inital_PurchaseAmount,
 orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount from PurchaseTrans
 ) a



 
select OrderID, City, Employee, PurchaseAmount, inital_PurchaseAmount, PurchaseAmount-inital_PurchaseAmount as BaseValuediff   from  (
select  
   LASt_Value(OrderQty*UnitPrice) OVER(partition by city order by OrderQty*UnitPrice desc )  inital_PurchaseAmount,
 orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount from PurchaseTrans
 ) a



 select  
  orderID,City, Employee, OrderQty*UnitPrice as PurchaseAmount,
   percent_rank() OVER(partition by city order by OrderQty*UnitPrice desc )  percentageRank   
 from PurchaseTrans
 

 select  soga.PurchaseLineNo, soga.Rank_PurchaseAmount, soga.OrderDate,soga.City, 
 format(soga.CurrentPurchaseAmount,'C') CurrentPurchaseAmount,
 format(isnull(soga.PreviousPurchaseAsmount,0),'C') PreviousPurchaseAsmount, 
 format(isnull(soga.NextPurchaseAsmount,0),'C') NextPurchaseAsmount, 
 
 format(isnull(soga.PreviousPurchaseAsmount-soga.CurrentPurchaseAmount,0),'C') MarginalPreviousPurchaseAmount,
 format(isnull(soga.NextPurchaseAsmount-soga.CurrentPurchaseAmount,0),'C') MarginalNextPurchaseAmount
 from 
 (
	select  
	p.OrderDate, City,
	row_number()over(order by Orderdate) PurchaseLineNo,
	dense_rank()over(order by sum(OrderQty*UnitPrice)) Rank_PurchaseAmount,
	LAG(sum(OrderQty*UnitPrice),1) over(order by Orderdate) PreviousPurchaseAsmount,
	LEAD(sum(OrderQty*UnitPrice),1) over(order by Orderdate) NextPurchaseAsmount,
	sum(OrderQty*UnitPrice) as CurrentPurchaseAmount  
	from PurchaseTrans p
	group by OrderDate, City 
) soga 




 select  soga.OrderDate,soga.City, format(isnull(soga.PreviousPurchaseAsmount,0),'C') PreviousPurchaseAsmount, 
 format(soga.CurrentPurchaseAmount,'C') CurrentPurchaseAmount,
 format(isnull(soga.PreviousPurchaseAsmount-soga.CurrentPurchaseAmount,0),'C') MarginalPurchaseAmount  from 
 (
	select  
	p.OrderDate, City, LAG(sum(OrderQty*UnitPrice),1) over(order by Orderdate) PreviousPurchaseAsmount,
	sum(OrderQty*UnitPrice) as CurrentPurchaseAmount  
	from PurchaseTrans p
	group by OrderDate, City 
) soga 


select  
	p.OrderDate, City, 
	sum(OrderQty*UnitPrice) as CurrentPurchaseAmount ,
	LEAD(sum(OrderQty*UnitPrice),1) over(order by Orderdate) NextPurchaseAmount
	from PurchaseTrans p
	group by OrderDate, City 
  
  yo -> y1              y1 -> y0



create table test
(
   id int identity (1,1),
   fname  nvarchar(1)
)


insert into test(fname)
values
('J'),
('P'),
('A'),
('P'),
('J'),
('P'),
('A'),
('P'),
('P'),
('J'),
('P')

select * from test Where fname='P'
drop table #ptemp

select * from #ptemp



declare @newid int
declare @pid int
begin
   if OBJECT_ID('tempdb..#ptemp') is not null
      drop table #ptemp
	select ROW_NUMBER() over (order by id) new_id,  id, fname into #ptemp from test Where fname='P'
	select @newid=( select cast(rand()*(select max(new_id) from #ptemp) as int)+1)
	select  @pid=( select id from #ptemp where new_id=@newid)
	select @pid
end



---Deduplication  processing 


---ABN Amro  gratis
use [SQL Essentials]
select TransID,OrderID,AccountNumber,Supplier, City,DueDate,OrderDate, getdate() as Lastupdate into PurchaseTransDup from PurchaseTrans 

select * from  PurchaseTransDup

select OrderID,count(*) no_of_dup from PurchaseTransDup
group by orderId


-- -Create table PurchaseTransAudit in auditcontrol database without data
 select TransID,OrderID,AccountNumber,Supplier,City,DueDate,OrderDate,Lastupdate into AuditControl.dbo.PurchaseTransAudit from PurchaseTransDup
 Where 1=2

 drop table PurchaseTransDup
--- 1 method to add  lastupdate

select TransID,OrderID,AccountNumber,Supplier, City,DueDate,OrderDate, getdate() as Lastupdate into PurchaseTransDup from PurchaseTrans 

select * from  PurchaseTransDup

--- 2 method to add  lastupdate
select TransID,OrderID,AccountNumber,Supplier, City,DueDate,OrderDate into PurchaseTransDup from PurchaseTrans 
alter table purchaseTransDup add lastupdate datetime default getdate()

Update purchaseTransDup  set lastupdate=getdate()

select * from PurchaseTransDup

alter table purchaseTransDup drop column lastupdate

-- To rename table
exec  sp_rename  'PurchaseOrder', 'purchaseTransDup'

----The last entry is the right order to be retained
select OrderId, count(*) no_of_occurances from ##purchaseTransDup 
					group by OrderID
				 	having Count(*)>1

-

---- Make copy of the original
IF OBJECT_ID('tempdb..##purchaseTransDup') is not null 
   drop table ##purchaseTransDup

select p.TransID,p.OrderID,p.AccountNumber,p.Supplier,p.City,p.DueDate,p.OrderDate,p.Lastupdate into ##purchaseTransDup
from  PurchaseTransDup p 

---- Make copy of only duplicate transaction only
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

---Valid PurchaseTrans
select   a.TransID,a.OrderID, a.AccountNumber,a.Supplier,a.City,a.DueDate,a.OrderDate,a.LastUpdate into ##validPurchaseTrans from  
(
    --  deduplicate table now ##deduplicate
	Select  TransID ,OrderID,AccountNumber,Supplier,City,DueDate,OrderDate, GETDATE() as LastUpdate from ##deduplicate 
	union all
		--- Order with single Entry
		Select p.TransID,p.OrderID,p.AccountNumber,p.Supplier,p.City,p.DueDate,p.OrderDate,p.Lastupdate  from  ##purchaseTransDup p
		Where p.OrderID in (
					select OrderId from ##purchaseTransDup 
					group by OrderID
				 	having Count(*)=1
					)
) a 


---insert duplication trans into audit database   				
insert into AuditControl.dbo.PurchaseTransAudit(TransID,OrderID,AccountNumber,Supplier,City,DueDate,OrderDate,Lastupdate,LogDate)
Select  TransID,OrderID,AccountNumber,Supplier,City,DueDate,OrderDate,Lastupdate, getdate() from ##DuplicateOnly 

delete from PurchaseTransDup where  TransID not in (select TransID from ##validPurchaseTrans)

Select *  from PurchaseTransDup Where OrderID=49894

insert into PurchaseTransDup(TransID,OrderID,AccountNumber,Supplier,City,DueDate,OrderDate,Lastupdate)
Select 30371,OrderID,AccountNumber,Supplier,City,DueDate,OrderDate,getdate() as Lastupdate  from PurchaseTransDup
Where OrderID=49894


insert into PurchaseTransDup(TransID,OrderID,AccountNumber,Supplier,City,DueDate,OrderDate,Lastupdate)
Select 26372,OrderID,AccountNumber,Supplier,City,DueDate,OrderDate,getdate() as Lastupdate  from PurchaseTransDup
Where OrderID=51769

Select OrderID, Count(*)  from PurchaseTransDup
group by OrderID
having count(*)>1

Select * from PurchaseTransDup  Where OrderID=51769


select  max(TransID)  from PurchaseTransDup 




Select * from PurchaseTransDup 
select * from AuditControl.dbo.PurchaseTransAudit order by LogDAte desc







