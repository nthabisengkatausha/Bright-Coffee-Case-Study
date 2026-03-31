select * from `workspace`.`default`.`bright_coffee_shop_analysis_case_study` limit 100;
--- How many stores that the company have---
Select distinct store_location
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study`;
---Product performace by revenue---
SELECT 
    product_category,
    SUM(transaction_qty) AS UnitsSold,
    SUM(transaction_qty * unit_price) AS Revenue
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study`
GROUP BY product_category
ORDER BY Revenue ASC;
---Performance per store---
SELECT 
    store_location,
    SUM(transaction_qty) AS UnitsSold,
    SUM(transaction_qty * unit_price) AS Revenue
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study`
GROUP BY store_location
ORDER BY Revenue ASC;

---Performance of products by quantity---
SELECT 
    product_id,
    product_detail,
    product_category,
    SUM(transaction_qty) AS total_units_sold,
    SUM(transaction_qty * unit_price) AS total_revenue
FROM 
    `workspace`.`default`.`bright_coffee_shop_analysis_case_study`
GROUP BY 
    product_id, 
    product_detail, 
    product_category
ORDER BY 
    total_units_sold ASC;
---Rush hour---
SELECT 
    store_location,
    HOUR(transaction_time) AS Hour_of_Day,
    SUM(transaction_qty) AS Total_Items_Sold
FROM  `workspace`.`default`.`bright_coffee_shop_analysis_case_study`
GROUP BY 
    store_location, 
    Hour_of_Day
ORDER BY 
    Total_Items_Sold DESC LIMIT 10;
--- Which day is the busiest--
SELECT
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      COUNT(DISTINCT transaction_id) AS Number_of_sales,
      SUM(transaction_qty*unit_price) AS revenue_per_day
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study`
GROUP BY transaction_date,
         Day_name,
         Month_name;
--- Checking product prices---
SELECT
COUNT(*) AS number_of_rows,
      COUNT(DISTINCT transaction_id) AS number_of_sales,
      COUNT(DISTINCT product_id) AS number_of_products,
      COUNT(DISTINCT store_id) AS number_of_stores
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study`;
---Which store has the most transaction---
SELECT 
    store_location,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    SUM(transaction_qty) AS total_items_sold
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study`
    GROUP BY 
    store_id, 
    store_location
ORDER BY 
    total_transactions DESC;
--- Which store has the most basket value---
SELECT 
    store_location,
    SUM(transaction_qty * unit_price) AS total_revenue,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    ROUND(SUM(transaction_qty * unit_price) / COUNT(DISTINCT transaction_id), 2) AS avg_basket_value
FROM 
    `workspace`.`default`.`bright_coffee_shop_analysis_case_study`
GROUP BY 
    store_id, 
    store_location
ORDER BY 
    avg_basket_value DESC;
---Categories product using price---
SELECT 
    product_detail,
    unit_price,
    CASE 
        WHEN unit_price > 5.00 THEN 'Premium'
        WHEN unit_price BETWEEN 3.00 AND 5.00 THEN 'Mid-Range'
        ELSE 'Budget'
    END AS price_segment
FROM 
    `workspace`.`default`.`bright_coffee_shop_analysis_case_study`
GROUP BY 
    product_detail, 
    unit_price
ORDER BY 
    unit_price DESC;


