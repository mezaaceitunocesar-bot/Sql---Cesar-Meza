CREATE TABLE [dbo].[employee] (
    [emp_id]     CHAR (9)     NOT NULL,
    [fname]      VARCHAR (20) NULL,
    [minit]      CHAR (1)     NULL,
    [lname]      VARCHAR (30) NULL,
    [job_id]     SMALLINT     NULL,
    [job_lvl]    TINYINT      NULL,
    [pub_id]     CHAR (4)     NULL,
    [hire_date]  DATETIME     NULL,
    [RowVersion] ROWVERSION   NOT NULL,
    PRIMARY KEY CLUSTERED ([emp_id] ASC),
    FOREIGN KEY ([job_id]) REFERENCES [dbo].[jobs] ([job_id]),
    FOREIGN KEY ([pub_id]) REFERENCES [dbo].[publishers] ([pub_id])
);

