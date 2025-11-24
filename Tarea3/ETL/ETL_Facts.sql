-- CARGA DE TABLA DE HECHOS - DATA WAREHOUSE PUBS
-- Proceso ETL para hechos de ventas

USE Pubs;
GO

PRINT 'Cargando tabla de hechos de ventas...';
GO

-- Tabla de hechos
INSERT INTO fact_sales (
    time_id, title_id, au_id, stor_id, emp_id, pub_id, 
    qty, sales_amount, royalty_amount, payterms
)
SELECT 
    CONVERT(INT, CONVERT(VARCHAR(8), s.ord_date, 112)),
    s.title_id,
    ta.au_id,
    s.stor_id,
    e.emp_id,
    t.pub_id,
    s.qty,
    (s.qty * ISNULL(t.price, 0)),
    (s.qty * ISNULL(t.price, 0) * ISNULL(ta.royaltyper, 0) / 100.0),
    s.payterms
FROM sales s
LEFT JOIN titles t ON s.title_id = t.title_id
LEFT JOIN titleauthor ta ON s.title_id = ta.title_id AND ta.au_ord = 1
LEFT JOIN employee e ON t.pub_id = e.pub_id
WHERE s.ord_date IS NOT NULL;
GO

PRINT 'Tabla de hechos cargada exitosamente';
PRINT 'Filas cargadas: ' + CAST(@@ROWCOUNT AS VARCHAR);
GO