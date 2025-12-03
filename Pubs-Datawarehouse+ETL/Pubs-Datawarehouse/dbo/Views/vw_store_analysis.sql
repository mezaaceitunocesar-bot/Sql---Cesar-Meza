
-- ANALISIS GEOGRAFICO DE VENTAS
CREATE VIEW vw_store_analysis AS
SELECT 
    ds.stor_name,
    ds.city,
    ds.state,
    dt.year,
    dt.quarter,
    SUM(fs.qty) as units_sold,
    SUM(fs.sales_amount) as sales_volume,
    COUNT(DISTINCT fs.title_id) as unique_titles
FROM fact_sales fs
JOIN dim_stores ds ON fs.stor_id = ds.stor_id
JOIN dim_time dt ON fs.time_id = dt.time_id
GROUP BY ds.stor_name, ds.city, ds.state, dt.year, dt.quarter;
