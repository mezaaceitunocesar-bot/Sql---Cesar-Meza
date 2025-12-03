
-- ANALISIS DE VENTAS POR EDITORIAL
CREATE VIEW vw_publisher_performance AS
SELECT 
    dp.pub_name,
    dp.city,
    dp.state,
    dt.year,
    dt.quarter,
    COUNT(DISTINCT fs.title_id) as unique_titles,
    SUM(fs.qty) as total_units_sold,
    SUM(fs.sales_amount) as total_revenue,
    AVG(fs.sales_amount) as avg_sale_amount
FROM fact_sales fs
JOIN dim_publishers dp ON fs.pub_id = dp.pub_id
JOIN dim_time dt ON fs.time_id = dt.time_id
GROUP BY dp.pub_name, dp.city, dp.state, dt.year, dt.quarter;
