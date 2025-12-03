CREATE TABLE [dbo].[dim_titles] (
    [title_id]  VARCHAR (6)  NOT NULL,
    [title]     VARCHAR (80) NULL,
    [type]      CHAR (12)    NULL,
    [price]     MONEY        NULL,
    [advance]   MONEY        NULL,
    [royalty]   INT          NULL,
    [ytd_sales] INT          NULL,
    [pubdate]   DATE         NULL,
    [pub_id]    CHAR (4)     NULL,
    [pub_name]  VARCHAR (40) NULL,
    PRIMARY KEY CLUSTERED ([title_id] ASC)
);

