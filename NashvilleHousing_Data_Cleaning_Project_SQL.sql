/*
Cleaning Data in SQL Queries
*/


--Select *
--From project.dbo.NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format


--ALTER TABLE NashvilleHousing
--ALTER COLUMN [SaleDate] date

--Select SaleDate
--From project.dbo.NashvilleHousing


 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

--Select *
--From project.dbo.NashvilleHousing
----Where  PropertyAddress is null
--Order by ParcelID


--Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL (a.PropertyAddress, b.PropertyAddress)
--From project.dbo.NashvilleHousing a
--JOIN project.dbo.NashvilleHousing b
--     on a.ParcelID = b.ParcelID
--	 AND a.[UniqueID] <> b.[UniqueID]
--Where a.PropertyAddress is null

--Update a
--SET PropertyAddress = ISNULL (a.PropertyAddress, b.PropertyAddress)
--From project.dbo.NashvilleHousing a
--JOIN project.dbo.NashvilleHousing b
--     on a.ParcelID = b.ParcelID
--	 AND a.[UniqueID] <> b.[UniqueID]
--Where a.PropertyAddress is null




--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)



--Select PropertyAddress
--From project.dbo.NashvilleHousing
----Where  PropertyAddress is null
----Order by ParcelID

--Select
--SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
--, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
--From project.dbo.NashvilleHousing



--ALTER TABLE NashvilleHousing
--Add PropertySplitAddress Nvarchar(255);




--Update NashvilleHousing

--SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )




--ALTER TABLE NashvilleHousing
--Add PropertySplitCity Nvarchar(255);

--Update NashvilleHousing
--SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))


--Select PropertySplitCity, PropertySplitAddress
--From project.dbo.NashvilleHousing


--Another method of parsing address

--Select OwnerAddress
--From project.dbo.NashvilleHousing



--Select 
--PARSENAME(REPLACE(OwnerAddress, ',', '.'),3),   --Parsename is only useful with period
--PARSENAME(REPLACE(OwnerAddress, ',', '.'),2),
--PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
--From project.dbo.NashvilleHousing



--ALTER TABLE NashvilleHousing
--Add OwnerSplitAddress Nvarchar(255);



--Update NashvilleHousing

--SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)


--ALTER TABLE NashvilleHousing
--Add OwnerSplitCity Nvarchar(255);

--Update NashvilleHousing
--SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

--ALTER TABLE NashvilleHousing
--Add OwnerSplitState Nvarchar(255);

--Update NashvilleHousing
--SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)


--Select *
--From project.dbo.NashvilleHousing





--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field

--The SELECT DISTINCT statement is used to return only distinct (different) values.

--Select Distinct (SoldAsVacant), Count(SoldAsVacant)   
--From project.dbo.NashvilleHousing
--Group by SoldAsVacant
--Order by 2


--Select SoldAsVacant
--, CASE When SoldAsVacant = 'Y' THEN 'Yes'
--       When SoldAsVacant = 'N' THEN 'No'
--	   ELSE SoldAsVacant
--	   END
--From project.dbo.NashvilleHousing



--Update NashvilleHousing
--SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
--       When SoldAsVacant = 'N' THEN 'No'
--	   ELSE SoldAsVacant
--	   END





-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates




--WITH RowNumCTE AS(
--Select *,
--    ROW_NUMBER() OVER (
--	PARTITION BY ParcelID, 
--	             PropertyAddress,
--				 SalePrice,
--				 SaleDate,
--				 LegalReference
--				 ORDER BY 
--				    UniqueID
--					) row_num


--From project.dbo.NashvilleHousing
----order by ParcelID
--)

--DELETE
--From RowNumCTE
--Where row_num > 1





---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

--Select *
--From project.dbo.NashvilleHousing

--ALTER TABLE project.dbo.NashvilleHousing
--DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress


--ALTER TABLE project.dbo.NashvilleHousing
--DROP COLUMN SaleDate







