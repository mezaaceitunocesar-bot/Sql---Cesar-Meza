CREATE TABLE [dbo].[discounts] (
    [discounttype] VARCHAR (40)   NULL,
    [stor_id]      CHAR (4)       NULL,
    [lowqty]       SMALLINT       NULL,
    [highqty]      SMALLINT       NULL,
    [discount]     DECIMAL (4, 2) NULL,
    [RowVersion]   ROWVERSION     NOT NULL,
    FOREIGN KEY ([stor_id]) REFERENCES [dbo].[stores] ([stor_id])
);

