CREATE TABLE [dbo].[authors] (
    [au_id]      VARCHAR (11) NOT NULL,
    [au_lname]   VARCHAR (40) NULL,
    [au_fname]   VARCHAR (20) NULL,
    [phone]      CHAR (12)    NULL,
    [address]    VARCHAR (40) NULL,
    [city]       VARCHAR (20) NULL,
    [state]      CHAR (2)     NULL,
    [zip]        CHAR (5)     NULL,
    [contract]   BIT          NULL,
    [RowVersion] ROWVERSION   NOT NULL,
    PRIMARY KEY CLUSTERED ([au_id] ASC)
);

