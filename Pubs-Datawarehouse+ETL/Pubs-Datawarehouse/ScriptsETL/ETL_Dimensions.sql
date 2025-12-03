-- CARGA DE TABLAS DIMENSIONALES - DATA WAREHOUSE PUBS
-- Proceso ETL para dimensiones

USE Pubs;
GO

PRINT 'Cargando dimensiones...';
GO

-- Dimension tiempo
PRINT 'Cargando dimension tiempo...';
INSERT INTO dim_time (time_id, full_date, day, month, year, quarter, semester, day_name, is_weekend)
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
FROM sales
WHERE ord_date IS NOT NULL;
PRINT 'Dimension tiempo cargada';
GO

-- Dimension libros
PRINT 'Cargando dimension libros...';
INSERT INTO dim_titles (title_id, title, type, price, advance, royalty, ytd_sales, pubdate, pub_id, pub_name)
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
FROM titles t
LEFT JOIN publishers p ON t.pub_id = p.pub_id;
PRINT 'Dimension libros cargada';
GO

-- Dimension autores
PRINT 'Cargando dimension autores...';
INSERT INTO dim_authors (au_id, au_name, phone, city, state, contract)
SELECT 
    au_id,
    au_fname + ' ' + au_lname,
    phone,
    city,
    state,
    contract
FROM authors;
PRINT 'Dimension autores cargada';
GO

-- Dimension tiendas
PRINT 'Cargando dimension tiendas...';
INSERT INTO dim_stores (stor_id, stor_name, stor_address, city, state, zip)
SELECT 
    stor_id,
    stor_name,
    stor_address,
    city,
    state,
    zip
FROM stores;
PRINT 'Dimension tiendas cargada';
GO

-- Dimension empleados
PRINT 'Cargando dimension empleados...';
INSERT INTO dim_employee (emp_id, emp_name, job_id, job_desc, job_lvl, pub_id, hire_date)
SELECT 
    e.emp_id,
    e.fname + ' ' + ISNULL(e.minit + '. ', '') + e.lname,
    e.job_id,
    j.job_desc,
    e.job_lvl,
    e.pub_id,
    CAST(e.hire_date AS DATE)
FROM employee e
LEFT JOIN jobs j ON e.job_id = j.job_id;
PRINT 'Dimension empleados cargada';
GO

-- Dimension editoriales
PRINT 'Cargando dimension editoriales...';
INSERT INTO dim_publishers (pub_id, pub_name, city, state, country)
SELECT 
    pub_id,
    pub_name,
    city,
    state,
    country
FROM publishers;
PRINT 'Dimension editoriales cargada';
GO

PRINT 'Todas las dimensiones cargadas exitosamente';
GO