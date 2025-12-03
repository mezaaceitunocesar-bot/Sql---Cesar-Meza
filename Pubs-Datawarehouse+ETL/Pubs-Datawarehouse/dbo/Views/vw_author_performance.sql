
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
