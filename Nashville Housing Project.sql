
--------------------------------------------------------------------------------------------------------------------------------

--Cleaning data in sql

--------------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------------

--Standardize data format

SELECT SaleDateConverted, CONVERT(date,SaleDate)
FROM PortfolioProject.dbo.NashvilleHousing

--UPDATE PortfolioProject.dbo.NashvilleHousing
--SET SaleDate = CONVERT(date,SaleDate)            --DONT WORK

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
add SaleDateConverted date;

UPDATE PortfolioProject.dbo.NashvilleHousing
SET SaleDateConverted = CONVERT(date,SaleDate)

--------------------------------------------------------------------------------------------------------------------------------

--Populate Property Adress data

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing
--where PropertyAddress IS NULL
ORDER BY ParcelID

SELECT a.[UniqueID ], a.ParcelID, a.PropertyAddress, b.[UniqueID ], b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ]!= b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a 
SET a.PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ]!= b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

---------------------------------------------------------------------------------------------------------------------------------

--Breaking Out Adress into Individual Columns (Address, City, State)

SELECT PropertyAddress
FROM PortfolioProject.dbo.NashvilleHousing




SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Adress,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as City
FROM PortfolioProject.dbo.NashvilleHousing

AlTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD PropertySplitAdress nvarchar(255);

AlTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD PropertySplitCity nvarchar(255);


UPDATE PortfolioProject.dbo.NashvilleHousing
SET PropertySplitAdress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)


UPDATE PortfolioProject.dbo.NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))


SELECT *
FROM PortfolioProject.dbo.NashvilleHousing






SELECT OwnerAddress
FROM PortfolioProject.dbo.NashvilleHousing

SELECT
PARSENAME(REPLACE(OwnerAddress,',','.'),3) as OwnerAddress, 
PARSENAME(REPLACE(OwnerAddress,',','.'),2) as OwnerCity,
PARSENAME(REPLACE(OwnerAddress,',','.'),1) as OwnerState
FROM PortfolioProject.dbo.NashvilleHousing

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
add OwnerSplitAddress nvarchar(255)

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
add OwnerSplitCity nvarchar(255)

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
add OwnerSplitState nvarchar(255)

UPDATE PortfolioProject.dbo.NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

UPDATE PortfolioProject.dbo.NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

UPDATE PortfolioProject.dbo.NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)


SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

---------------------------------------------------------------------------------------------------------------------------------

--Change Y and N to Yes and No in  'SoldAsVacant' field

SELECT SoldAsVacant, COUNT(SoldAsVacant) as CountAnswers
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY CountAnswers


SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END as SoldAsVacantConverted
FROM PortfolioProject.dbo.NashvilleHousing

UPDATE PortfolioProject.dbo.NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END 

---------------------------------------------------------------------------------------------------------------------------------

--Remove Duplicates 

WITH RowNumCTE AS (
SELECT *, 
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY 
					UniqueID 
					) AS Row_Num
FROM PortfolioProject.dbo.NashvilleHousing
)


DELETE
FROM RowNumCTE
WHERE Row_Num > 1

---------------------------------------------------------------------------------------------------------------------------------

--DELETE Unused Columns

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN PropertyAddress, SaleDate, OwnerAddress, TaxDistrict

---------------------------------------------------------------------------------------------------------------------------------