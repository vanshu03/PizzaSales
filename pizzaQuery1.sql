-- KPI requirements

SELECT 
    SUM(total_price) AS Total_Revenue
FROM
    pizza_sales;


-- average order value


SELECT 
    ROUND(SUM(total_price) / COUNT(DISTINCT (order_id)),
            2) AS avg_order_value
FROM
    pizza_sales;

-- total pizza sold
SELECT 
    SUM(quantity) AS total_pizza_sold
FROM
    pizza_sales;

-- total order places

SELECT 
    COUNT(DISTINCT (order_id)) AS total_orders
FROM
    pizza_sales;

-- average pizza per order

SELECT 
    ROUND(CAST(SUM(quantity) AS DECIMAL (10 , 2 )) / CAST(COUNT(DISTINCT (order_id)) AS DECIMAL (10 , 2 )),
            2) AS avg_pizzas_per_order
FROM
    pizza_sales;


-- ***Charts Requirement***

SELECT 
    DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM
    pizza_sales
WHERE
    order_date IS NOT NULL
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'));


-- Monthly Trends for total orders


SELECT 
    MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM
    pizza_sales
WHERE
    order_date IS NOT NULL
GROUP BY MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY total_orders DESC;


-- percentage of sales by pizza category

SELECT 
    pizza_category,
    ROUND(SUM(total_price) * 100 / (SELECT 
                    SUM(total_price)
                FROM
                    pizza_sales),
            2) AS PCT
FROM
    pizza_sales
GROUP BY pizza_category;


-- percentage of sales by pizza size
SELECT 
    pizza_size,
    ROUND(SUM(total_price) * 100 / (SELECT 
                    SUM(total_price)
                FROM
                    pizza_sales),
            2) AS PCTs
FROM
    pizza_sales
GROUP BY pizza_size
ORDER BY PCTs DESC;


-- TOP 5 best sellers by Revenue , Total Quantity and Total Orders

SELECT 
    pizza_name, SUM(total_price) AS Total_Revenue
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;


-- Total Quantity


SELECT 
    pizza_name, SUM(quantity) AS Total_Quantity
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
LIMIT 5;


-- Total Orders

SELECT 
    pizza_name, COUNT(DISTINCT (order_id)) AS total_orders
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;

