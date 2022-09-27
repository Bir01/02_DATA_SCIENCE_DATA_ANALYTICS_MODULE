select first_name, last_name 
from sale.customer
where city= 'Charlotte'
union 
select last_name 
from sale.customer
where city= 'Aurora'


select first_name, last_name
from sale.customer
where first_name= 'Thomas'
Union
select first_name, last_name
from sale.customer
where last_name= 'Thomas'



select first_name, last_name
from sale.customer
where first_name= 'Thomas'
Union all
select first_name, last_name
from sale.customer
where last_name= 'Thomas'



SELECT first_name, last_name, COUNT(*) AS duplicates
FROM sale.customer
WHERE first_name = 'Thomas'
	OR last_name = 'Thomas'
GROUP BY first_name, last_name
HAVING (COUNT(*) > 1)


 select a.brand_id, a.brand_name
  from product.brand a, product.product b
  where a.brand_id= b.brand_id
  and model_year= '2018'
  intersect
   select a.brand_id, a.brand_name
  from product.brand a, product.product b
  where a.brand_id= b.brand_id
  and model_year= '2020'

SELECT	first_name, last_name
FROM	sale.customer
WHERE	customer_id IN (
						SELECT	customer_id
						FROM	sale.orders
						WHERE	order_date BETWEEN '2018-01-01' AND '2018-12-31'
						INTERSECT
						SELECT	customer_id
						FROM	sale.orders
						WHERE	order_date BETWEEN '2019-01-01' AND '2019-12-31'
						INTERSECT
						SELECT	customer_id
						FROM	sale.orders
						WHERE	order_date BETWEEN '2020-01-01' AND '2020-12-31'
						)


select a.customer_id, first_name, last_name
from sale.customer a, sale.orders b
where a.customer_id= b.customer_id
and YEAR(order_date) = 2018
intersect
select a.customer_id, first_name, last_name
from sale.customer a, sale.orders b
where a.customer_id= b.customer_id
and order_date like '2019%'
intersect
select a.customer_id, first_name, last_name
from sale.customer a, sale.orders b
where a.customer_id= b.customer_id
and order_date like '2020%'


SELECT	a.brand_id, b.brand_name
FROM	product.product a, product.brand b
WHERE	a.brand_id= b.brand_id
and model_year = 2018
EXCEPT
SELECT	a.brand_id, b.brand_name
FROM	product.product a, product.brand b
WHERE	a.brand_id= b.brand_id
and     model_year = 2019


select a.product_id, product_name 
from product.product a , sale.order_item b, sale.orders c
where a.product_id= b.product_id
and b.order_id= c.order_id
and order_date between '2019-01-01' and '2019-12-31'
except
select a.product_id, product_name 
from product.product a , sale.order_item b, sale.orders c
where a.product_id= b.product_id
and b.order_id= c.order_id
and order_date not between '2019-01-01' and '2019-12-31' 




SELECT	product_id, product_name
FROM	product.product
WHERE	product_id IN (
						SELECT	B.product_id
						FROM	sale.orders A, sale.order_item B
						WHERE	A.order_id = B.order_id AND
								A.order_date BETWEEN '2019-01-01' AND '2019-12-31'
						EXCEPT
						SELECT	B.product_id
						FROM	sale.orders A, sale.order_item B
						WHERE	A.order_id = B.order_id AND
								A.order_date not BETWEEN '2019-01-01' AND '2019-12-31'
						)


--CASE EXPRESSION

-- Generate a new column containing what the mean of the values in the Order_Status column.

-- 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed

select order_id, order_status,
case order_status 
		when 1 then 'Pending'
		when 2 then 'Processing'
		when 3 then 'Rejected'
		else 'Completed'
END AS order_status_desc
from sale.orders
order by 2

--Q: Add a column to the sale.staff table containing the store names of the employees.
-- 1= Davi Techno Retail; 2=The BFLO Store; 3= Burkes Outlet

SELECT first_name,last_name,store_id,
CASE
	WHEN store_id = 1 THEN 'Davi Techno Retail'
	WHEN store_id = 2 THEN 'The BFLO Store'
	WHEN store_id = 3 THEN 'Burkes Outlet'   --(else then 'Burkes Outlet')
END AS store_name
FROM sale.staff

--Q: Add a column to the sale.staff table containing the store names of the employees.
-- 1= Davi Techno Retail; 2=The BFLO Store; 3= Burkes Outlet

SELECT first_name,last_name,store_id,
CASE store_id
	WHEN 1 THEN 'Davi Techno Retail'
	WHEN  2 THEN 'The BFLO Store'
	WHEN  3 THEN 'Burkes Outlet'   
END AS store_name
FROM sale.staff

/* Searched CASE Expression
CASE
  WHEN condition_1 THEN result_1
  WHEN condition_2 THEN result_2
  WHEN condition_N THEN result_N
  [ ELSE result ]
END
example : 
When salary < $55,000 THEN 'Low'
When salary is between $55,000 and $80,000 THEN 'Middle'
When salary > $80,000 THEN 'High' */

--Q- Cresate a new column containing the labels of customers ' email service providers (Gmail, Hotmail, Yahoo or Other)  

select customer_id, first_name,last_name, email, 
case
    when email  like '%@hotmail%'  then 'Hotmail' 
	when email  like '%@gmail%' then 'Gmail'
	when email  like '%@yahoo%' then 'Yahoo'
	else 'Other'
	END AS email_service_provider
FROM sale.customer

--Q: List customers ordered products in the computer accessories , speakers, and mp4 player categories in the same order.

select E.first_name, E.last_name, A.order_id
from sale.orders as A, sale.order_item as B, product.product as C, product.category as D, sale.customer as E
where A.order_id=B.order_id and B.product_id=C.product_id and  E.customer_id=A.customer_id and C.category_id=D.category_id
and D.category_name='Computer Accessories'
intersect
select E.first_name, E.last_name, A.order_id
from sale.orders as A, sale.order_item as B, product.product as C, product.category as D, sale.customer as E
where A.order_id=B.order_id and B.product_id=C.product_id and  E.customer_id=A.customer_id and C.category_id=D.category_id
and D.category_name='mp4 player'
intersect
select E.first_name, E.last_name, A.order_id
from sale.orders as A, sale.order_item as B, product.product as C, product.category as D, sale.customer as E
where A.order_id=B.order_id and B.product_id=C.product_id and  E.customer_id=A.customer_id and C.category_id=D.category_id
and D.category_name='Speakers'



select A.customer_id, A.first_name, A.last_name, C.order_id, 
		sum(case when E.category_name= 'mp4 player' then 1 else 0 end) as C1,
		sum(case when E.category_name= 'Speakers' then 1 else 0 end) as C2,
		sum(case when E.category_name= 'Computer Accessories' then 1 else 0 end) as C3

from sale.customer A, sale.orders B , sale.order_item C, product.product D, product.category E
where A.customer_id= B.customer_id
and B.order_id= C.order_id
and C.product_id= D.product_id
and D.category_id= E.category_id
group by 
       A.customer_id, A.first_name, A.last_name, C.order_id
having 
      sum(case when E.category_name= 'mp4 player' then 1 else 0 end) > 0
	  and
	  sum(case when E.category_name= 'Speakers' then 1 else 0 end) >0
	  and
	  sum(case when E.category_name= 'Computer Accessories' then 1 else 0 end) >0

select  A.first_name, A.last_name
from sale.customer A, sale.orders B , sale.order_item C, product.product D, product.category E
where A.customer_id= B.customer_id
and B.order_id= C.order_id
and C.product_id= D.product_id
and D.category_id= E.category_id
group by 
       A.customer_id, A.first_name, A.last_name, C.order_id
having 
      sum(case when E.category_name= 'mp4 player' then 1 else 0 end) > 0
	  and
	  sum(case when E.category_name= 'Speakers' then 1 else 0 end) >0
	  and
	  sum(case when E.category_name= 'Computer Accessories' then 1 else 0 end) >0


--Write a query that returns the count of the orders day by day in a pivot table format that has been shipped two days later.
--2 günden geç kargolanan siparişlerin haftanın günlerine göre dağılımını hesaplayınız.

SELECT	DATENAME(WEEKDAY, order_date) AS ORD_DAY, COUNT (order_id) AS CNT_ORDER
FROM	sale.orders
WHERE	DATEDIFF(DAY, order_date, shipped_date) > 2
GROUP BY 
		DATENAME(WEEKDAY, order_date)



---------

SELECT *
FROM
	(
	SELECT	DATENAME(WEEKDAY, order_date) AS ORD_DAY, order_id
	FROM	sale.orders
	WHERE	DATEDIFF(DAY, order_date, shipped_date) > 2
	) AS A
PIVOT 
(
COUNT (order_id)
FOR	ORD_DAY
IN (
	[Monday], 
    [Tuesday], 
    [Wednesday], 
    [Thursday], 
    [Friday], 
    [Saturday], 
    [Sunday]
	)
) AS PVT_TABLE


SELECT 
       SUM(case when DATENAME(WEEKDAY, order_date)= 'Monday' then 1 else 0 end) as  MONDAY ,
       SUM(case when DATENAME(WEEKDAY, order_date)= 'Tuesday' then 1 else 0 end) TUESDAY,
	   SUM(case when DATENAME(WEEKDAY, order_date)= 'Wednesday' then 1 else 0 end) WEDNESDAY,
	   SUM(case when DATENAME(WEEKDAY, order_date)= 'Thursday' then 1 else 0 end) THURSDAY,
	   SUM(case when DATENAME(WEEKDAY, order_date)= 'Friday' then 1 else 0 end) FRIDAY,
	   SUM(case when DATENAME(WEEKDAY, order_date)= 'Saturday' then 1 else 0 end) SATURDAY,
	   SUM(case when DATENAME(WEEKDAY, order_date)= 'Sunday' then 1 else 0 end) SUNDAY
FROM   sale.orders
WHERE	DATEDIFF(DAY, order_date, shipped_date) > 2
 
	
	-- QUESTION : The street column has some string characters (5C, 43E, 234F, etc) that are mistakenly added to the end of the numeric characters in the first part
-- of the street records. Remove this typos in this column.

SELECT street FROM sale.customer

SELECT street,
       SUBSTRING(LEFT(street, CHARINDEX(' ', street)- 1), 1, LEN(LEFT(street, CHARINDEX(' ', street)-1))-1)
	   +
	   ' '
	   +
	   SUBSTRING(street, PATINDEX('% %', street)+1, 50)
FROM sale.customer
WHERE ISNUMERIC (RIGHT(LEFT(street, CHARINDEX(' ', street)-1),1)) = 0