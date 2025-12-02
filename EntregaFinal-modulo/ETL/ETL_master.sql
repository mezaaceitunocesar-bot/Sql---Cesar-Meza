DECLARE @inicio DATETIME = GETDATE();

PRINT 'INICIANDO PROCESO ETL';

IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Pubs')
BEGIN
    RAISERROR('La base de datos Pubs no existe', 16, 1);
    RETURN;
END

IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Pubs_DW')
BEGIN
    RAISERROR('La base de datos Pubs_DW no existe', 16, 1);
    RETURN;
END

BEGIN TRY
    PRINT 'LIMPIANDO DATA WAREHOUSE';
    
    DELETE FROM Pubs_DW.dbo.fact_sales;
    DELETE FROM Pubs_DW.dbo.dim_time;
    DELETE FROM Pubs_DW.dbo.dim_titles;
    DELETE FROM Pubs_DW.dbo.dim_authors;
    DELETE FROM Pubs_DW.dbo.dim_stores;
    DELETE FROM Pubs_DW.dbo.dim_employee;
    DELETE FROM Pubs_DW.dbo.dim_publishers;
    
    PRINT 'CARGANDO DIMENSIONES';
    
    INSERT INTO Pubs_DW.dbo.dim_time (time_id, full_date, day, month, year, quarter, semester, day_name, is_weekend)
    SELECT DISTINCT
        CONVERT(INT, CONVERT(VARCHAR(8), ord_date, 112)),
        CAST(ord_date AS DATE),
        DATEPART(DAY, ord_date),
        DATEPART(MONTH, ord_date),
        DATEPART(YEAR, ord_date),
        DATEPART(QUARTER, ord_date),
        CASE WHEN DATEPART(MONTH, ord_date) <= 6 THEN 1 ELSE 2 END,
        DATENAME(WEEKDAY, ord_date),
        CASE WHEN DATEPART(WEEKDAY, ord_date) IN (1, 7) THEN 1 ELSE 0 END
    FROM Pubs.dbo.sales
    WHERE ord_date IS NOT NULL;
    
    INSERT INTO Pubs_DW.dbo.dim_titles (title_id, title, type, price, advance, royalty, ytd_sales, pubdate, pub_id, pub_name)
    SELECT 
        t.title_id,
        t.title,
        t.type,
        t.price,
        t.advance,
        t.royalty,
        t.ytd_sales,
        CAST(t.pubdate AS DATE),
        t.pub_id,
        p.pub_name
    FROM Pubs.dbo.titles t
    LEFT JOIN Pubs.dbo.publishers p ON t.pub_id = p.pub_id;
    
    INSERT INTO Pubs_DW.dbo.dim_authors (au_id, au_name, phone, city, state, contract)
    SELECT 
        au_id,
        au_fname + ' ' + au_lname,
        phone,
        city,
        state,
        contract
    FROM Pubs.dbo.authors;
    
    INSERT INTO Pubs_DW.dbo.dim_stores (stor_id, stor_name, stor_address, city, state, zip)
    SELECT 
        stor_id,
        stor_name,
        stor_address,
        city,
        state,
        zip
    FROM Pubs.dbo.stores;
    
    INSERT INTO Pubs_DW.dbo.dim_employee (emp_id, emp_name, job_id, job_desc, job_lvl, pub_id, hire_date)
    SELECT 
        e.emp_id,
        e.fname + ' ' + ISNULL(e.minit + '. ', '') + e.lname,
        e.job_id,
        j.job_desc,
        e.job_lvl,
        e.pub_id,
        CAST(e.hire_date AS DATE)
    FROM Pubs.dbo.employee e
    LEFT JOIN Pubs.dbo.jobs j ON e.job_id = j.job_id;
    
    INSERT INTO Pubs_DW.dbo.dim_publishers (pub_id, pub_name, city, state, country)
    SELECT 
        pub_id,
        pub_name,
        city,
        state,
        country
    FROM Pubs.dbo.publishers;
    
    PRINT 'CARGANDO HECHOS';
    
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
    FROM Pubs.dbo.sales s
    LEFT JOIN Pubs.dbo.titles t ON s.title_id = t.title_id
    WHERE s.ord_date IS NOT NULL;
    
    DECLARE @hechos INT = @@ROWCOUNT;
    DECLARE @tiempo INT = DATEDIFF(SECOND, @inicio, GETDATE());
    
    PRINT 'PROCESO COMPLETADO';
    PRINT 'Hechos cargados: ' + CAST(@hechos AS VARCHAR);
    PRINT 'Tiempo: ' + CAST(@tiempo AS VARCHAR) + ' segundos';
    
END TRY
BEGIN CATCH
    DECLARE @error_msg VARCHAR(500) = ERROR_MESSAGE();
    PRINT 'ERROR: ' + @error_msg;
    THROW;
END CATCH
GO