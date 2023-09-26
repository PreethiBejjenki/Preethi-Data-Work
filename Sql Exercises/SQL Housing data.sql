
-- Data Cleaning exercise

SELECT * FROM housing;

--Modifying the date column

SELECT SaleDate, SaleDateModified 
FROM housing;

ALTER TABLE housing
ADD SaleDateModified Date;

UPDATE housing
SET SaleDateModified = CONVERT(Date,SaleDate);

--Checking for NULLS using a calculated field
SELECT PropertyAddress 
FROM housing
WHERE PropertyAddress IS NULL

Select * from 
(select ParcelID, PropertyAddress,
CASE WHEN  PropertyAddress IS NULL THEN 'Y' ELSE 'N' END AS AddressNULLflag
FROM housing) A
where A.AddressNULLflag = 'Y'


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
    
SELECT  distinct SoldAsVacant, CASE WHEN SoldAsVacant = 'N' THEN 'No' 
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
 WHERE rownumber = 1


 -- Deleting Column
 
 --ALTER TABLE housing
 --DROP COLUMN PropertyAddress, SaleDate;
