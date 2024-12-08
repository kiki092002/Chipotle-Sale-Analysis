use chipotle;
/*remove all dup before caculating*/
select distinct order_id, quantity,item_name, choice_description,item_price from report;



/*Revenue of each menu item*/
SELECT item_name, SUM(quantity * CAST(REPLACE(item_price,'$',"") AS DECIMAL(10,2))) AS Revenue
FROM report
GROUP BY item_name
ORDER BY Revenue Desc;

/* Total Revenue*/
Select SUM(quantity * CAST(REPLACE(item_price,'$',"") AS DECIMAL(10,2))) AS 'Total Revenue'
FROM report;

/* Average Order Value*/
SELECT 
    (SUM(quantity * CAST(REPLACE(item_price, '$', '') AS DECIMAL(10, 2))) / COUNT(DISTINCT order_id)) AS 'Average Order Value'
FROM report;

/* Total Items Sold*/
SELECT SUM(quantity) as 'Total Items Sold'
from report;

/*Total Order*/
SELECT COUNT(distinct order_id) as 'Total Order'
from report;


/*TOP 5 Popular Item*/
SELECT distinct item_name, SUM(quantity * CAST(REPLACE(item_price,'$',"") AS DECIMAL(10,2))) AS Revenue
from report
GROUP BY item_name 
ORDER BY Revenue desc
limit 5;

/*5Least Popular Items*/
SELECT distinct item_name, SUM(quantity * CAST(REPLACE(item_price,'$',"") AS DECIMAL(10,2))) AS Revenue
from report
GROUP BY item_name 
ORDER BY Revenue asc
limit 5;
/*Beverages by % Revenue*/
WITH TotalRevenue AS (
    SELECT 
        SUM(quantity * CAST(REPLACE(item_price, '$', '') AS DECIMAL(10, 2))) AS Total
    FROM report
    WHERE item_name LIKE '%Drink%' 
       OR item_name LIKE '%Water%' 
       OR item_name LIKE '%Soda%'
)
SELECT 
    item_name, 
    SUM(quantity * CAST(REPLACE(item_price, '$', '') AS DECIMAL(10, 2))) AS Revenue,
    (SUM(quantity * CAST(REPLACE(item_price, '$', '') AS DECIMAL(10, 2))) / TotalRevenue.Total) * 100 AS RevenuePercentage
FROM report, TotalRevenue
WHERE item_name LIKE '%Drink%' 
   OR item_name LIKE '%Water%' 
   OR item_name LIKE '%Soda%'
GROUP BY item_name, TotalRevenue.Total
ORDER BY Revenue DESC;

/*Revenue by Bowl*/
SELECT item_name,  SUM(quantity * CAST(REPLACE(item_price, '$', '') AS DECIMAL(10, 2))) AS Revenue
FROM report 
WHERE item_name LIKE "%Bowl%"
GROUP BY item_name
ORDER BY Revenue desc;

/* Revenue by Soft Tacos*/
SELECT item_name,  SUM(quantity * CAST(REPLACE(item_price, '$', '') AS DECIMAL(10, 2))) AS Revenue
FROM report 
WHERE item_name LIKE "%Soft Taco%"
GROUP BY item_name
ORDER BY Revenue desc;

/* Revenue by Crispy Tacos*/
SELECT item_name,  SUM(quantity * CAST(REPLACE(item_price, '$', '') AS DECIMAL(10, 2))) AS Revenue
FROM report 
WHERE item_name LIKE "%Crispy Taco%"
GROUP BY item_name
ORDER BY Revenue desc;
