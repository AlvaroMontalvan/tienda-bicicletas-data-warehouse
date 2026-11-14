SELECT 'dim_brand' AS tabla, COUNT(*) AS filas FROM dim_brand UNION ALL
SELECT 'dim_category', COUNT(*) FROM dim_category UNION ALL
SELECT 'dim_product', COUNT(*) FROM dim_product UNION ALL
SELECT 'dim_store', COUNT(*) FROM dim_store UNION ALL
SELECT 'dim_staff', COUNT(*) FROM dim_staff UNION ALL
SELECT 'dim_customer', COUNT(*) FROM dim_customer UNION ALL
SELECT 'dim_date', COUNT(*) FROM dim_date UNION ALL
SELECT 'fact_stock', COUNT(*) FROM fact_stock UNION ALL
SELECT 'fact_sales', COUNT(*) FROM fact_sales;

SELECT c.category_name AS categoria, d.year AS anio, SUM(f.quantity) AS cantidad_vendida
FROM fact_sales f
JOIN dim_product p ON p.product_id = f.product_id
JOIN dim_category c ON c.category_id = p.category_id
JOIN dim_date d ON d.date_id = f.order_date
GROUP BY c.category_name, d.year
ORDER BY c.category_name, d.year;
