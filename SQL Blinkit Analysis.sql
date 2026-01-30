create database blinkitdb;


USE blinkitdb;


CREATE TABLE blinkit(
	ItemFatContent VARCHAR(50),
    ItemIdentifier VARCHAR(50),
    ItemType VARCHAR(50),
    OutletEstablishmentYear INT,
    OutletIdentifier VARCHAR(50),
    OutletLocationType VARCHAR(50),
    OutletSize VARCHAR(50),
    OutletType VARCHAR(50),
    ItemVisibility DOUBLE,
    ItemWeight DOUBLE,
    TotalSales DOUBLE,
    Rating FLOAT
);

-- Displaying Complete Blinkit Dataset																
SELECT * FROM blinkit;


-- Counting Total Number of Rows in the Blinkit Table
SELECT COUNT(*) AS total_rows
FROM blinkit;


-- DATA CLEANING
-- Cleaning and Transforming ItemFatContent Data

UPDATE blinkit
SET ItemFatContent = 
    CASE 
        WHEN ItemFatContent IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN ItemFatContent = 'reg' THEN 'Regular'
        ELSE ItemFatContent
    END;
    
-- Verifying Standardized ItemFatContent Values After Cleaning
SELECT * FROM blinkit;
SELECT DISTINCT(ItemFatContent) from blinkit;
    
    
    
-- Displaying Total Sales Value in Million Format
SELECT 
    CONCAT(CAST(SUM(TotalSales) / 1000000 AS DECIMAL (10 , 2 )),
            ' M') AS TOTAL_SALES_MILLIONS
FROM
    blinkit;



-- Calculating Average Sales from the Blinkit Dataset   
SELECT CAST(AVG(TotalSales) AS DECIMAL (10 , 0)) AS AVG_SALES FROM blinkit;



-- Counting Total Number of Items in the Blinkit Dataset
SELECT COUNT(*) AS NUMBER_OF_ITEMS
FROM blinkit;



-- Calculating Average Rating of Items in the Blinkit Dataset
SELECT CAST(AVG(Rating) AS DECIMAL (10 , 2)) AS AVG_RATING FROM blinkit;



-- Fat Content Wise Total Sales, Average Sales, Count, and Rating Analysis
SELECT ItemFatContent, 
 CONCAT(CAST(SUM(TotalSales)/1000 AS DECIMAL(10,2)),' K') AS TOTAL_SALES,
 CAST(AVG(TotalSales) AS DECIMAL (10 , 1)) AS AVG_SALES,
 COUNT(*) AS NUMBER_OF_ITEMS,
 CAST(AVG(Rating) AS DECIMAL (10 , 2)) AS AVG_RATING
FROM blinkit
GROUP BY ItemFatContent
ORDER BY TOTAL_SALES DESC;




-- Top 5 Item Types by Total Sales (Summary of Sales, Count, and Ratings)
SELECT ItemType, 
 CAST(SUM(TotalSales) AS DECIMAL(10,2)) AS TOTAL_SALES,
 CAST(AVG(TotalSales) AS DECIMAL (10 , 1)) AS AVG_SALES,
 COUNT(*) AS NUMBER_OF_ITEMS,
 CAST(AVG(Rating) AS DECIMAL (10 , 2)) AS AVG_RATING
FROM blinkit
GROUP BY ItemType
ORDER BY TOTAL_SALES DESC
LIMIT 5;



-- Outlet Location Type Wise Sales Comparison (Low Fat vs Regular)
SELECT  
    OutletLocationType,
    CAST(SUM(CASE WHEN ItemFatContent = 'Low Fat' THEN TotalSales ELSE 0 END) AS DECIMAL(10,2)) AS Low_Fat,
    CAST(SUM(CASE WHEN ItemFatContent = 'Regular' THEN TotalSales ELSE 0 END) AS DECIMAL(10,2)) AS Regular
FROM blinkit
GROUP BY OutletLocationType
ORDER BY OutletLocationType;






-- Outlet Establishment Year Performance Analysis
SELECT OutletEstablishmentYear, 
 CAST(SUM(TotalSales) AS DECIMAL(10,2)) AS TOTAL_SALES,
 CAST(AVG(TotalSales) AS DECIMAL (10 , 1)) AS AVG_SALES,
 COUNT(*) AS NUMBER_OF_ITEMS,
 CAST(AVG(Rating) AS DECIMAL (10 , 2)) AS AVG_RATING
FROM blinkit
GROUP BY OutletEstablishmentYear
ORDER BY TOTAL_SALES DESC;




-- Percentage of Sales by Outlet Size
SELECT 
    OutletSize, 
    CAST(SUM(TotalSales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(TotalSales) * 100.0 / SUM(SUM(TotalSales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit
GROUP BY OutletSize
ORDER BY Total_Sales DESC;




-- Sales by Outlet Location
SELECT OutletLocationType,
 CAST(SUM(TotalSales) AS DECIMAL(10,2)) AS Total_Sales,
 CAST((SUM(TotalSales) * 100.0 / SUM(SUM(TotalSales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
 CAST(AVG(TotalSales) AS DECIMAL (10 , 1)) AS AVG_SALES,
 COUNT(*) AS NUMBER_OF_ITEMS,
 CAST(AVG(Rating) AS DECIMAL (10 , 2)) AS AVG_RATING
FROM blinkit
GROUP BY OutletLocationType
ORDER BY Total_Sales DESC;





-- All Metrics by Outlet Type
SELECT OutletType, 
		CAST(SUM(TotalSales) AS DECIMAL(10,2)) AS Total_Sales,
        CAST((SUM(TotalSales) * 100.0 / SUM(SUM(TotalSales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
		CAST(AVG(TotalSales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(ItemVisibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit
GROUP BY OutletType
ORDER BY Total_Sales DESC;

