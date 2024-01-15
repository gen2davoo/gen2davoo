 --- Case study  -- Dynamic population of united nations census 2016,2017, 2018, 2019,2020 
 ---    each dataset for each year = 100*Year 
 ---201,600

 use [United Nation Census]
 select * from tblCountry
 select * from tblEthnics
 select * from tblStates 
 select * from tblPopulation

 truncate table tblPopulation

 alter table tblPopulation add CensusYear int

 select cast(rand()*5 as int)+1
 select max(stateid) from tblStates

  select cast(rand()*(select max(stateid) from tblStates) as int)+1    ---states


  select cast(rand()*6 as int)
  select max(ethicid) from tblEthnics

  select cast(rand()*(select max(ethicid) from tblEthnics) as int)+1
  
  /* 
  1. select year
  2. forthe select year multiply the year by 100
  3. loop for the  year multiply the year by 100
  4. write to the population table
  5.  increament the loop record
  6.increment the selected year+1
  */
  
  
  declare @currentyear int=2016  -- intialized current
  declare @maxyear int=2020   ----Maximum Year
  declare @totalRecord int
  declare @currentRecord int=1
  declare @ethnicid int
  declare @statetid int
  declare @population int
 WHILE  @currentyear<=@maxyear   --if currentyear <= max year
 BEGIN 
  --print(@currentYear)
  select @totalRecord=@currentYear*100   --- 2016*100 =201600
  select @currentRecord=1
  WHILE @currentRecord<=@totalRecord
   BEGIN 
    --print(@currentRecord)
	select @statetid =cast(rand()*(select max(stateid) from tblStates) as int)+1 
	select @ethnicid= cast(rand()*(select max(ethicid) from tblEthnics) as int)+1
	select @population= cast(Rand()*5000 as int)+1000

	insert into tblPopulation(StateID,EthicID,Population,CensusYear) select @statetid,@ethnicid,@population,@currentyear
	select @currentRecord=@currentRecord+1
   END   
   select @currentyear=@currentyear+1
 END
 
 select c.Country, s.State, e.Ethnic, sum(p.Population) as TotalPopulation  from tblPopulation p
 inner join tblEthnics e  on p.EthicID=e.EthicID
 inner join  tblStates s on p.StateID=s.StateID
 inner join tblCountry c  on s.CountryID=c.CountryID
 group by  c.Country, s.State, e.Ethnic

 

 iterate through populationyear 
      iterate through record per year
	    insert into population table


---- convert to Store Procedure

drop procedure censusGenerator

exec censusGenerator  1999, 2020, 1000

aLTER PROCEDURE censusGenerator(@CurrentYear int, @MaxYear int, @multplier int)
AS
 BEGIN
  SET NOCOUNT ON
  --declare @currentyear int=2016  -- intialized current
  --declare @maxyear int=2020   ----Maximum Year
  declare @totalRecord int
  declare @currentRecord int=1
  declare @ethnicid int
  declare @statetid int
  declare @population int
    IF (select count(*) from tblPopulation)>0
	   TRUNCATE TABLE tblPopulation;

 WHILE  @currentyear<=@maxyear   --if currentyear <= max year
 BEGIN 
  --print(@currentYear)
  select @totalRecord=@currentYear*@multplier   --- 2016*100 =201600
  select @currentRecord=1
  WHILE @currentRecord<=@totalRecord
   BEGIN 
    --print(@currentRecord)
	select @statetid =cast(rand()*(select max(stateid) from tblStates) as int)+1
	select @ethnicid= cast(rand()*(select max(ethicid) from tblEthnics) as int)+1
	select @population= cast(Rand()*5000 as int)+1000

	insert into tblPopulation(StateID,EthicID,Population,CensusYear) select @statetid,@ethnicid,@population,@currentyear
	select @currentRecord=@currentRecord+1
   END   
   select @currentyear=@currentyear+1
 END
END

exec censusGenerator  2021, 2021, 10

select Count(*) from tblPopulation

select * from tblPopulation

select CensusYear, count(*) as  Recount from tblPopulation
group by CensusYear

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


