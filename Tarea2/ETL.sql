
-- PROCESO ETL 

USE Pubs;
GO

-- DIMENSION TIEMPO
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
GO

-- DIMENSION LIBROS
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
GO

-- DIMENSION AUTORES
INSERT INTO dim_authors (au_id, au_name, phone, city, state, contract)
SELECT 
    au_id,
    au_fname + ' ' + au_lname,
    phone,
    city,
    state,
    contract
FROM authors;
GO

-- DIMENSION TIENDAS
INSERT INTO dim_stores (stor_id, stor_name, stor_address, city, state, zip)
SELECT 
    stor_id,
    stor_name,
    stor_address,
    city,
    state,
    zip
FROM stores;
GO

-- DIMENSION EMPLEADOS
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
GO

-- TABLA DE HECHOS
INSERT INTO fact_sales (
    time_id, title_id, au_id, stor_id, emp_id, 
    qty, sales_amount, royalty_amount, payterms
)
SELECT 
    CONVERT(INT, CONVERT(VARCHAR(8), s.ord_date, 112)),
    s.title_id,
    ta.au_id,
    s.stor_id,
    e.emp_id,
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