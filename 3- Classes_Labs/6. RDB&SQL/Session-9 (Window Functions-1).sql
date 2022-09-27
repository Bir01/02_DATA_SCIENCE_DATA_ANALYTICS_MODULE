

---
--Write a query that returns the total stock amount of each product in the stock table.
--�r�nlerin stock say�lar�n� bulunuz


SELECT	product_id, SUM(quantity) total_quantity
FROM	product.stock
GROUP BY product_id
ORDER BY 1


SELECT	product_id
FROM	product.stock
GROUP BY product_id



---WINDOW FUNCTION


SELECT	product_id, 
		SUM(quantity) OVER (PARTITION BY product_id) product_quantity
FROM	product.stock
ORDER BY product_id




SELECT	DISTINCT product_id, 
		SUM(quantity) OVER (PARTITION BY product_id) product_quantity
FROM	product.stock
ORDER BY product_id




SELECT	*, 
		SUM(quantity) OVER (PARTITION BY product_id) product_quantity,
		SUM (quantity) OVER () total_quantity
FROM	product.stock
ORDER BY product_id



SELECT *
FROM	product.stock
ORDER BY product_id



-- Write a query that returns average product prices of brands. 

-- Markalara g�re ortalama �r�n fiyatlar�n� hem Group By hem de Window Functions ile hesaplay�n�z


SELECT	brand_id, AVG(list_price)
FROM	product.product
GROUP BY brand_id




SELECT	DISTINCT brand_id, AVG(list_price) OVER(PARTITION BY brand_id)
FROM	product.product




----WINDOW FRAMES

-- Window Frames

-- Windows frame i anlamak i�in birka� �rnek:
-- Herbir sat�rda i�lem yap�lacak olan frame in b�y�kl���n� (sat�r say�s�n�) tespit edip window frame in nas�l olu�tu�unu a�a��daki sorgu sonucuna g�re konu�al�m.


SELECT	category_id, product_id,
		COUNT(*) OVER() NOTHING,
		COUNT(*) OVER(PARTITION BY category_id) countofprod_by_cat,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id) countofprod_by_cat_2,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) prev_with_current,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) current_with_following,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) whole_rows,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) specified_columns_1,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 2 PRECEDING AND 3 FOLLOWING) specified_columns_2
FROM	product.product
ORDER BY category_id, product_id

;







