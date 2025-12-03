CREATE TABLE [dbo].[dim_authors] (
    [au_id]    VARCHAR (11) NOT NULL,
    [au_name]  VARCHAR (60) NULL,
    [phone]    CHAR (12)    NULL,
    [city]     VARCHAR (20) NULL,
    [state]    CHAR (2)     NULL,
    [contract] BIT          NULL,
    PRIMARY KEY CLUSTERED ([au_id] ASC)
);

