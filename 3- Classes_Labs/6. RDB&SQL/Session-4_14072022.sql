----- 14.07.2022 -----

----- FUNCTIONS ------

----- Data Types -----

CREATE TABLE t_date_time (
	A_time time,
	A_date date,
	A_smalldatetime smalldatetime,
	A_datetime datetime,
	A_datetime2 datetime2,
	A_datetimeoffset datetimeoffset
	)

SELECT * FROM t_date_time

SELECT GETDATE()   -- Anlýk zamaný döndürüyor.

INSERT t_date_time
VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())

SELECT * FROM t_date_time

INSERT t_date_time
VALUES ('12:52:10','2022-07-14','2022-07-14','2022-07-14','2022-07-14','2022-07-14')

SELECT * FROM t_date_time



--- Return Date or Time Parts ---


SELECT GETDATE()
SELECT DAY(GETDATE())
SELECT MONTH(GETDATE())
SELECT YEAR(GETDATE())

SELECT GETDATE(),
	DAY(GETDATE()) AS DAY,
	MONTH(GETDATE()) AS MONTH,
	YEAR(GETDATE()) AS YEAR

SELECT DATENAME(DW, GETDATE())
SELECT DATENAME(DAYOFYEAR, GETDATE())
SELECT DATENAME(YEAR, GETDATE())
SELECT DATENAME(MONTH, GETDATE())
SELECT DATENAME(DAY, GETDATE())
SELECT DATENAME(WEEKDAY, GETDATE())
SELECT DATENAME(MINUTE, GETDATE())

SELECT DATENAME(DW, GETDATE()),
	DATENAME(DAYOFYEAR, GETDATE()),
	DATENAME(YEAR, GETDATE()),
	DATENAME(MONTH, GETDATE()),
	DATENAME(DAY, GETDATE()),
	DATENAME(WEEKDAY, GETDATE()),
	DATENAME(MINUTE, GETDATE())

SELECT DATENAME(DW, '2022-07-10 15:00:38.047'),
	DATENAME(DAYOFYEAR, '2022-07-10 15:00:38.047'),
	DATENAME(YEAR, '2022-07-10 15:00:38.047'),
	DATENAME(MONTH, '2022-07-10 15:00:38.047'),
	DATENAME(DAY, '2022-07-10 15:00:38.047'),
	DATENAME(WEEKDAY, '2022-07-10 15:00:38.047'),
	DATENAME(MINUTE, '2022-07-10 15:00:38.047')



--- DATEDIFF ---

SELECT DATEDIFF(DAY, '1974-10-13', GETDATE()) -- ben
SELECT DATEDIFF(DAY, '1980-02-28', GETDATE()) -- aida
SELECT DATEDIFF(DAY, '2009-04-15', GETDATE()) -- azra
SELECT DATEDIFF(DAY, '2014-10-06', GETDATE()) -- kerem
SELECT DATEDIFF(DAY, '1983-04-03', GETDATE()) -- meryem
SELECT DATEDIFF(DAY, '2021-07-14', GETDATE())
SELECT DATEDIFF(SECOND, '2021-07-14', GETDATE())

SELECT *
FROM t_date_time

SELECT *, DATEDIFF(SECOND, A_smalldatetime, GETDATE())
FROM t_date_time

SELECT DATEDIFF(DAY, '2022-01-01', '2022-07-14')


--- DATEADD ---

SELECT DATEADD(MONTH, 5, GETDATE()),
		DATEADD(DAY, -5, GETDATE())

--- EOMONTH ---

SELECT EOMONTH(GETDATE())
SELECT EOMONTH(GETDATE(), 2)

SELECT EOMONTH('2019-02-05')

--- ISDATE ---

SELECT	ISDATE('2022-07-14'),
		ISDATE('2022/07/14'),
		ISDATE('14/07/2022'),
		ISDATE('14072022'),
		ISDATE('20220714'),
		ISDATE('18000101')


--- QUESTION: Write a query returns orders that are shipped more than 2 days after the order date.

SELECT * FROM sale.orders

SELECT *, DATEDIFF(DAY, order_date, shipped_date) AS shipping_time
FROM sale.orders

SELECT *, DATEDIFF(DAY, order_date, shipped_date) AS shipping_time --> 3 order of execution
FROM sale.orders --> 1 order of execution
WHERE DATEDIFF(DAY, order_date, shipped_date) > 2 --> 2 order of execution




---------- ////////////// ----------

--- STRING FUNCTIONS -----
--- DATA TYPES -----

SELECT CAST('reinvent yourself' AS CHAR(10))
SELECT CAST('reinvent yourself' AS CHAR(17))
SELECT CAST('reinvent yourself' AS CHAR(20))

SELECT CAST('86963254896' AS CHAR(11))

SELECT CAST('reinvent yourself' AS CHAR(220))


--- LEN ---

SELECT  LEN('CHARACTER'),
		LEN('CHARACTERS'),
		LEN('CHARACTERS '),
		LEN(' CHARACTERS')


--- CHARINDEX ---

SELECT  CHARINDEX('H', 'CHARACTER'),
		CHARINDEX('C', 'CHARACTER'),
		CHARINDEX('C', 'CHARACTER', 3),  --> 3 starting position
		CHARINDEX('c', 'CHARACTER'), --> not case-sensitive
		CHARINDEX('cte', 'CHARACTER') --> can searc a path



--- PATINDEX ---

SELECT  PATINDEX('CH', 'CHARACTER'),
		PATINDEX('CH%', 'CHARACTER'),
		PATINDEX('CH_', 'CHARACTER'),
		PATINDEX('CH_______', 'CHARACTER'),
		PATINDEX('TE_', 'CHARACTER'),
		PATINDEX('%TE_', 'CHARACTER')


--- LEFT & RIGHT ---

SELECT LEFT('CHARACTER', 3)
SELECT RIGHT('CHARACTER', 3)

--- SUBSTRING ---

SELECT SUBSTRING('CHARACTER', 3, 4),
       SUBSTRING('CHARACTER', 0, 4),
	   SUBSTRING('CHARACTER', -1, 4)


-- fonk 2 ye ayrýlýr
-- ... func. tek bir deðer döndürür.
-- table valued func. ise bir tablo döndürür. bu tarz fonk select te deðil from da çaðýrabiliyoruz



--- LOWER & UPPER ---

SELECT LOWER('CHARACTER')
SELECT UPPER('character')

--- STRING_SPLIT ---

SELECT *
FROM STRING_SPLIT('OWEN, SAM, BÝRGÜL, PAKÝZE', ',')


--- TRIM & LTRIM & RTRIM ---

SELECT TRIM('   CHARACTER   ')
SELECT TRIM('!' FROM '!CHARACTER')
SELECT LTRIM('   CHARACTER   ')
SELECT RTRIM('   CHARACTER   ')


--- QUESTION : character kelimesinin ilk harfi büyük diðerleri küçük olsun.

SELECT UPPER(SUBSTRING('character',1,1)) + SUBSTRING('character',2,10)

SELECT TRIM('C' FROM 'character'),'C' + 'haracter'

SELECT 'C' + 'haracter'

SELECT UPPER(LEFT('character',1)) + SUBSTRING('character',2,10)

SELECT UPPER(LEFT('character',1)) + SUBSTRING('character',2,LEN('character'))


SELECT UPPER(LEFT(first_name,1)) + SUBSTRING(first_name,2,LEN(first_name))
FROM sale.customer



--- REPLACE ---

SELECT REPLACE('CHARACTER STRING', ' ', '/'),
       REPLACE('CHARACTER STRING', ' ', '')



--- STR ---

SELECT STR(525660) --> STR aldýðý numeric ifadeyi default olarak 10 karakter olarak algýlar
SELECT STR(525660, 6)
SELECT STR(525.879, 6)
SELECT STR(525.879, 3)
SELECT STR(525.879, 10)
SELECT STR(525.879, 7, 2)
SELECT STR(525.879, 7, 3)
SELECT STR(525.879, 7, 4)
SELECT STR(525.879, 7, 1)
SELECT STR(525.879, 7, 0)
SELECT STR(525.879, 7)

--- CONVERT ---

SELECT CONVERT (VARCHAR, GETDATE())
SELECT CONVERT (VARCHAR, GETDATE(), 6) --> BÝR STÝL DEÐÝÞÝKLÝÐÝ ÝÇÝN ÖNCELÝKLE VARCHAR A DÖNÜÞTÜRMEK GEREKLÝ
SELECT CONVERT (DATE, '14 Jul 22', 6)


--- CAST ---

SELECT CAST(12345 AS VARCHAR)
SELECT 12345 + 'SAM'
SELECT CAST(12345 AS VARCHAR) + 'SAM'


--- ROUND ---

SELECT ROUND (213456.569,0)
SELECT ROUND (213456.569,1)
SELECT ROUND (213456.569,2)
SELECT ROUND (213456.569,3)
SELECT ROUND (213456.569,-1)
SELECT ROUND (213456.569,-2)
SELECT ROUND (213456.569,-3)
SELECT ROUND (213456.569,-4)
SELECT ROUND (213456.569,-5)
SELECT ROUND (213456.569, 2, 1) --> OPTÝONAL ARGUMENT MAY BE 0 OR 1. DEFAULT 0
SELECT ROUND (213456.569, 2, 0)


--- ISNULL ---
-- ýsnull fonksiyonu null deðerlerin yerine istediðimiz farklý bir deðer yazdýrmak için kullanýlýyor
-- isnull 2 deðer alýr

SELECT ISNULL('Ahmet', 'Veli')

SELECT ISNULL(NULL, 'Veli')

SELECT ISNULL('Ahmet', NULL)

SELECT ISNULL(phone, 'no phone')
FROM sale.customer


--- COALESCE ---
-- null olmayan ilk deðeri yazdýrmak için kullanýlýr

SELECT COALESCE(NULL, NULL, 'ALÝ', 'VELÝ', NULL)		


--- NULLIF ---

SELECT NULLIF(0,0)

SELECT phone, NULLIF(phone, CAST(0 AS VARCHAR))
FROM sale.customer

SELECT phone, NULLIF(phone, '+1-90 - 740 - 7404')
FROM sale.customer



--- ISNUMERIC ---

SELECT ISNUMERIC(0)

SELECT ISNUMERIC('5646')

SELECT ISNUMERIC('OWEN')

SELECT ISNUMERIC('5646M')

SELECT ISNUMERIC('5646/')



--- QUESTION: How many customers have yahoo mail?

SELECT * FROM sale.customer

SELECT COUNT(*) AS Count
FROM sale.customer 
WHERE email LIKE '%yahoo%'

SELECT COUNT(DISTINCT customer_id) AS Count
FROM sale.customer 
WHERE email LIKE '%yahoo%'

SELECT COUNT(first_name) AS Count
FROM sale.customer 
WHERE email LIKE '%yahoo%'

SELECT COUNT(DISTINCT first_name) AS Count
FROM sale.customer 
WHERE email LIKE '%yahoo%'


--- QUESTION: Write a query that returns the characters before the @ character in the email column?

SELECT	email, SUBSTRING (email, 1, CHARINDEX('@', email)-1) AS email
FROM	sale.customer

SELECT	email, SUBSTRING (email, 1, CHARINDEX('@', email)-1) AS 'substring'
FROM	sale.customer

SELECT  email, LEFT(  [email] ,CHARINDEX('@', [email] )-1) 
FROM [sale].[customer]

SELECT email, SUBSTRING(email,1,CHARINDEX('@',email)-1)
FROM sale.customer

SELECT email, LEFT([email] ,CHARINDEX('@', [email] )-1)  AS Chars 
FROM [sale].[customer]




-- QUESTION: Add a new column to the customers table that contains the customers' contact information. If the phone is available, the phone information 
-- will be printed, if not, the email information will be printed.





-- QUESTION : Split the mail addresses into 2 parts from "@" , and place them in seperate columns.





-- QUESTION : The street column has some string characters (5C, 43E, 234F, etc) that are mistakenly added to the end of the numeric characters in the first part 
-- of the street records. Remove this typos in this column.


