



---E-Commerce Project---

use ecommerce_project

select * from cust_dimen

update cust_dimen
set Cust_id = REPLACE(Cust_id,'Cust_','')

alter table cust_dimen alter column Cust_id int
-----
select* from market_fact

update market_fact
set Ord_id = REPLACE(Ord_id,'Ord_','');

update market_fact
set Prod_id = REPLACE(Prod_id,'Prod_','');

update market_fact
set Ship_id = REPLACE(Ship_id,'SHP_','');

update market_fact
set Cust_id = REPLACE(Cust_id,'Cust_','');
-------

alter table market_fact alter column Ord_id int
alter table market_fact alter column Prod_id int
alter table market_fact alter column Ship_id int
alter table market_fact alter column Cust_id int
----
select * from orders_dimen 
update orders_dimen
set Ord_id = REPLACE(Ord_id,'Ord_','');

alter table orders_dimen alter column Ord_id int
-----
select * from prod_dimen

update prod_dimen
set Prod_id = REPLACE(Prod_id,'Prod_','');

alter table prod_dimen alter column Prod_id int;
------

select * from shipping_dimen 
update shipping_dimen
set Ship_id = REPLACE(Ship_id,'SHP_','');

alter table shipping_dimen alter column Ship_id int

--1. Join all the tables and create a new table called combined_table. (market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)

SELECT *
INTO
combined_table
FROM
(
SELECT
c.Cust_id, c.Customer_Name, c.Province, c.Region, c.Customer_Segment,
m.Ord_id, m.Prod_id, m.Sales, m.Discount, m.Order_Quantity, m.Product_Base_Margin,
o.Order_Date, o.Order_Priority,
p.Product_Category, p.Product_Sub_Category,
s.Ship_id, s.Ship_Mode, s.Ship_Date
FROM market_fact m
INNER JOIN cust_dimen c ON m.Cust_id = c.Cust_id
INNER JOIN orders_dimen o ON o.Ord_id = m.Ord_id
INNER JOIN prod_dimen p ON p.Prod_id = m.Prod_id
INNER JOIN shipping_dimen s ON s.Ship_id = m.Ship_id
) A;

SELECT * 
FROM combined_table




--///////////////////////


--2. Find the top 3 customers who have the maximum count of orders.

SELECT top 3 Cust_id,Customer_Name, count(Ord_id) as count_of_orders
FROM combined_table
GROUP BY Cust_id,Customer_Name
ORDER BY  count_of_orders  desc


--/////////////////////////////////



--3.Create a new column at combined_table as DaysTakenForShipping that contains the date difference of Order_Date and Ship_Date.
--Use "ALTER TABLE", "UPDATE" etc.




ALTER TABLE combined_table
ADD	DaysTakenForDelivery INT;

SELECT Order_Date, Ship_Date, DATEDIFF(day, Order_Date, Ship_Date) FROM combined_table


UPDATE combined_table
SET DaysTakenForDelivery = DATEDIFF(day, Order_Date, Ship_Date)


SELECT TOP 100 *
FROM combined_table


--////////////////////////////////////


--4. Find the customer whose order took the maximum time to get shipping.
--Use "MAX" or "TOP"

SELECT cust_id, Customer_Name,Order_Date,Ship_Date, DaysTakenForDelivery
FROM combined_table
WHERE DaysTakenForDelivery = (SELECT MAX(DaysTakenForDelivery)
                              FROM combined_table)





--////////////////////////////////



--5. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011
--You can use date functions and subqueries



SELECT MONTH(order_date) [MONTH], COUNT(DISTINCT cust_id) MONTHLY_NUM_OF_CUST
FROM	Combined_table A
WHERE
EXISTS
(
SELECT  Cust_id
FROM	combined_table B
WHERE	YEAR(Order_Date) = 2011
AND		MONTH (Order_Date) = 1
AND		A.Cust_id = B.Cust_id
)
AND	YEAR (Order_Date) = 2011
GROUP BY
MONTH(order_date)


--////////////////////////////////////////////


--6. write a query to return for each user acording to the time elapsed between the first purchasing and the third purchasing, 
--in ascending order by Customer ID
--Use "MIN" with Window Functions

SELECT  DISTINCT cust_id, Order_date, dense_number, first_order_date,
                  DATEDIFF(day, first_order_date , order_date) DAYS_ELAPSED
FROM (
SELECT cust_id,Ord_id, Order_date,
MIN(Order_date) OVER ( PARTITION BY cust_id) as first_order_date, 
dense_rank() OVER (PARTITION BY Cust_id ORDER BY Order_date) as dense_number 
FROM combined_table )  A 
WHERE dense_number = 3
ORDER BY cust_id asc





--//////////////////////////////////////

--7. Write a query that returns customers who purchased both product 11 and product 14, 
--as well as the ratio of these products to the total number of products purchased by all customers.
--Use CASE Expression, CTE, CAST and/or Aggregate Functions

WITH T1 as (
SELECT cust_id ,
       SUM(CASE WHEN Prod_id = '11' THEN Order_Quantity ELSE 0 END) AS P11,
       SUM(CASE WHEN Prod_id = '14' THEN Order_Quantity ELSE 0 END) AS P14,
       SUM(Order_Quantity) AS TOTAL_PROD
FROM combined_table
GROUP BY Cust_id
HAVING
        SUM(CASE WHEN Prod_id = '11' THEN Order_Quantity ELSE 0 END) >=1 AND
		SUM(CASE WHEN Prod_id = '14' THEN Order_Quantity ELSE 0 END) >=1
)
SELECT cust_id, P11, P14, TOTAL_PROD,
	   ROUND(CAST( P11 as float)/CAST (TOTAL_PROD as float), 2) RATIO_P11,
	   ROUND(CAST( P14 as float)/CAST (TOTAL_PROD as float), 2) RATIO_P14
FROM T1 
ORDER BY cust_id


--/////////////////




--CUSTOMER SEGMENTATION



--1. Create a view that keeps visit logs of customers on a monthly basis. (For each log, three field is kept: Cust_id, Year, Month)
--Use such date functions. Don't forget to call up columns you might need later.



CREATE VIEW customer_logs AS

SELECT	cust_id,
		YEAR (ORDER_DATE) [YEAR],
		MONTH (ORDER_DATE) [MONTH]
FROM	combined_table

ORDER BY 1,2,3

--//////////////////////////////////



  --2.Create a “view” that keeps the number of monthly visits by users. (Show separately all months from the beginning  business)
--Don't forget to call up columns you might need later.

create view monthly_visits as


SELECT Cust_id, 
	          YEAR(Order_Date) AS [YEAR], 
	          MONTH(Order_Date) AS [MONTH],
	          COUNT(Order_Date) AS NUM_OF_LOG
FROM combined_table
GROUP BY Cust_id, YEAR(Order_Date), MONTH(Order_Date);








--//////////////////////////////////


--3. For each visit of customers, create the next month of the visit as a separate column.
--You can order the months using "DENSE_RANK" function.
--then create a new column for each month showing the next month using the order you have made above. (use "LEAD" function.)
--Don't forget to call up columns you might need later.


create view next_month as

select *, 
lead(current_month) over(partition by cust_id order by current_month ) as next_visit_month
from (
select * ,
dense_rank() over( order by [year], [month]) as current_month
from monthy_visits) as A
----------------------------
select * from next_month


--/////////////////////////////////



--4. Calculate monthly time gap between two consecutive visits by each customer.
--Don't forget to call up columns you might need later.



create view monthly_time_gap as

select *, 
 abs(next_visit_month- current_month) as time_gaps
from next_month
--------------------
select * from monthly_time_gap




--///////////////////////////////////


--5.Categorise customers using average time gaps. Choose the most fitted labeling model for you.
--For example: 
--Labeled as “churn” if the customer hasn't made another purchase for the months since they made their first purchase.
--Labeled as “regular” if the customer has made a purchase every month.
--Etc.
	
select  cust_id, avg(time_gaps) avg_time_gap ,
case 
    when avg(time_gaps )=1  then 'regular'
	when avg(time_gaps ) is null then 'Churn'
	else  'irregular'
end as Cust_Labels
from monthly_time_gap
group by cust_id







--/////////////////////////////////////




--MONTH-WISE RETENTÝON RATE


--Find month-by-month customer retention rate  since the start of the business.


--1. Find the number of customers retained month-wise. (You can use time gaps)
--Use Time Gaps


select distinct * ,
count(Cust_id) OVER(partition by [year], [month]) as RetentionMonthWise
from monthly_time_gap
where time_gaps= 1
order by cust_id
-----------------------------------


--//////////////////////


--2. Calculate the month-wise retention rate.

--Basic formula: o	Month-Wise Retention Rate = 1.0 * Number of Customers Retained in The Current Month / Total Number of Customers in the Current Month

--It is easier to divide the operations into parts rather than in a single ad-hoc query. It is recommended to use View. 
--You can also use CTE or Subquery if you want.

--You should pay attention to the join type and join columns between your views or tables.



with T1 as
(
select [year], [month], 
count( cust_id)  as Total_Number_of_Customers,
sum( case when time_gaps= 1 then 1 end) as Number_of_Customers
from  monthly_time_gap
where current_month > 1
group by [year], [month] 
)
select [year], [month],
round(cast( Number_of_Customers as float)/ Total_Number_of_Customers , 2) as Retention_rate
from T1
where Number_of_Customers is not null
order by 1, 2



---///////////////////////////////////
--Good luck!