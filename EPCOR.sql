use TescaOltp

create database TescaOLTP --restore backup 

create database TescaStaging

create database TescaEDW


select * from PurchaseTransaction

select * from SalesTransaction

Create DATABASE EPCOR

use EPCOR

-- Q1:	What is the name of Customer with ID "CUST0002"?
select Customer_ID, Full_Name as CustomerName 
from Customer_Details 
where customer_id LIKE 'CUST0002' AND Latest_Record like 'Y'


-- Q2:	What is the Average Turbidity for each facility in the first 6 months of 2023?

select AVG(Turbidity_Level) as AVG_Turbidity from Quality 
where date between '01-01-2023' and '06-30-2023'


-- Q3:	Which Facility recorded the highest Chlorine level in the month of April?

select Facility_Name 
from Facility where Facility_ID in (
select Facility_ID from Quality
where Chlorine_Lvl = (select max(chlorine_lvl) from Quality where date between '04-01-2023' and '04-30-2023'))

-- Q4:	Which month recorded the highest water consumption?

select DATENAME(Month, Date) AS Month from Consumption 
where Consumption_l = (select max(Consumption_l) from Consumption)

-- Q5:	Which Customer Type consumes the least amount of water?
select CustomerType + ' -- ' + Description as CustomerType 
from CustomerType 
where CustomerType in (
						select Customer_Type from Consumption 
						where Consumption_l = (select min(Consumption_l) from Consumption)
						)

-- Q6:	How much water does "Big Bear Treatment Plant" supply to "City of Edmonton"; broken down by each month?

select datename(month, date) as Month, sum(consumption_l) as Supply_to_CoE from Consumption 
where Fac_ID in (select Facility_ID from Facility where Facility_Name LIKE 'Big Bear Treatment Plant' and Latest_Record like 'Y')
group by datename(month, date)


-- Q7:	Which Facility recorded consumption 95% of its maximum capacity and for how many consecutive months?

select c.date,
       c.Fac_ID 
from consumption c
where 	   (c.Consumption_l*100/
	   (select f.Maxium_Capacity from facility f 
	    where f.Latest_Record like 'Y' 
		and f.Facility_ID in (
		                       Select c.Fac_ID from Consumption))) >= 95


-- Q8:	How much water does "Neighbourhood 1" receives from "Jane Doe Treatment Plant" in March 2023?

select Consumption_l as VolOfWater_Rcvd from Consumption 
where Prop_ID in (select Property_ID from property where Neighbourhood like 'Neighbourhood 1' and Datepart(month, date) = 3)

-- Q9:	Rank the Customers based on their total Water Consumption

select cd.Full_Name, sum(c.consumption_l) as TotalWaterConsumption  
from Consumption c
inner join Customer_Details cd on cd.customer_id = c.Cust_ID
group by cd.Full_Name




/*   CHECK
select c.date,
       c.Fac_ID, 
	   (c.Consumption_l*100/
	   (select f.Maxium_Capacity from facility f 
	    where f.Latest_Record like 'Y' 
		and f.Facility_ID in (
		                       Select c.Fac_ID from Consumption)))
		as '%Consumption'
from consumption c
order by '%Consumption' desc
*/
*/