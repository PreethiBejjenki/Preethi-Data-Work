/*  From the HumanResources.Employee table retrieve all rows and columns from the employee table and 
Sort the result set in ascending order on jobtitle. */

SELECT * FROM HumanResources.Employee
ORDER BY JobTitle ASC

/* From the Person.Person table write a query in SQL to retrieve all rows and columns from the person table 
using table aliasing. Sort the output in ascending order on lastname..*/

SELECT * FROM Person.Person 
ORDER BY LastName ASC

/*  From the table write a query to return all rows and a subset of the columns
(FirstName, LastName, businessentityid) from the person table. 
The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname.*/

SELECT FirstName, LastName, BusinessEntityID as Employee_id
FROM Person.Person
ORDER BY LastName ASC

/*  From the production.Product table write a query to return only the rows for product that have 
a sellstartdate that is not NULL and a productline of 'T'. Return productid, productnumber, and name. 
Arranged the output in ascending order on name */

SELECT ProductID, ProductNumber, Name  
FROM Production.Product
WHERE SellStartDate IS NOT NULL AND ProductLine = 'T' 
ORDER BY Name

/*  write a query to return all rows from the salesorderheader table and calculate the percentage of tax 
on the subtotal have decided. Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. 
Arranged the result set in ascending order on subtotal. */

SELECT SalesOrderID, CustomerID, OrderDate, SubTotal,(taxamt*100)/subtotal AS Tax_percent
FROM Sales.SalesOrderHeader
ORDER BY SubTotal ASC;

/* From the HumanResources.Employee write a query in SQL to create a list of unique jobtitles in the employee table. 
Return jobtitle column and arranged the resultset in ascending order.*/

SELECT DISTINCT JobTitle 
FROM HumanResources.Employee
ORDER BY JobTitle ASC

/* From the sales.salesorderheader write a query in SQL to calculate the total freight paid by each customer. 
Return customerid and total freight. Sort the output in ascending order on customerid.*/

SELECT CustomerID, SUM(Freight) as Total_freight
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID ASC

/* From the sales.salesorderheader write a query in SQL to find the average and 
the sum of the subtotal for every customer.Return customerid, average and sum of the subtotal. 
Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order. */

SELECT CustomerID, AVG(SubTotal) AS Average, SUM(SubTotal) AS TOTAL
FROM Sales.SalesOrderHeader
GROUP BY CustomerID,SalesPersonID
ORDER BY CustomerID desc

/* From the production.productinventory write a query in SQL to retrieve total quantity of each productid 
which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500. 
Return productid and sum of the quantity. Sort the results according to the productid in ascending order. */

SELECT ProductID, SUM(Quantity) AS totalquantity
FROM Production.ProductInventory
WHERE Shelf = 'A' OR Shelf = 'C' OR Shelf = 'H' 
GROUP BY ProductID
HAVING SUM(Quantity)>500
ORDER BY ProductID ASC

/* From the production.productinventory write a query in SQL to find the total quentity for a group of 
locationid multiplied by 10. */

SELECT  SUM(Quantity) AS Total_Quantity
FROM Production.ProductInventory
GROUP BY (LocationID*10)

/* From the Person.PersonPhone and Person.Person tables write a query in SQL to find the persons whose 
last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName, and PhoneNumber. 
Sort the result on lastname and firstname. */

SELECT p.BusinessEntityID,p.FirstName,p.LastName,pp.PhoneNumber
FROM Person.Person AS p
JOIN Person.PersonPhone AS pp
ON p.BusinessEntityID=pp.BusinessEntityID
WHERE p.LastName LIKE 'L%'
ORDER BY p.LastName,p.FirstName

/* From the production.productinventory table write a query in SQL to find the total quantity for 
each locationid and calculate the grand-total for all locations. Return locationid and total quantity. 
Group the results on locationid. */

SELECT LocationID, SUM(Quantity) AS totalquantity
FROM Production.ProductInventory
GROUP BY ROLLUP(LocationID)

/* From the Person.BusinessEntityAddress, Person.Address table write a query in SQL to retrieve the number of employees 
for each City. Return city and number of employees. Sort the result in ascending order on city. */

SELECT A.City, COUNT(B.AddressID)
FROM Person.BusinessEntityAddress B
Join Person.Address A on B.AddressID = A.AddressID
GROUP BY A.City
ORDER BY A.City ASC

/* From the Sales.SalesOrderHeader table write a query in SQL to retrieve the total sales for each year. 
Return the year part of order date and total due amount. 
Sort the result in ascending order on year part of order date. */

SELECT YEAR(OrderDate) as OrderYear,SUM(TotalDue) AS TotalAmount
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate) ASC

/* From the Sales.SalesOrderHeader table write a query in SQL to retrieve the total sales for each year. 
Filter the result set for those orders where order year is on or before 2016. 
Return the year part of orderdate and total due amount. 
Sort the result in ascending order on year part of order date. */

SELECT YEAR(OrderDate) as OrderYear,SUM(TotalDue) AS TotalAmount
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
HAVING YEAR(OrderDate) <= 2016
ORDER BY YEAR(OrderDate) ASC

/* From the Person.ContactType table write a query in SQL to find the contacts who are designated as a
manager in various departments. Returns ContactTypeID, name. Sort the result set in descending order. */

SElECT ContactTypeID, Name
FROM Person.ContactType
WHERE Name LIKE '%Manager%'
ORDER BY ContactTypeID DESC

/* From the Person.BusinessEntityContact, Person.ContactType and Person.Person tables write a query in SQL
to make a list of contacts who are designated as 'Purchasing Manager'. 
Return BusinessEntityID, LastName, and FirstName columns. 
Sort the result set in ascending order of LastName, and FirstName. */

SELECT b.BusinessEntityID, p.LastName,p.FirstName
FROM Person.BusinessEntityContact b
INNER JOIN Person.ContactType c
ON c.ContactTypeID = b.ContactTypeID
INNER JOIN Person.Person p
ON b.BusinessEntityID=p.BusinessEntityID
WHERE c.Name = 'Purchasing Manager'
ORDER BY LastName, FirstName

/* From the Sales.SalesPerson, Person.Person,  Person.Address tables write a query in SQL to 
retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero.
Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. 
Sort the salesytd of each postalcode group in descending order. Sorts the postalcode in ascending order. */

SELECT ROW_NUMBER() OVER (PARTITION BY PostalCode ORDER BY SalesYTD DESC) AS "Row Number",
pp.LastName, sp.SalesYTD, a.PostalCode
FROM Sales.SalesPerson AS sp
    INNER JOIN Person.Person AS pp
        ON sp.BusinessEntityID = pp.BusinessEntityID
    INNER JOIN Person.Address AS a
        ON a.AddressID = pp.BusinessEntityID
WHERE TerritoryID IS NOT NULL
    AND SalesYTD <> 0
ORDER BY PostalCode

/* From the Person.BusinessEntityContact, Person.ContactType table write a query in SQL to count
the number of contacts for combination of each type and name. Filter the output for those who have 100 or 
more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. 
Sort the result set in descending order on number of contacts. */

SELECT c.ContactTypeID,c.Name,COUNT(c.ContactTypeID) AS ContactsNum
FROM Person.BusinessEntityContact AS bc
INNER JOIN Person.ContactType AS c
ON c.ContactTypeID = bc.ContactTypeID
GROUP BY c.ContactTypeID,c.Name
HAVING count(c.ContactTypeID) > 100
ORDER BY COUNT(c.ContactTypeID) DESC

/* From the HumanResources.EmployeePayHistory, Person.Person table write a query in SQL to retrieve the RateChangeDate, 
full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. 
In the output the RateChangeDate should appears in date format. 
Sort the output in ascending order on NameInFull. */

SELECT CAST(hr.RateChangeDate as DATE ) AS ExtractedDate
     , CONCAT(LastName, ' ', FirstName, ' ', MiddleName) AS FullName, (40 * hr.Rate) AS WeekSalary
FROM Person.Person AS p
INNER JOIN HumanResources.EmployeePayHistory AS hr
ON hr.BusinessEntityID = p.BusinessEntityID      
ORDER BY FullName ASC

/* From the Person.Person,HumanResources.EmployeePayHistory tables write a query in SQL to calculate and 
display the latest weekly salary of each employee. 
Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week)
of employees Sort the output in ascending order on NameInFull. */

SELECT hr.RateChangeDate, CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS FullName
	 , (40 * hr.Rate) AS WeekSalary
FROM Person.Person AS p
INNER JOIN HumanResources.EmployeePayHistory AS hr
ON hr.BusinessEntityID = p.BusinessEntityID      
ORDER BY FullName ASC

/* From the Sales.SalesOrderDetail table write a query in SQL to retrieve the total cost of each salesorderID that exceeds
100000. Return SalesOrderID, total cost.*/

SELECT SalesOrderID, sum(LineTotal) as totalcost
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING sum(LineTotal) > 100000

/* From the Production.Product write a query in SQL to retrieve products whose names start with 'Lock Washer'.
Return product ID, and name and order the result set in ascending order on product ID column.*/

SELECT ProductID,Name
FROM Production.Product
WHERE Name LIKE 'Lock Washer%'
ORDER BY ProductID ASC

/* Write a query in SQL to fetch rows from Production.Product table and order the result set on an
column listprice. Return product ID, name, and color of the product.*/

SELECT ProductID, Name, Color
FROM Production.Product
ORDER BY ListPrice 

/* From the HumanResources.Employee write a query in SQL to retrieve records of employees. 
Order the output on year (default ascending order) of hiredate. Return BusinessEntityID, JobTitle, 
and HireDate.*/

SELECT BusinessEntityID, JobTitle, HireDate
FROM HumanResources.Employee
ORDER BY YEAR(HireDate)

/* From the Person.Person write a query in SQL to retrieve those persons whose last name begins with letter 
'R'. Return lastname, and firstname and display the result in ascending order on firstname and descending order
on lastname columns.*/

SELECT LastName, FirstName
FROM Person.Person
WHERE LastName LIKE 'R%'
ORDER BY FirstName ASC, LastName DESC

/* From the Sales.vSalesPerson write a query in SQL to set the result in order by the column TerritoryName 
when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.*/

SELECT LastName, TerritoryName, CountryRegionName  
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL  
ORDER BY 
    CASE WHEN CountryRegionName = 'United States' THEN TerritoryName ELSE CountryRegionName END

/* From the HumanResources.Department write a query in SQL to skip the first 10 rows from the sorted result 
set and return all remaining rows.*/

SELECT *
FROM HumanResources.Department
ORDER BY DepartmentID
OFFSET 10 ROWS

/* From the HumanResources.Department table write a query in SQL to skip the first 5 rows and return the 
next 5 rows from the sorted result set.*/

SELECT *
FROM HumanResources.Department
ORDER BY DepartmentID
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY

/* From the Production.Product table write a query in SQL to list all the products that are Red or Blue 
in color. Return name, color and listprice.Sorts this result by the column listprice.*/

SELECT Name, Color, ListPrice
FROM Production.Product
WHERE Color IN('Red','Blue')
ORDER BY ListPrice

/* From the Sales.SalesOrderDetail, Production.Product table write a SQL query to retrieve the product name 
and salesorderid. Both ordered and unordered productsare included in the result set.*/

SELECT s.SalesOrderID, p.Name
FROM Sales.SalesOrderDetail s
LEFT JOIN Production.Product p
ON s.ProductID = p.ProductID

/* From the Production.Product, Sales.SalesOrderDetail tables write a SQL query to get all product names and sales order IDs. 
Order the result set on product name column.*/

SELECT s.SalesOrderID, p.Name
FROM Sales.SalesOrderDetail s
INNER JOIN Production.Product p
ON s.ProductID = p.ProductID
ORDER BY p.Name

/* From the Sales.SalesTerritory, Sales.SalesPerson tables write a SQL query to retrieve the territory name and BusinessEntityID. 
The result set includes all salespeople, regardless of whether or not they are assigned a territory.*/

SELECT t.Name AS Territory, p.BusinessEntityID  
FROM Sales.SalesTerritory AS t   
RIGHT JOIN Sales.SalesPerson AS p  
ON t.TerritoryID = p.TerritoryID 

/* Write a query in SQL to find the employee's full name (firstname and lastname) and 
city from the Person.Person, HumanResources.Employee, Person.Address, Person.BusinessEntityAddress tables. 
Order the result set on lastname then by firstname.*/

SELECT concat(p.FirstName,' ', p.LastName) AS Name, a.City  
FROM Person.Person AS p  
INNER JOIN Person.BusinessEntityAddress b 
ON p.BusinessEntityID = b.BusinessEntityID   
INNER JOIN  Person.Address AS a
ON a.AddressID = b.AddressID  
ORDER BY p.LastName, p.FirstName

/* Write a SQL query to return the businessentityid,firstname and lastname columns of all persons in the 
person table (derived table) with persontype is 'IN' and the last name is 'Adams'. Sort the result set in 
ascending order on firstname. A SELECT statement after the FROM clause is a derived table.*/

SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE LastName = 'Adams' AND PersonType = 'IN'
ORDER BY FirstName ASC

/* Create a SQL query to retrieve individuals from the Person.Person table with a businessentityid inside 
1500, a lastname starting with 'Al', and a firstname starting with 'M'.*/

SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE LastName LIKE 'Al%' AND FirstName LIKE 'M%' AND BusinessEntityID < 1500

/* Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 
'AWC Logo Cap' using a derived table with multiple values.Production.Product*/

SELECT ProductID, Name, Color
FROM Production.Product
WHERE Name IN ('Blade', 'Crown Race','AWC Logo Cap')

/* Write a SQL query on the Production.ProductPhoto table to retrieve records with the characters green_ in 
the LargePhotoFileName field. The following table's columns must all be returned.*/

SELECT *
FROM Production.ProductPhoto
WHERE LargePhotoFileName LIKE '%green_%'

/* Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) 
and in a city whose name starts with Pa. Return Addressline1, Addressline2, city, postalcode, countryregioncode
columns.Person.Address, Person.StateProvince*/

SELECT a.AddressLine1, a.AddressLine2, a.City, a.PostalCode, s.CountryRegionCode
FROM Person.Address AS a
INNER JOIN Person.StateProvince AS s
ON a.StateProvinceID = s.StateProvinceID
WHERE s.CountryRegionCode NOT IN('US') AND a.City LIKE 'Pa%'

/* From the HumanResources.Employee table write a query in SQL to fetch first twenty rows. Return jobtitle,
hiredate. Order the result set on hiredate column in descending order.*/

SELECT TOP 20 JobTitle,HireDate
FROM HumanResources.Employee
ORDER BY HireDate DESC




