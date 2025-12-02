USE Pubs;
GO

IF EXISTS (SELECT 1 FROM Pubs_DW.dbo.fact_sales)
BEGIN
    DELETE FROM Pubs_DW.dbo.fact_sales;
    DBCC CHECKIDENT ('Pubs_DW.dbo.fact_sales', RESEED, 0);
END

INSERT INTO Pubs_DW.dbo.fact_sales (
    time_id, title_id, au_id, stor_id, emp_id, pub_id, 
    qty, sales_amount, royalty_amount, payterms
)
SELECT 
    CONVERT(INT, CONVERT(VARCHAR(8), s.ord_date, 112)),
    s.title_id,
    (SELECT TOP 1 ta.au_id FROM Pubs.dbo.titleauthor ta WHERE ta.title_id = s.title_id ORDER BY ta.au_ord),
    s.stor_id,
    (SELECT TOP 1 e.emp_id FROM Pubs.dbo.employee e WHERE e.pub_id = t.pub_id),
    t.pub_id,
    s.qty,
    (s.qty * ISNULL(t.price, 0)),
    (s.qty * ISNULL(t.price, 0) * ISNULL((SELECT TOP 1 ta.royaltyper FROM Pubs.dbo.titleauthor ta WHERE ta.title_id = s.title_id ORDER BY ta.au_ord), 0) / 100.0),
    s.payterms
FROM sales s
LEFT JOIN titles t ON s.title_id = t.title_id
WHERE s.ord_date IS NOT NULL;
GO

DECLARE @filas INT = @@ROWCOUNT;
PRINT 'Filas cargadas: ' + CAST(@filas AS VARCHAR);
GO