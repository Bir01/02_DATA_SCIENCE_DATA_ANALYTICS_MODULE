select  distinct order_id ,
        (select  sum(list_price) 
		from sale.order_item B 
		where A.order_id= B.order_id) as list_prc
from sale.order_item A

--- Subquery in SELECT Statement ---
--- QUESTION : Write a query that creates a new column named "total_price" calculating the total prices of the products on each order.

select * 
from sale.staff
where first_name= 'Davis'
and last_name = 'Thomas'


select *
from sale.staff
where store_id = (
					select store_id 
					from sale.staff
					where first_name= 'Davis'
					and last_name = 'Thomas' )

select staff_id 
from sale.staff
where first_name= 'Charles'
and last_name = 'Cussona'

select *
from sale.staff
where manager_id= (
					select staff_id 
					from sale.staff
					where first_name= 'Charles'
                    and last_name = 'Cussona')


--Q: write a query that returns customers in the city where 'The BFLO Store' is located.

select city  from sale.store
where store_name='The BFLO Store'

select * 
from sale.customer
where city= (
             select city  from sale.store
             where store_name='The BFLO Store'
			 )

select * 
from sale.customer
where city In (
             select city  from sale.store
             where store_name='The BFLO Store'
			 )

--Q: list bikes that are more expensive than the 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)' bike 

select *
from product.product
where list_price> (
					select list_price
					from product.product
					where product_name='Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'
					)




--Q:list customers whoose order dates are before Hassan Pope 	

select order_date 
from sale.customer A, sale.orders B
where A.customer_id= B.customer_id               
and first_name= 'Hassan'
and last_name= 'Pope'

select A.customer_id, a.first_name, a.last_name , b.order_id, b.order_date 
from sale.customer A, sale.orders B
where A.customer_id= B.customer_id
and order_date < (
                  select order_date 
				  from sale.customer A, sale.orders B
				  where A.customer_id= B.customer_id               
				  and first_name= 'Hassan'
				  and last_name= 'Pope'
				  )

order by order_date

-- Write a query that returns customer first names, last names and order dates.
-- The customers who are order on the same dates as Laurel Goldammer.
-- Laurel Goldammer isimli müşterinin alışveriş yaptığı tarihte/tarihlerde alışveriş yapan tüm müşterileri listeleyin.
-- Müşteri adı, soyadı ve sipariş tarihi bilgilerini listeleyin.

  select *
  from sale.customer a, sale.orders b
  where a.customer_id= b.customer_id
  and b.order_date in (
					  select b.order_date
					  from sale.customer a, sale.orders b
					  where a.first_name='Laurel'
					  and a.last_name= 'Goldammer'
					  and a.customer_id= B.customer_id
					  )

 --Q: List the products ordered the last 10 orders in Buffalo city.
-- Buffalo şehrinde son 10 siparişten sipariş verilen ürünleri listeleyin.

select distinct product_name
from product.product a, sale.order_item b, ( 
select top(10) order_id
from sale.orders a, sale.customer b
where  a.customer_id= b.customer_id
and city= 'Buffalo'
order by order_id desc
											  ) c
where 
a.product_id= b.product_id
and b.order_id= c.order_id

-----
SELECT distinct product_name
FROM sale.customer A,sale.orders B,sale.order_item C,product.product D
WHERE A.customer_id = B.customer_id 
AND B.order_id = C.order_id 
AND C.product_id = D.product_id 
AND C.order_id IN (
					SELECT distinct TOP 10  C.order_id
					FROM sale.customer A,sale.orders B,sale.order_item C,product.product D
					WHERE city = 'Buffalo' 
					AND A.customer_id = B.customer_id 
					AND B.order_id = C.order_id 
					AND C.product_id = D.product_id
					ORDER BY C.order_id DESC)

--Q: List products out of 'Game', 'gps', or 'Home Theater' categories and made in 2021.

select A.product_name, A.list_price
from product.product A, product.category B
where A.category_id= B.category_id
and   A.model_year= '2021'
and   B.category_name not in ( 'Game', 'gps', 'Home Theater')

--Q: list products made in 2020 and its prices more than all products in the 
-- Receivers Amplifiers category

select * from product.product
select * from product.category

SELECT product_name, list_price 
FROM	product.product
WHERE model_year = '2020'
AND list_price > (
				SELECT MAX(A.list_price)
				FROM product.product A, product.category B
				WHERE A.category_id = B.category_id
				AND B.category_name = 'Receivers Amplifiers'
				)

select product_name, model_year, list_price
from product.product 
where  model_year= '2020'
and  list_price > 

all( select a.list_price 
from product.product a, product.category b
where a.category_id= b.category_id
and b.category_name = 'Receivers Amplifiers')

--Q: list products made in 2020 and its prices more than any products in the 
-- Receivers Amplifiers category

select product_name, model_year, list_price
from product.product 
where  model_year= '2020'
and  list_price > 

any( select a.list_price 
from product.product a, product.category b
where a.category_id= b.category_id
and b.category_name = 'Receivers Amplifiers')
order by 3

select * from product.product
select * from product.category

SELECT product_name, list_price 
FROM	product.product
WHERE model_year = '2020'
AND list_price > (
				SELECT MIN(A.list_price)
				FROM product.product A, product.category B
				WHERE A.category_id = B.category_id
				AND B.category_name = 'Receivers Amplifiers'
				)


--Q: write a query that returns State where 'Apple - Pre-Owned iPad 3 - 32GB - White' product is not ordered

select distinct state from sale.customer



select distinct state 
from sale.customer X
where not exists (
                  select 1
				  from sale.customer A,sale.orders B,  sale.order_item C, product.product  D
				  where 
				  A.customer_id=B.customer_id
				  and B.order_id= C.order_id
				  and C.product_id= D.product_id
				  and product_name= 'Apple - Pre-Owned iPad 3 - 32GB - White'
				  and A.state= X.state
				  )



select distinct state 
from sale.customer X
where exists (
                  select 1
				  from sale.customer A,sale.orders B,  sale.order_item C, product.product  D
				  where 
				  A.customer_id=B.customer_id
				  and B.order_id= C.order_id
				  and C.product_id= D.product_id
				  and product_name= 'Apple - Pre-Owned iPad 3 - 32GB - White'
				  and A.state= X.state
				  )
----

--- QUESTION : Write a query that returns stock information of the products in Davi Techno Retail Store.
--- The BFLO Store has not got any stock of that products.

SELECT X.store_name, Y.product_id, Y.quantity 
FROM sale.store X JOIN product.stock Y
		ON X.store_id = Y.store_id
WHERE X.store_name = 'Davi techno Retail'
AND NOT EXISTS (
				SELECT 1
				FROM sale.store A JOIN product.stock B
				ON A.store_id = B.store_id
				WHERE B.quantity > 0
				AND A.store_name = 'The BFLO Store'
				AND B.product_id = Y.product_id)

SELECT X.store_name, Y.product_id, Y.quantity 
FROM sale.store X JOIN product.stock Y
		ON X.store_id = Y.store_id
WHERE X.store_name = 'Davi techno Retail'
AND EXISTS (
			SELECT B.product_id
			FROM sale.store A JOIN product.stock B
			ON A.store_id = B.store_id
			WHERE B.quantity = 0
			AND A.store_name = 'The BFLO Store'
			AND B.product_id = Y.product_id)


select distinct C.state
from product.product as A, sale.order_item as B, sale.customer as C, sale.orders as D
where A.product_id=B.product_id and B.order_id=D.order_id and C.customer_id=D.customer_id and
C.state not in (select C.state
				from product.product as A, sale.order_item as B, sale.customer as C, sale.orders as D
				where A.product_name='Apple - Pre-Owned iPad 3 - 32GB - White' and
				A.product_id=B.product_id and B.order_id=D.order_id and C.customer_id=D.customer_id)


--Q:List customers who have an order prior to the last order of a customer named Jerald Barry and are resident of the Austin city.
-- Jerald Barry isimli müşterinin son siparişinden önce sipariş vermiş
--ve Austin şehrinde ikamet eden müşterileri listeleyin.

WITH T1 AS
(
SELECT	MAX(order_date) last_order_date
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		A.first_name = 'Jerald'
AND		A.last_name = 'Berray'
)
SELECT	d.customer_id, d.first_name, D.last_name, D.city, C.order_date
FROM	T1, sale.orders C, SALE.customer D
WHERE	T1.last_order_date > C.order_date
AND		C.customer_id = D.customer_id
AND		D.city ='Austin'

