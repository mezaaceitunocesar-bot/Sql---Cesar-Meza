
-- TABLA DE HECHOS - VENTAS

USE Pubs;
GO

CREATE TABLE fact_sales (
    sales_id INT IDENTITY(1,1) PRIMARY KEY,
    time_id INT,
    title_id VARCHAR(6),
    au_id VARCHAR(11),
    stor_id CHAR(4),
    emp_id CHAR(9),
    qty SMALLINT,
    sales_amount MONEY,
    royalty_amount MONEY,
    payterms VARCHAR(12),
    FOREIGN KEY (time_id) REFERENCES dim_time(time_id),
    FOREIGN KEY (title_id) REFERENCES dim_titles(title_id),
    FOREIGN KEY (au_id) REFERENCES dim_authors(au_id),
    FOREIGN KEY (stor_id) REFERENCES dim_stores(stor_id),
    FOREIGN KEY (emp_id) REFERENCES dim_employee(emp_id)
);
GO