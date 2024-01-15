

--Enviroment   - Staging , EDW
--- PackageType --- Dimension, Fact
--- FrequecyofRun  ---- daily, week, eodmonth, Year

create schema control

create table control.environment
(
  environmentid int, 
  environment  nvarchar(50)
  constraint  control_environment_pk  primary key(environmentid)
)

insert into control.environment(environmentid, environment)
values
(1, 'Staging'),
(2, 'EDW')


create table control.PackageType
(
  PackageTypeID int, 
  PackageType nvarchar(50)
  constraint  control_PackageType_pk  primary key(PackageTypeID)
)

insert into control.PackageType(PackageTypeID,PackageType)
values
(1, 'Dimension'),
(2, 'Fact')


create table control.Frequency
(
  FrequencyID int, 
  Frequency nvarchar(50)
  constraint  control_Frequency_pk  primary key(FrequencyID)
)

insert into control.Frequency(FrequencyID,Frequency)
values
(1, 'daily'),
(2, 'End of the week'),
(3, 'End of the Month'),
(4, 'End of the Year'),
(5, 'Hourly')

/*
stgstore 100
stgproduct 200
stgproduct 120



*/


---drop table control.package
create table control.package
(
 packageID int,
 PackageName  nvarchar(50), ---- stgstore.dtsx
 SequenceNo int,
 environmentid int,  --edw, staging
 PackageTypeID int, --- dim or fact
 FrequencyID int,
 RunStartDate  date,
 RunEndDate  date,
 Active bit, --- 0 to pulse or 1 active
 lastRundate datetime, 
 constraint control_package_pk primary key(packageID),
 constraint control_package_environmentid_fk foreign key(environmentid) references control.environment(environmentid),
 constraint control_package_PackageTypeID_fk foreign key(PackageTypeID) references control.PackageType(PackageTypeID),
 constraint control_package_FrequencyID_fk foreign key(FrequencyID) references control.Frequency(FrequencyID)
 )
 


 --- Oltp to staging   =>   stgSourceCount = stgdesCount

 ----  dimension data  staging to edw    => 
---		PostCount (Total data in EDW after load operation) = PreCount(Initial data in EDW)+CurrentCount (current data) +Type2Count (data undergo type)

 ---  Fact  data    staging to edw   =>    PostCount = PreCount+CurrentCount

--- drop table   control.Metric
 create table control.Metric
(
	metricID int identity(1,1),
	packageID int,   -- store
	StgSourceCount int,   ---- from Oltp
	StgDescCount int, --- to staging 
	Precount int,   ---Initial data in EDW
	CurrentCount int,  ---current data
	Type1Count int,
	Type2Count int,
	PostCount int,  ---Total data in EDW after load operation
	Rundate datetime,	
	constraint control_metric_pk primary key(metricID),
	constraint control_metric_PackageID_fk foreign key(PackageID) references control.Package(PackageID),
)


declare @PackageID int =?        
declare @stgSourceCount int=?    
declare @stgDescCount int=?      
insert into control.Metric(packageID,StgSourceCount,StgDescCount,Rundate)
values(@PackageID,@stgSourceCount,@stgDescCount,GETDATE())

update control.package 
set lastRundate=getdate() where packageID=@PackageID

select * from control.package
select * from control.Metric
 
 insert into control.package(packageID, PackageName,SequenceNo,environmentid,PackageTypeID,FrequencyID,RunStartDate,Active)
 values
 (15,'stgAbsenceAnalysis.dtsx',1500,1,2,1,convert(date,GETDATE()),1),
 (14,'stgMisconductAnalysis.dtsx',1400,1,2,1,convert(date,GETDATE()),1),
 (13,'stgOvertimeAnalysis.dtsx',1300,1,2,1,convert(date,GETDATE()),1),
 (12,'stgPurchaseAnalysis.dtsx',1200,1,2,1,convert(date,GETDATE()),1),
 (11,'stgSalesAnalysis.dtsx',1100,1,2,1,convert(date,GETDATE()),1),
 (10,'stgAbsence.dtsx',1000,1,1,1,convert(date,GETDATE()),1),
 (9,'stgDecision.dtsx',900,1,1,1,convert(date,GETDATE()),1),
 (8,'stgMisConduct.dtsx',800,1,1,1,convert(date,GETDATE()),1),
 (7,'stgEmployee.dtsx',700,1,1,1,convert(date,GETDATE()),1),
 (6,'stgVendor.dtsx',600,1,1,1,convert(date,GETDATE()),1),
 (5,'stgPosChannel.dtsx',500,1,1,1,convert(date,GETDATE()),1),
 (4,'stgCustomer.dtsx',400,1,1,1,convert(date,GETDATE()),1), 
 (3,'stgPromotion.dtsx',300,1,1,1,convert(date,GETDATE()),1),
 (2,'stgProduct.dtsx',200,1,1,1,convert(date,GETDATE()),1),
 (1,'stgStore.dtsx',100,1,1,1,convert(date,GETDATE()),1)

/*
(1, 'daily'),
(2, 'End of the week'),
(3, 'End of the Month'),
(4, 'End of the Year'),
(5, 'Hourly')
*/
select * from control.package

select  a.PackageID,a.PackageName from
(
select  p.PackageID,p.PackageName,p.SequenceNo  from control.package p 
Where (p.Active=1 and p.RunStartDate<=convert(date,getdate())) and (RunEndDate is null or RunEndDate>=CONVERT(date,getdate()))
and  environmentid=1 and FrequencyID=1
union all 
select  p.packageID,p.PackageName,p.SequenceNo  from control.package p 
Where (p.Active=1 and p.RunStartDate<=convert(date,getdate())) and (RunEndDate is null or RunEndDate>=CONVERT(date,getdate()))
and  environmentid=1 and FrequencyID=2 and DATEPART(weekday, dateadd(day,-1,convert(date, getdate())))=7
union all 
select  p.packageID,p.PackageName,p.SequenceNo  from control.package p 
Where (p.Active=1 and p.RunStartDate<=convert(date,getdate())) and (RunEndDate is null or RunEndDate>=CONVERT(date,getdate()))
and  environmentid=1 and FrequencyID=3 and dateadd(day,-1,getdate())=EOMONTH(dateadd(day,-1,getdate())) 
union all 
select  p.packageID,p.PackageName,p.SequenceNo  from control.package p 
Where (p.Active=1 and p.RunStartDate<=convert(date,getdate())) and (RunEndDate is null or RunEndDate>=CONVERT(date,getdate()))
and environmentid=1 and FrequencyID=4 and dateadd(day,-1,getdate())=EOMONTH(dateadd(day,-1,getdate())) and  Month(dateadd(day,-1,getdate()))=12
union all
select  p.packageID,p.PackageName,p.SequenceNo  from control.package p 
Where (p.Active=1 and p.RunStartDate<=convert(date,getdate())) and (RunEndDate is null or RunEndDate>=CONVERT(date,getdate()))
and  environmentid=1 and FrequencyID=5 and ((DATEPART(hour,  dateadd(day,-1,getdate()))*60+datepart(minute, dateadd(day,-1,getdate())))%60)=0
)	a  order by a.SequenceNo asc


select (DATEPART(hour,  dateadd(day,-1,getdate()))*60+datepart(minute, dateadd(day,-1,getdate())))%60





31 dec 2023
jan 1 2024 

0*60       1*60   2*60  3*60  4*60  5*60, 6 7 ........23*60

(0*60)+30=30

0:30      0:45       1:34   = (1*60)+34          5:43=> (5*60)+43= 343 mins=> 343/60

/,

% 
 5*60
select  convert(float,343)/convert(float,60) as div, 343% 60 as modu, 300%60 as mod2

select getdate(),DATEPART(hour, getdate())*60+datepart(minute,getdate()) , (DATEPART(hour, getdate())*60+datepart(minute,getdate()))%60

select * from control.Metric  order by Rundate desc


--- Registering Stg pipe to EDW
 
 insert into control.package(packageID, PackageName,SequenceNo,environmentid,PackageTypeID,FrequencyID,RunStartDate,Active)
values
(25,'dimAbsence.dtsx',2900,2,1,1,convert(date,GETDATE()),1),
(24,'dimDecision.dtsx',2800,2,1,1,convert(date,GETDATE()),1),
(23,'dimMisConduct.dtsx',2700,2,1,1,convert(date,GETDATE()),1),
(22,'dimEmployee.dtsx',2600,2,1,1,convert(date,GETDATE()),1),
(21,'dimVendor.dtsx',2500,2,1,1,convert(date,GETDATE()),1),
(20,'dimPosChannel.dtsx',2400,2,1,1,convert(date,GETDATE()),1),
(19,'dimCustomer.dtsx',2300,2,1,1,convert(date,GETDATE()),1),
(18,'dimPromotion.dtsx',2200,2,1,1,convert(date,GETDATE()),1),
(17,'dimProduct.dtsx',2100,2,1,1,convert(date,GETDATE()),1),
(16,'dimStore.dtsx',2000,2,1,1,convert(date,GETDATE()),1)


declare @PackageID int =?        
declare @PreCount int=?    
declare @CurrentCount int=?    
declare @Type1Count int=?    
declare @Type2Count int=?    
declare @PostCount int=?    

insert into control.Metric(packageID,Precount,CurrentCount,Type1Count,Type2Count,PostCount,Rundate)
values(@PackageID,@Precount,@CurrentCount,@Type1Count,@Type2Count,@PostCount, GETDATE())

update control.package 
set lastRundate=getdate() where packageID=@PackageID




--- Fact control  Loading script

 Create table control.Anomalies
 ( 
  AnomalieSsk int identity(1,1),
  PackageID int,    ---- Overtime  30
  AttributeName nvarchar(50),  --- employee
  AttributeData nvarchar(50),  --   EMP000034
  LoadDate datetime,
  constraint control_anomaliesSk primary key(AnomaliesSk),
  constraint control_anomalies_packagefk foreign key (PackageID) references control.package(PackageID) 
 )

 select * from control.Metric
 select * from control.package

declare @PackageID int =?        
declare @PreCount int=?    
declare @CurrentCount int=?    
declare @PostCount int=?    

insert into control.Metric(packageID,Precount,CurrentCount,PostCount,Rundate)
values(@PackageID,@Precount,@CurrentCount,@PostCount, GETDATE())

update control.package 
set lastRundate=getdate() where packageID=@PackageID
 


 insert into control.package(packageID, PackageName,SequenceNo,environmentid,PackageTypeID,FrequencyID,RunStartDate,Active)
values
(30,'factMisConductAnalysis.dtsx',3500,2,2,1,convert(date,GETDATE()),1),
(29,'factAbsenceAnalysis.dtsx',3400,2,2,1,convert(date,GETDATE()),1),
(28,'factOvertimeAnalysis.dtsx',3300,2,2,1,convert(date,GETDATE()),1),
(27,'factPurchaseAnalysis.dtsx',3200,2,2,1,convert(date,GETDATE()),1),
(26,'factSalesAnalysis.dtsx',3100,2,2,1,convert(date,GETDATE()),1)




select * from control.Metric Where PackageID=30


select * from control.Anomalies

---EdW Control Process... 
 
create procedure control.spRunpipeline(@environment int)
AS
BEGIN
Set nocount on
select  a.PackageID,a.PackageName from
(
select  p.PackageID,p.PackageName,p.SequenceNo  from control.package p 
Where (p.Active=1 and p.RunStartDate<=convert(date,getdate())) and (RunEndDate is null or RunEndDate>=CONVERT(date,getdate()))
and  environmentid=@environment and FrequencyID=1
union all 
select  p.packageID,p.PackageName,p.SequenceNo  from control.package p 
Where (p.Active=1 and p.RunStartDate<=convert(date,getdate())) and (RunEndDate is null or RunEndDate>=CONVERT(date,getdate()))
and  environmentid=@environment and FrequencyID=2 and DATEPART(weekday, dateadd(day,-1,convert(date, getdate())))=7
union all 
select  p.packageID,p.PackageName,p.SequenceNo  from control.package p 
Where (p.Active=1 and p.RunStartDate<=convert(date,getdate())) and (RunEndDate is null or RunEndDate>=CONVERT(date,getdate()))
and  environmentid=@environment and FrequencyID=3 and dateadd(day,-1,getdate())=EOMONTH(dateadd(day,-1,getdate())) 
union all 
select  p.packageID,p.PackageName,p.SequenceNo  from control.package p 
Where (p.Active=1 and p.RunStartDate<=convert(date,getdate())) and (RunEndDate is null or RunEndDate>=CONVERT(date,getdate()))
and environmentid=@environment and FrequencyID=4 and dateadd(day,-1,getdate())=EOMONTH(dateadd(day,-1,getdate())) and  Month(dateadd(day,-1,getdate()))=12
union all
select  p.packageID,p.PackageName,p.SequenceNo  from control.package p 
Where (p.Active=1 and p.RunStartDate<=convert(date,getdate())) and (RunEndDate is null or RunEndDate>=CONVERT(date,getdate()))
and  environmentid=@environment and FrequencyID=5 and ((DATEPART(hour,  dateadd(day,-1,getdate()))*60+datepart(minute, dateadd(day,-1,getdate())))%60)=0
)	a  order by a.SequenceNo asc

END


execute control.spRunpipeline 2

execute control.spRunpipeline ?


--truncate  
truncate table control.Metric

select * from control.Metric order by Rundate desc

at  sunday 1: 000  -- n-1