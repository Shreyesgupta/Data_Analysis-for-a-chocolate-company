/*Shipment amount graeter than 2000 & boxes less than 100*/ 

SELECT Amount, Boxes
from sales 
WHERE amount > 2000 and boxes < 100;

SELECT * from sales
order by SaleDate;
select * from products;
select * from people;

/* Shipments (sales) each of the sales persons had in the month of January 2022 */

SELECT p.Salesperson,count(*)
from sales s
JOIN people p on p.SPID = s.SPID 
WHERE month(s.SaleDate) = 01 and year(s.Saledate)= 2022
group by p.Salesperson;


/* Product sold more boxes in the first 7 days of February 2022- Milk Bars or Eclairs */

select pr.Product, sum(Boxes*Cost_per_box) as ' Total sale',sum(Boxes) as 'Total Boxes'
from sales s
JOIN products pr on s.PID = pr.PID
WHERE pr.Product in ('Milk Bars'  ,'Eclairs')
and month(SaleDate)=02 and weekofyear(SaleDate)=05 
group by pr.Product;


/* Product sold more boxes in the first 7 days of February 2022 */

select pr.Product, sum(Boxes) as ' Total Boxes'
from sales s
JOIN products pr on s.PID = pr.PID
WHERE year(SaleDate)=2022 and weekofyear(SaleDate)=05 
group by pr.Product
order by sum(Boxes) desc;


/* Sales on Wednesday */

select SPID , SaleDate as 'Sales on Wednesday',Boxes
from sales
where Customers <100 and Boxes < 100 and weekday(SaleDate)= 03;


/* Names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022 */

select distinct p.Salesperson
from sales s
join people p on p.spid = s.SPID
where s.SaleDate between "2022-01-01" and "2022-01-07";

/* Salespersons who did not make any shipments in the first 7 days of January 2022*/

select distinct p.Salesperson
from sales s
join people p on p.SPID = s.SPID
where s.SaleDate between "2022-01-01" and "2022-01-07" and Amount = null;


/* Total boxes shipped each month */

select year(SaleDate) , month(SaleDate) , sum(Boxes) as 'Total boxes of month'
from sales
group by year(SaleDate) , month(SaleDate)
order by year(SaleDate) , month(SaleDate);


/* No. of times we shipped more than 1,000 boxes in each month*/

select year(SaleDate) as ' Year', month(SaleDate) as ' Month' , count(Boxes) as 'Total boxes order above 1000'
from sales
where Boxes > 1000
group by year(SaleDate) , month(SaleDate)
order by year(SaleDate) , month(SaleDate);


/* Total boxes from India & Australia monthwise*/

select year(SaleDate) as ' Year' , month(SaleDate) as 'Month' , sum(Boxes) as 'Total boxes from India & Australia'
from sales s
join geo on s.GeoID = geo.GeoID
where Geo in ('India', 'Australia') 
group by year(SaleDate) , month(SaleDate)
order by year(SaleDate) , month(SaleDate);

/* Total boxes from India & Australia*/

select geo.Geo,  sum(Boxes) as 'Total boxes'
from sales s
join geo on s.GeoID = geo.GeoID
where Geo in ('India', 'Australia') 
group by geo.Geo;


/* Total boxes from India & Australia seperately*/

select geo.Geo, year(SaleDate) as ' Year' , month(SaleDate) as 'Month' , sum(Boxes) as 'Total boxes'
from sales s
join geo on s.GeoID = geo.GeoID
where Geo in ('India') 
group by year(SaleDate) , month(SaleDate)
order by year(SaleDate) , month(SaleDate);


select geo.Geo, year(SaleDate) as ' Year' , month(SaleDate) as 'Month' , sum(Boxes) as 'Total boxes'
from sales s
join geo on s.GeoID = geo.GeoID
where Geo in ('Australia') 
group by year(SaleDate) , month(SaleDate)
order by year(SaleDate) , month(SaleDate);


/* Creating Temporary table */

create temporary table Total_Boxes_Aus
select geo.Geo, year(SaleDate) as ' Year' , month(SaleDate) as 'Month' , sum(Boxes) as 'Total boxes'
from sales s
join geo on s.GeoID = geo.GeoID
where Geo in ('Australia') 
group by year(SaleDate) , month(SaleDate)
order by year(SaleDate) , month(SaleDate); 

create temporary table Total_Boxes_IND
select geo.Geo, year(SaleDate) as ' Year' , month(SaleDate) as 'Month' , sum(Boxes) as 'Total boxes'
from sales s
join geo on s.GeoID = geo.GeoID
where Geo in ('India') 
group by year(SaleDate) , month(SaleDate)
order by year(SaleDate) , month(SaleDate); 

/* Total boxes from India & Australia monthwise by Joining table*/

select * from Total_Boxes_IND
UNION
select * from Total_Boxes_AUS; 

/*Creating Amount Category*/

select 	SaleDate, Amount,
		case 	when amount < 1000 then 'Under 1k'
				when amount < 5000 then 'Under 5k'
                when amount < 10000 then 'Under 10k'
			else '10k or more'
		end as 'Amount category'
from sales;


/* Selecting salesperson with name staring from D */

select * from people
where salesperson like 'D%';

/* Selecting salesperson with name having S */

select * from people
where salesperson like '%S%';
