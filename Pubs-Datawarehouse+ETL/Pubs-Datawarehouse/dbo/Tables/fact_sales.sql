CREATE TABLE [dbo].[fact_sales] (
    [sales_id]       INT          IDENTITY (1, 1) NOT NULL,
    [time_id]        INT          NULL,
    [title_id]       VARCHAR (6)  NULL,
    [au_id]          VARCHAR (11) NULL,
    [stor_id]        CHAR (4)     NULL,
    [emp_id]         CHAR (9)     NULL,
    [pub_id]         CHAR (4)     NULL,
    [qty]            SMALLINT     NULL,
    [sales_amount]   MONEY        NULL,
    [royalty_amount] MONEY        NULL,
    [payterms]       VARCHAR (12) NULL,
    PRIMARY KEY CLUSTERED ([sales_id] ASC),
    FOREIGN KEY ([au_id]) REFERENCES [dbo].[dim_authors] ([au_id]),
    FOREIGN KEY ([emp_id]) REFERENCES [dbo].[dim_employee] ([emp_id]),
    FOREIGN KEY ([pub_id]) REFERENCES [dbo].[dim_publishers] ([pub_id]),
    FOREIGN KEY ([stor_id]) REFERENCES [dbo].[dim_stores] ([stor_id]),
    FOREIGN KEY ([time_id]) REFERENCES [dbo].[dim_time] ([time_id]),
    FOREIGN KEY ([title_id]) REFERENCES [dbo].[dim_titles] ([title_id])
);

