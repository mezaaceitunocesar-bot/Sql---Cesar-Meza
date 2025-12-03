
-- TABLAS DIMENSIONALES DEL DATA WAREHOUSE


USE Pubs;
GO

-- DIMENSION TIEMPO
CREATE TABLE dim_time (
    time_id INT PRIMARY KEY,
    full_date DATE,
    day INT,
    month INT,
    year INT,
    quarter INT,
    semester INT,
    day_name VARCHAR(15),
    is_weekend BIT
);
GO

-- DIMENSION LIBROS
CREATE TABLE dim_titles (
    title_id VARCHAR(6) PRIMARY KEY,
    title VARCHAR(80),
    type CHAR(12),
    price MONEY,
    advance MONEY,
    royalty INT,
    ytd_sales INT,
    pubdate DATE,
    pub_id CHAR(4),
    pub_name VARCHAR(40)
);
GO

-- DIMENSION AUTORES
CREATE TABLE dim_authors (
    au_id VARCHAR(11) PRIMARY KEY,
    au_name VARCHAR(60),
    phone CHAR(12),
    city VARCHAR(20),
    state CHAR(2),
    contract BIT
);
GO

-- DIMENSION TIENDAS
CREATE TABLE dim_stores (
    stor_id CHAR(4) PRIMARY KEY,
    stor_name VARCHAR(40),
    stor_address VARCHAR(40),
    city VARCHAR(20),
    state CHAR(2),
    zip CHAR(5)
);
GO

-- DIMENSIoN EMPLEADOS
CREATE TABLE dim_employee (
    emp_id CHAR(9) PRIMARY KEY,
    emp_name VARCHAR(60),
    job_id SMALLINT,
    job_desc VARCHAR(50),
    job_lvl TINYINT,
    pub_id CHAR(4),
    hire_date DATE
);
GO