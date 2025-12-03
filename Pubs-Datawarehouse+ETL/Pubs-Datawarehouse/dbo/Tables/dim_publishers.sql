CREATE TABLE [dbo].[dim_publishers] (
    [pub_id]   CHAR (4)     NOT NULL,
    [pub_name] VARCHAR (40) NULL,
    [city]     VARCHAR (20) NULL,
    [state]    CHAR (2)     NULL,
    [country]  VARCHAR (30) NULL,
    PRIMARY KEY CLUSTERED ([pub_id] ASC)
);

