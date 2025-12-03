CREATE TABLE [dbo].[dim_employee] (
    [emp_id]    CHAR (9)     NOT NULL,
    [emp_name]  VARCHAR (60) NULL,
    [job_id]    SMALLINT     NULL,
    [job_desc]  VARCHAR (50) NULL,
    [job_lvl]   TINYINT      NULL,
    [pub_id]    CHAR (4)     NULL,
    [hire_date] DATE         NULL,
    PRIMARY KEY CLUSTERED ([emp_id] ASC)
);

