/*From the Sales.SalesOrderHeader,Sales.SalesOrderDetail tables write a SQL query to retrieve the orders
with orderqtys greater than 5 or unitpricediscount less than 1000, and totaldues greater than 100.
Return all the columns from the tables.*/

SELECT * FROM Sales.SalesOrderHeader sh
INNER JOIN Sales.SalesOrderDetail sd
ON sh.salesorderid = sd.salesorderid
WHERE sh.totaldue > 100 OR sd.orderqty > 5 AND unitpricediscount < 1000

/* From the Production.Product table write a query in SQL that searches for the word 'red' in the name column
. Return name, and color columns from the table.*/

SELECT Name, Color 
FROM Production.Product
WHERE Name LIKE '%Red%'

/* From the Production.Product table write a query in SQL to find all the products with a price of $80.99.
Return name, and listprice columns from the table.*/

SELECT Name, ListPrice 
FROM Production.Product
WHERE ListPrice = 80.99

/* From the  Production.Product table write a query in SQL to retrieve all the products that contain either 
the phrase Mountain or Road. Return name, and color columns.*/

SELECT Name, Color
FROM Production.Product
WHERE Name LIKE '%Mountain%' OR Name LIKE '%Road%'

/* From the Production.Product table write a query in SQL to search for name which contains both the word 
'Mountain' and the word 'Black'. Return Name and color.*/

SELECT Name, Color
FROM Production.Product
WHERE Name LIKE '%Mountain%Black%'

/* From the Production.Product table write a query in SQL to return all the product names with at least one
word starting with the prefix chain in the Name column.*/

SELECT Name, Color
FROM Production.Product
WHERE Name LIKE 'Chain%'

/* From the Production.Product table write a query in SQL to return all category descriptions containing 
strings with prefixes of either chain or full.*/

SELECT Name
FROM Production.Product
WHERE Name LIKE 'Chain%' OR Name LIKE 'Full%'

/* From the Production.Product table write a SQL query to locate the position of the string "yellow" where 
it appears in the product name.*/

SELECT Name, CHARINDEX('yellow', Name) AS position
FROM Production.Product

/* From the Production.Product table write a query in SQL to concatenate the name, color, and productnumber
columns.*/

SELECT CONCAT(Name,':', Color,':', ProductNumber)
FROM Production.Product


/* From the Production.Product table write a query in SQL to return the five leftmost characters of each 
product name.*/

SELECT LEFT(Name,5) AS leftmost_characters
FROM Production.Product

/* From the Sales.vindividualcustomer table write a query in SQL to select the number of characters and the 
data in FirstName for people located in Australia.*/

SELECT FirstName, LEN(FirstName) AS num_characters
FROM Sales.vindividualcustomer
WHERE CountryRegionName = 'Australia'

/* From the Sales.vstorewithcontacts, Sales.vstorewithaddresses tables write a query in SQL to return the 
number of characters in the column FirstName and the first and last name of contacts located in Australia.*/

SELECT LEN(vst.FirstName) AS num_characters, vst.FirstName, vst.LastName
FROM Sales.vStoreWithContacts AS vst
JOIN Sales.vStoreWithAddresses AS vs
ON vst.BusinessEntityID = vs.BusinessEntityID
WHERE vs.CountryRegionName = 'Australia'

/* From the production.Product table write a query in SQL to select product names that have prices between 
$1000.00 and $1220.00. Return product name as Lower, Upper, and also LowerUpper.*/

SELECT LOWER(Name) AS lowercase, UPPER(Name) AS uppercase, Name AS original
FROM Production.Product
WHERE ListPrice BETWEEN 1000 AND 1220

/* Write a query in SQL to remove the spaces from the beginning of a string.*/

SELECT LTRIM(Name)
FROM Production.Product

/* From the production.Product table write a query in SQL to repeat a 0 character four times in front of a
production line for production line 'T'.*/

SELECT CONCAT('0000',ProductLine) AS New
FROM Production.Product
WHERE ProductLine = 'T'

/* From the Person.Person table write a SQL query to retrieve all contact first names with the characters 
inverted for people whose businessentityid is less than 6.*/

SELECT REVERSE(FirstName)
FROM Person.Person
WHERE BusinessEntityID  < 6

/* From the production.Product table write a query in SQL to return the eight rightmost characters of each
name of the product. Also return name, productnumber column. Sort the result set in ascending order on 
productnumber.*/

SELECT Name,RIGHT(Name,8), ProductNumber
FROM Production.Product
ORDER BY ProductNumber

/* Write a query in SQL to remove the spaces at the end of a string.*/

SELECT RTRIM(Name)
FROM Production.Product

/* From the production.Product table write a query in SQL to fetch the rows for the product name ends with 
the letter 'S' or 'M' or 'L'. Return productnumber and name.*/

SELECT Name
FROM Production.Product
WHERE Name LIKE '%S' OR Name LIKE '%M' OR Name LIKE '%L'

/* From the Person.Person table write a query in SQL to return the names and modified date separated by 
comma.*/

SELECT CONCAT(FirstName, ' ', LastName, ' , ', ModifiedDate ) 
AS test 
FROM Person.Person

/* From the HumanResources.Employee table write a query in SQL to create a new job title called 
"Production Assistant" in place of "Production Supervisor".*/

UPDATE HumanResources.Employee
SET JobTitle = 'Production Assistant'
WHERE JobTitle LIKE 'Production Supervisor%'

SELECT * FROM HumanResources.Employee
WHERE JobTitle = 'Production Assistant'

/* From the Person.Person, HumanResources.Employee table write a SQL query to retrieve all the employees whose
job titles begin with "Sales". Return firstname, middlename, lastname and jobtitle column.*/

SELECT p.firstname, p.middlename, p.lastname, h.jobtitle
FROM person.person p
INNER JOIN humanresources.employee h
ON p.businessentityid=h.businessentityid
WHERE h.jobtitle LIKE 'Sales%'

/* From the Person.Person table write a query in SQL to return the last name of people so that it is in 
uppercase, trimmed, and concatenated with the first name.*/

SELECT CONCAT(UPPER(RTRIM(LastName)) , ', ' , FirstName) AS Name 
FROM person.person  
 
/* From the production.Product table write a query in SQL to retrieve the name of the products. 
Product, that have 33 as the first two digits of listprice.*/

SELECT Name
FROM Production.Product
WHERE ListPrice LIKE '33%'

/* From the  Person.Person, Sales.SalesPerson table write a query in SQL to find those 
persons that have a 2 in the first digit of their SalesYTD. Convert the SalesYTD column to 
an int type, and then to a char(20) type. Return FirstName, LastName, SalesYTD, and 
BusinessEntityID.*/

SELECT p.FirstName, p.LastName, s.SalesYTD, s.BusinessEntityID  
FROM Person.Person AS p   
JOIN Sales.SalesPerson AS s   
ON p.BusinessEntityID = s.BusinessEntityID  
WHERE CAST(CAST(s.SalesYTD AS INT) AS char(20)) LIKE '2%'

/* From the Production.Product table write a query in SQL to convert the Name column to a char(16)
column. Convert those rows if the name starts with 'Long-Sleeve Logo Jersey'. 
Return name of the product and listprice.*/

SELECT CAST(Name AS CHAR(16)) AS Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'Long-Sleeve Logo Jersey%'

/* From the Sales.SalesOrderDetail table write a SQL query to determine the discount price 
for the salesorderid 46672. Calculate only those orders with discounts of more than.02 percent. 
Return productid, UnitPrice, UnitPriceDiscount, and DiscountPrice (UnitPrice*UnitPriceDiscount ).*/

SELECT productid, UnitPrice, UnitPriceDiscount, (UnitPrice*UnitPriceDiscount) AS DiscountPrice
FROM Sales.SalesOrderDetail
WHERE SalesOrderid = 46672 AND UnitPriceDiscount > 0.02

/* From the  HumanResources.Employee table write a query in SQL to calculate the average 
vacation hours, and the sum of sick leave hours, that the vice presidents have used.*/

SELECT AVG(VacationHours) AS AverageVacationHours, SUM(SickLeaveHours) AS TotalSickLeaveHours
FROM HumanResources.Employee
WHERE JobTitle LIKE 'Vice President%'

/* From the Sales.SalesPerson table write a query in SQL to calculate the average bonus 
received and sum of year-to-date sales for each territory. Return territoryid, Average bonus,
and YTD sales.*/

SELECT TerritoryID, AVG(Bonus) AS Average_Bonus, SUM(SalesYTD) AS YTD_Sales
FROM Sales.SalesPerson
GROUP BY TerritoryID

/* From the production.Product table write a query in SQL to return the average list price of 
products. Consider the calculation only on unique values.*/

SELECT AVG(DISTINCT ListPrice) AS AverageListPrice
FROM Production.Product

/* From the HumanResources.Employee table write a query in SQL to return the number of 
different titles that employees can hold.*/

SELECT COUNT(DISTINCT JobTitle) AS NumberofJobTitles
FROM HumanResources.Employee

/* From the HumanResources.Employee table write a query in SQL to find the total number 
of employees.*/

SELECT COUNT(LoginID) AS NUMBEROFEMPLOYEES
FROM HumanResources.Employee

/* From the Sales.SalesPerson table write a query in SQL to find the average bonus for 
the salespersons who achieved the sales quota above 25000. Return number of salespersons, 
and average bonus.*/

SELECT COUNT(BusinessEntityID) AS NumberofSalesPerson, AVG(Bonus) AS AverageBonus
FROM Sales.SalesPerson
WHERE SalesQuota > 25000

/* From the Sales.SalesOrderDetail table write a query in SQL to find the number 
of products that ordered in each of the specified sales orders.*/

SELECT SalesOrderID, COUNT(ProductID)
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID

/* From the production.Product table write a query in SQL to return the total ListPrice 
and StandardCost of products for each color. Products that name starts with 'Mountain' and 
ListPrice is more than zero. Return Color, total list price, total standardcode. 
Sort the result set on color in ascending order.*/

SELECT Color, SUM(ListPrice) AS TotalListPrice, SUM(StandardCost) AS TotalStandardCost
FROM production.Product
WHERE Name LIKE 'Mountain%' AND ListPrice > 0 AND Color IS NOT NULL
GROUP BY Color
ORDER BY Color

/* From the production.Product table write a query in SQL to calculate the sum of the
ListPrice and StandardCost for each color. Return color, sum of ListPrice.*/

SELECT Color, SUM(ListPrice) AS TotalListPrice, SUM(StandardCost) AS TotalStandardCost
FROM production.Product
WHERE Color IS NOT NULL
GROUP BY Color
