-- Crear la base de datos
CREATE DATABASE Pubs;
GO

USE Pubs;
GO

-- Tabla: publishers
CREATE TABLE publishers (
    pub_id CHAR(4) PRIMARY KEY,
    pub_name VARCHAR(40),
    city VARCHAR(20),
    state CHAR(2),
    country VARCHAR(30),
    RowVersion TIMESTAMP
);

-- Tabla: pub_info
CREATE TABLE pub_info (
    pub_id CHAR(4) PRIMARY KEY,
    logo IMAGE,
    pr_info TEXT,
    RowVersion TIMESTAMP,
    FOREIGN KEY (pub_id) REFERENCES publishers(pub_id)
);

-- Tabla: jobs
CREATE TABLE jobs (
    job_id SMALLINT PRIMARY KEY,
    job_desc VARCHAR(50),
    min_lvl TINYINT,
    max_lvl TINYINT,
    RowVersion TIMESTAMP
);

-- Tabla: employee
CREATE TABLE employee (
    emp_id CHAR(9) PRIMARY KEY,
    fname VARCHAR(20),
    minit CHAR(1),
    lname VARCHAR(30),
    job_id SMALLINT,
    job_lvl TINYINT,
    pub_id CHAR(4),
    hire_date DATETIME,
    RowVersion TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (pub_id) REFERENCES publishers(pub_id)
);

-- Tabla: authors
CREATE TABLE authors (
    au_id VARCHAR(11) PRIMARY KEY,
    au_lname VARCHAR(40),
    au_fname VARCHAR(20),
    phone CHAR(12),
    address VARCHAR(40),
    city VARCHAR(20),
    state CHAR(2),
    zip CHAR(5),
    contract BIT,
    RowVersion TIMESTAMP
);

-- Tabla: titles
CREATE TABLE titles (
    title_id VARCHAR(6) PRIMARY KEY,
    title VARCHAR(80),
    type CHAR(12),
    pub_id CHAR(4),
    price MONEY,
    advance MONEY,
    royalty INT,
    ytd_sales INT,
    notes VARCHAR(200),
    pubdate DATETIME,
    RowVersion TIMESTAMP,
    FOREIGN KEY (pub_id) REFERENCES publishers(pub_id)
);

-- Tabla: titleauthor
CREATE TABLE titleauthor (
    au_id VARCHAR(11),
    title_id VARCHAR(6),
    au_ord TINYINT,
    royaltyper INT,
    RowVersion TIMESTAMP,
    PRIMARY KEY (au_id, title_id),
    FOREIGN KEY (au_id) REFERENCES authors(au_id),
    FOREIGN KEY (title_id) REFERENCES titles(title_id)
);

-- Tabla: roysched
CREATE TABLE roysched (
    title_id VARCHAR(6),
    lorange INT,
    hirange INT,
    royalty INT,
    RowVersion TIMESTAMP,
    FOREIGN KEY (title_id) REFERENCES titles(title_id)
);

-- Tabla: stores
CREATE TABLE stores (
    stor_id CHAR(4) PRIMARY KEY,
    stor_name VARCHAR(40),
    stor_address VARCHAR(40),
    city VARCHAR(20),
    state CHAR(2),
    zip CHAR(5),
    RowVersion TIMESTAMP
);

-- Tabla: discounts
CREATE TABLE discounts (
    discounttype VARCHAR(40),
    stor_id CHAR(4),
    lowqty SMALLINT,
    highqty SMALLINT,
    discount DECIMAL(4,2),
    RowVersion TIMESTAMP,
    FOREIGN KEY (stor_id) REFERENCES stores(stor_id)
);

-- Tabla: sales
CREATE TABLE sales (
    stor_id CHAR(4),
    ord_num VARCHAR(20),
    ord_date DATETIME,
    qty SMALLINT,
    payterms VARCHAR(12),
    title_id VARCHAR(6),
    RowVersion TIMESTAMP,
    PRIMARY KEY (stor_id, ord_num, title_id),
    FOREIGN KEY (stor_id) REFERENCES stores(stor_id),
    FOREIGN KEY (title_id) REFERENCES titles(title_id)
);
