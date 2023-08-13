SELECT * FROM housing;

--Modifying the date column

SELECT SaleDate, SaleDateModified 
FROM housing;

UPDATE housing
SET SaleDate = CONVERT(Date,SaleDate);

ALTER TABLE housing
ADD SaleDateModified Date;

UPDATE housing
SET SaleDateModified = CONVERT(Date,SaleDate);

-- Checking for the null in property column and replacing nulls

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM housing a
JOIN housing b
ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID 
WHERE a.PropertyAddress IS NULL;

UPDATE a
SET a.PropertyAddress =ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM housing a
JOIN housing b
ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID 
WHERE a.PropertyAddress IS NULL

SELECT PropertyAddress 
FROM housing
WHERE PropertyAddress IS NULL

-- Splitting the Address column(breaking adrress into city,state)

SELECT * FROM housing;

SELECT PropertyAddress,
    SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) AS Address,
	 SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) AS City
FROM housing;

ALTER TABLE housing
ADD Address NVARCHAR(255), City NVARCHAR(255);

UPDATE housing
SET Address = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1),
    City = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress));

-- replacing Y to Yes and N to No using case statements
	
SELECT DISTINCT(SoldAsVacant), count(*)
FROM housing
GROUP BY SoldAsVacant;
    
SELECT SoldAsVacant, CASE WHEN SoldAsVacant = 'N' THEN 'No' 
	                      WHEN SoldAsVacant ='Y' THEN 'Yes'
						  ELSE SoldAsVacant
						  END
	FROM housing;

UPDATE housing 
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'N' THEN 'No' 
	                    WHEN SoldAsVacant ='Y' THEN 'Yes'
						ELSE SoldAsVacant
						END;

-- Checking for the duplicates and deleting the duplicate rows

 select * from housing;

 select *, ROW_NUMBER() OVER
 (PARTITION BY ParcelID,
               PropertyAddress,
			   SalePrice,
			   SaleDate,
			   LegalReference
			   Order By UniqueID) rownumber
 from housing;

 WITH rowCTE AS(
            SELECT *, ROW_NUMBER() OVER
 (PARTITION BY ParcelID,
               PropertyAddress,
			   SalePrice,
			   SaleDate,
			   LegalReference
			   ORDER BY UniqueID) AS rownumber
 FROM housing)
 SELECT * FROM rowCTE 
 WHERE rownumber > 1

 -- DELETE * FROM rowCTE 
 --WHERE rownumber > 1

 -- Deleting Column
 
 --ALTER TABLE housing
 --DROP COLUMN PropertyAddress, SaleDate;
