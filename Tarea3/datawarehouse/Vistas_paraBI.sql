
-- VISTAS PARA ANALISIS DE BUSINESS INTELLIGENCE


USE Pubs;
GO

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
GO

-- RENDIMIENTO DE AUTORES
CREATE VIEW vw_author_performance AS
SELECT 
    da.au_name,
    da.city,
    da.state,
    COUNT(DISTINCT fs.title_id) as title_count,
    SUM(fs.qty) as total_sold,
    SUM(fs.sales_amount) as gross_revenue,
    SUM(fs.royalty_amount) as total_royalties
FROM fact_sales fs
JOIN dim_authors da ON fs.au_id = da.au_id
GROUP BY da.au_name, da.city, da.state;
GO

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
GO

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
GO