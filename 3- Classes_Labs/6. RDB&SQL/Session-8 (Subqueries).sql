


---SUBQUERIES (SINGLE ROW SUBQUERIES)

----Subquery in SELECT Statement

--Write a query that creates a new column named "total_price" calculating the total prices of the products on each order.
--order id' lere g�re toplam list price lar� hesaplay�n.



SELECT order_id, SUM (list_price) total_price
FROM sale.order_item
GROUP BY order_id




SELECT DISTINCT order_id, 
		(
			SELECT SUM(list_price) 
			FROM	sale.order_item B
			WHERE	A.order_id = B.order_id
		)
FROM	SALE.order_item A


-----------


--T�m sipari�lerin kar��s�na tablodaki t�m �r�nlerin toplam de�erini d�nd�r�r.

SELECT DISTINCT order_id, 
		(
			SELECT	SUM(list_price) 
			FROM	sale.order_item 
		)
FROM	SALE.order_item



--hatal�, ��nk� select statement' ta kullan�lan subquery tek bir s�tun i�erebilir.

SELECT DISTINCT order_id, 
		(
			SELECT	product_id, list_price
			FROM	sale.order_item 
		)
FROM	SALE.order_item



--hatal�, ��nk� select statement' ta kullan�lan subquery tek bir de�er i�erebilir.

SELECT DISTINCT order_id, 
		(
			SELECT	product_id
			FROM	sale.order_item 
		)
FROM	SALE.order_item



SELECT DISTINCT order_id, 
		(
			SELECT	TOP 1 product_id
			FROM	sale.order_item 
		)
FROM	SALE.order_item




SELECT DISTINCT order_id, ( SELECT	'ali' ) as [name]
FROM	SALE.order_item



--------------------------------/////////////////////
--- QUESTION : Write a query that shows all employees in the store where Davis Thomas works.
--- WHERE clause


SELECT	store_id
FROM	sale.staff
WHERE	first_name = 'Davis'
AND		last_name = 'Thomas'



SELECT *
FROM	sale.staff
WHERE	store_id = (
					SELECT	store_id
					FROM	sale.staff
					WHERE	first_name = 'Davis'
					AND		last_name = 'Thomas'
					)




-- Write a query that shows the employees for whom Charles Cussona is a first-degree manager. 
--(To which employees are Charles Cussona a first-degree manager?)
-- Charles	Cussona '�n y�neticisi oldu�u personelleri listeleyin.



SELECT	staff_id
FROM	sale.staff
WHERE	first_name = 'Charles'
AND		last_name = 'Cussona'



SELECT *
FROM	sale.staff
WHERE	manager_id = (
						SELECT	staff_id
						FROM	sale.staff
						WHERE	first_name = 'Charles'
						AND		last_name = 'Cussona'

						)



-- Write a query that returns the customers located where �The BFLO Store' is located.
-- 'The BFLO Store' isimli ma�azan�n bulundu�u �ehirdeki m��terileri listeleyin.


SELECT	city
FROM	sale.store
WHERE	store_name = 'The BFLO Store'


SELECT *
FROM	sale.customer
WHERE	city = (SELECT	city
				FROM	sale.store
				WHERE	store_name = 'The BFLO Store')

----

SELECT *
FROM	sale.customer
WHERE	city IN (SELECT	city
				FROM	sale.store
				WHERE	store_name = 'The BFLO Store')



--------------///////////////////


--Write a query that returns the list of products that are more expensive than the product named 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'

-- 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)' isimli �r�nden pahal� olan �r�nleri listeleyin.
-- Product id, product name, model_year, fiyat, marka ad� ve kategori ad� alanlar�na ihtiya� duyulmaktad�r.


SELECT	list_price
FROM	product.product
WHERE	product_name = 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'




SELECT *
FROM	product.product
WHERE	list_price > (
						SELECT	list_price
						FROM	product.product
						WHERE	product_name = 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'
						)


-- ///////////

-- Write a query that returns the customer names, last names, and order dates. 
-- The customers who are order before order date of Hassan Pope.
-- Hassan Pope isimli m��teriden daha �nceki tarihlerde sipari� veren m��terileri listeleyin.
-- M��teri ad�, soyad� ve sipari� tarihi bilgilerini listeleyin.


SELECT *
FROM	sale.customer 
WHERE	first_name = 'Hassan'
AND		last_name = 'Pope'


SELECT order_date
FROM	sale.orders
WHERE	customer_id = (SELECT	customer_id
						FROM	sale.customer 
						WHERE	first_name = 'Hassan'
						AND		last_name = 'Pope')




SELECT	A.customer_id, A.first_name, A.last_name, B.order_id, B.order_date
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		order_date < (
						SELECT order_date
						FROM	sale.orders
						WHERE	customer_id = (
												SELECT	customer_id
												FROM	sale.customer 
												WHERE	first_name = 'Hassan'
												AND		last_name = 'Pope'
												)
						)
ORDER BY order_date




---JOIN



SELECT	A.customer_id, A.first_name, A.last_name, B.order_id, B.order_date
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		order_date < (
						SELECT order_date
						FROM	sale.orders A, sale.customer B
						WHERE	A.customer_id = B.customer_id
						AND		first_name = 'Hassan'
						AND		last_name = 'Pope'
						)
ORDER BY order_date


------ MULTIPLE ROW SUBQUERIES ------


--/////////////////


-- Write a query that returns customer first names, last names and order dates. 
-- The customers who are order on the same dates as Laurel Goldammer.

-- Laurel Goldammer isimli m��terinin al��veri� yapt��� tarihte/tarihlerde al��veri� yapan t�m m��terileri listeleyin.
-- M��teri ad�, soyad� ve sipari� tarihi bilgilerini listeleyin.




SELECT	B.order_id, B.order_date
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		A.first_name = 'Laurel'
AND		A.last_name = 'Goldammer'



SELECT	A.customer_id, A.first_name, A.last_name, order_id, order_date
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		order_date = ANY (
						SELECT	B.order_date
						FROM	sale.customer A, sale.orders B
						WHERE	A.customer_id = B.customer_id
						AND		A.first_name = 'Laurel'
						AND		A.last_name = 'Goldammer'
						)



SELECT	A.customer_id, A.first_name, A.last_name, order_id, order_date
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		order_date IN (
						SELECT	B.order_date
						FROM	sale.customer A, sale.orders B
						WHERE	A.customer_id = B.customer_id
						AND		A.first_name = 'Laurel'
						AND		A.last_name = 'Goldammer'
						)



--List the products that ordered in the last 10 orders in Buffalo city.
-- Buffalo �ehrinde son 10 sipari�te sipari� verilen �r�nleri listeleyin.



SELECT	TOP 10 B.order_id
FROM	sale.customer A, sale.orders B
WHERE	city = 'Buffalo'
AND		A.customer_id = B.customer_id
ORDER BY 1 DESC


SELECT	 DISTINCT B.product_name
FROM	sale.order_item A, product.product B
WHERE	A.product_id = B.product_id
AND		A.order_id IN (

						SELECT	TOP 10 B.order_id
						FROM	sale.customer A, sale.orders B
						WHERE	city = 'Buffalo'
						AND		A.customer_id = B.customer_id
						ORDER BY 1 DESC
						)
 

 -- FROM STATEMENT


SELECT	DISTINCT B.product_name
FROM	sale.order_item A, product.product B, 
		(
		SELECT	TOP 10 B.order_id
		FROM	sale.customer A, sale.orders B
		WHERE	city = 'Buffalo'
		AND		A.customer_id = B.customer_id
		ORDER BY 1 DESC
		) C
WHERE	A.product_id = B.product_id
AND		A.order_id = C.order_id



-- //////

--Write a query that returns the product_names and list price that were made in 2021. 
--(Exclude the categories that match Game, gps, or Home Theater )

-- Game, gps veya Home Theater haricindeki kategorilere ait �r�nleri listeleyin.
--	Sadece 2021 model y�l�na ait �r�nlerin ad� ve fiyat bilgilerini listeleyin.


SELECT *
FROM	product.product
WHERE	model_year = 2021
AND		category_id NOT IN (
							SELECT category_id
							FROM	product.category
							WHERE	category_name IN ('Game', 'gps', 'Home Theater')
								
							)



---

SELECT *
FROM	product.product
WHERE	model_year = 2021
AND		category_id IN (
							SELECT category_id
							FROM	product.category
							WHERE	category_name NOT IN ('Game', 'gps', 'Home Theater')
								
							)


------------


---------CORRELATED SUBQUERIES



--EXISTS / NOT EXISTS

--Write a query that returns a list of States where 'Apple - Pre-Owned iPad 3 - 32GB - White' product is not ordered
-- 'Apple - Pre-Owned iPad 3 - 32GB - White' isimli �r�n�n sipari� verilmedi�i state' leri d�nd�ren bir sorgu yaz�n�z. (m��terilerin state' leri �zerinden)


SELECT	DISTINCT  D.state
FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE	A.product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White'
AND		A.product_id = B.product_id
AND		B.order_id = C.order_id
AND		C.customer_id = D.customer_id




SELECT	DISTINCT STATE
FROM	sale.customer X
WHERE	NOT EXISTS (
					SELECT	1
					FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
					WHERE	A.product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White'
					AND		A.product_id = B.product_id
					AND		B.order_id = C.order_id
					AND		C.customer_id = D.customer_id
					AND		X.state = D.state
					)


---


SELECT	DISTINCT STATE
FROM	sale.customer X
WHERE	EXISTS (
					SELECT	1
					FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
					WHERE	A.product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White'
					AND		A.product_id = B.product_id
					AND		B.order_id = C.order_id
					AND		C.customer_id = D.customer_id

					)


-------////////////


--Write a query that returns stock information of the products in Davi techno Retail store. 
--The BFLO Store hasn't  got any stock of that products.

--Davi techno ma�azas�ndaki �r�nlerin stok bilgilerini d�nd�ren bir sorgu yaz�n. 
--Bu �r�nlerin The BFLO Store ma�azas�nda sto�u bulunmuyor.


SELECT	Y.*
FROM	sale.store X, product.stock Y
WHERE	store_name = 'Davi techno Retail'
AND		X.store_id = Y.store_id
AND		quantity > 0
AND		NOT EXISTS (
					SELECT	B.product_id
					FROM	sale.store A, product.stock B
					WHERE	a.store_id = b.store_id
					AND		A.store_name = 'The BFLO Store'
					AND		quantity > 0
					AND		B.product_id = Y.product_id
					) 


---EXISTS

SELECT	Y.*
FROM	sale.store X, product.stock Y
WHERE	store_name = 'Davi techno Retail'
AND		X.store_id = Y.store_id
AND		quantity > 0
AND		EXISTS (
					SELECT	B.product_id
					FROM	sale.store A, product.stock B
					WHERE	a.store_id = b.store_id
					AND		A.store_name = 'The BFLO Store'
					AND		quantity = 0
					AND		B.product_id = Y.product_id
					) 



----------////////////////////------------

------ CTE's ------

--ORDINARY CTE's

-- Query Time


--List customers who have an order prior to the last order date of a customer named Jerald Berray and are residents of the city of Austin. 

-- Jerald Berray isimli m��terinin son sipari�inden �nce sipari� vermi� 
--ve Austin �ehrinde ikamet eden m��terileri listeleyin.


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



----


WITH T1 AS
(
SELECT	MAX(order_date) last_order_date
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		A.first_name = 'Jerald'
AND		A.last_name = 'Berray'
), T2 AS (
SELECT	d.customer_id, d.first_name, D.last_name, D.city, C.order_date
FROM	T1, sale.orders C, SALE.customer D
WHERE	T1.last_order_date > C.order_date
AND		C.customer_id = D.customer_id
AND		D.city ='Austin'
)
SELECT * 
FROM T2













