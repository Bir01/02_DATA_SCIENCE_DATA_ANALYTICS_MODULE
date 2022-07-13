----- PRODUCT SCHEMA -----
SELECT *
FROM product.stock

SELECT *
FROM product.product

SELECT *
FROM product.category

SELECT *
FROM product.brand

----- SALE SCHEMA -----

SELECT *
FROM sale.customer

SELECT *
FROM sale.order_item

SELECT *
FROM sale.orders

SELECT *
FROM sale.staff

SELECT *
FROM sale.store

--- SELECT DISTINCT ---

SELECT first_name
FROM sale.customer;

SELECT DISTINCT (first_name)
FROM sale.customer;

--- COUNT ---

SELECT COUNT(first_name)
FROM sale.customer;

SELECT COUNT (DISTINCT  first_name)
FROM sale.customer;

SELECT COUNT(*) --> LEN
FROM sale.customer;

--- WHERE ---

SELECT TOP 5 * FROM sale.customer

SELECT city
FROM sale.customer
WHERE city = 'Allen'

SELECT COUNT(city) AS Count
FROM sale.customer
WHERE city = 'Allen'

SELECT city
FROM sale.customer
WHERE city LIKE 'A%'

SELECT DISTINCT city
FROM sale.customer
WHERE city LIKE 'A%'

SELECT DISTINCT city
FROM sale.customer
WHERE city LIKE 'Al___'


SELECT TOP 5 * FROM sale.order_item

SELECT list_price
FROM sale.order_item
WHERE list_price > 100 

SELECT COUNT(list_price) as Count
FROM sale.order_item
WHERE list_price > 100 


--- WHERE & LIMIT ---
SELECT first_name
FROM sale.customer
WHERE first_name LIKE 'A%'
LIMIT 15

SELECT TOP 15 first_name
FROM sale.customer
WHERE first_name LIKE 'A%'


--- ORDER BY ---
SELECT TOP 5 * FROM proDuct.BRaNd

SELECT TOP 6 brand_name
FROM product.brand
ORDER BY brand_name ASC;

--- MIN & MAX ---
SELECT TOP 5 * FROM sale.order_item

SELECT MIN(list_price) AS min_list_price
FROM sale.order_item

SELECT MAX(list_price) AS max_list_price
FROM sale.order_item

--- SUM & AVG ---
SELECT TOP 5 * FROM sale.order_item

SELECT SUM(list_price) AS sum_list_price
FROM sale.order_item

SELECT AVG(list_price) AS avg_list_price
FROM sale.order_item
