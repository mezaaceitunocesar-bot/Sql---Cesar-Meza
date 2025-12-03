
-- VENTAS POR TITULO Y PERIODO
CREATE VIEW vw_title_sales AS
SELECT 
    dt.title,
    dt.type,
    dm.year,
    dm.quarter,
    COUNT(fs.sales_id) as transaction_count,
    SUM(fs.qty) as total_qty,
    SUM(fs.sales_amount) as total_sales,
    AVG(dt.price) as avg_price
FROM fact_sales fs
JOIN dim_titles dt ON fs.title_id = dt.title_id
JOIN dim_time dm ON fs.time_id = dm.time_id
GROUP BY dt.title, dt.type, dm.year, dm.quarter;
