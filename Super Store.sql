-- select all field of this data set
SELECT *
FROM [superstore].[dbo].[Data$]

  -- count the total transaction that was made
 SELECT COUNT(*)
 FROM [superstore].[dbo].[Data$]


	-- calculate the total sales 
SELECT SUM(Sales * Quantity) AS  Total_Sales
FROM [superstore].[dbo].[Data$]

	  -- calculate the total profit that was made
SELECT SUM(profit)
FROM [superstore].[dbo].[Data$]

-- find the total numbers of customers in the data set

SELECT COUNT(DISTINCT [Customer Name])
FROM [superstore].[dbo].[Data$]

-- calculate the total numbers of product sold
SELECT COUNT(DISTINCT [Product Name])
FROM [superstore].[dbo].[Data$]

-- retrieve the name of the customer that has generated more profits than the rest

SELECT TOP 1
[Customer Name], SUM(Profit)
FROM [superstore].[dbo].[Data$]
GROUP BY [Customer Name]
ORDER BY 2 DESC

-- show the top 5 highly purchased products
SELECT TOP 5
[Product Name], COUNT([Product Name])
FROM [superstore].[dbo].[Data$]
GROUP BY [Product Name]
ORDER BY 2 DESC

-- select top 10 customers that has generated more revenue for the company

SELECT TOP 10
[Customer Name], SUM(Sales * Quantity) as Revenue
FROM [superstore].[dbo].[Data$]
GROUP BY [Customer Name]
ORDER BY 2 DESC

-- how much sales and profit was made from each region
SELECT Region, SUM(Sales * Quantity) AS Revenue, SUM(Profit) AS Total_Profit
FROM [superstore].[dbo].[Data$]
GROUP BY Region

-- Which region has the highest profit
SELECT TOP 1
Region, SUM(Profit) AS Total_Profit
FROM [superstore].[dbo].[Data$]
GROUP BY Region
ORDER BY 2 DESC


-- Which region has the highest revenue
SELECT TOP 1
Region, SUM(Sales * Quantity) AS Revenue
FROM [superstore].[dbo].[Data$]
GROUP BY Region
ORDER BY 2

--we wil like to know our oldest customer, please retrive the name of the customer that made the first order and what
SELECT TOP 1
[Customer Name], [Order Date]
FROM [superstore].[dbo].[Data$]
ORDER BY 2 ASC

-- What was the product that was ordered and which city, state and region did the customer come from

SELECT TOP 1
[Product Name], City, State, Region,  [Order Date]
FROM [superstore].[dbo].[Data$]
ORDER BY 5 ASC

-- list out the 10 profitable state from the data set
SELECT top 10
State, SUM(Profit) as Total_Profit
FROM [superstore].[dbo].[Data$]
GROUP BY State
ORDER BY 2 DESC


-- get the total profit, highest profit, average profit, lowest profit and numbers of transaction made by each customer.
SELECT [Customer Name], SUM(Profit) as Total_profit, AVG(Profit) AS Average_Profit,  Max(Profit) AS Highest_Profit,
MIN(Profit) AS Lowest_Profit, COUNT([Customer Name]) AS Number_of_Transaction
FROM [superstore].[dbo].[Data$]
GROUP BY [Customer Name]
ORDER BY Total_profit DESC

-- total profit made by each category

SELECT Category, SUM(Profit)
FROM [superstore].[dbo].[Data$]
GROUP BY Category
ORDER BY 2 DESC

-- total profit made by each category

SELECT Category, SUM(Profit)
FROM [superstore].[dbo].[Data$]
GROUP BY Category
ORDER BY 2 DESC

-- total profit made by each Segment
SELECT Segment, SUM(Profit)
FROM [superstore].[dbo].[Data$]
GROUP BY Segment
ORDER BY 2 DESC

-- total profit made by sub category
SELECT [Sub-Category], SUM(Profit) AS Total_Profit
FROM [superstore].[dbo].[Data$]
GROUP BY [Sub-Category]


-- show the numbers of cities where order always come from

SELECT count(DISTINCT City) AS Customer_Location
FROM [superstore].[dbo].[Data$]
