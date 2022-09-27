CREATE DATABASE Assignment_5
 

--Factorial Function
--Create a scalar-valued function that returns the factorial of a number you gave it.


CREATE FUNCTION dbo.Factorial ( @Number int )
RETURNS INT
AS
BEGIN
	DECLARE @i  int
		IF @Number <= 1
			SET @i = 1
		ELSE
			SET @i = @Number * dbo.Factorial( @Number - 1 )
	RETURN (@i)
END


SELECT dbo.factorial(5)


