CREATE TABLE [dbo].[sales] (
    [stor_id]    CHAR (4)     NOT NULL,
    [ord_num]    VARCHAR (20) NOT NULL,
    [ord_date]   DATETIME     NULL,
    [qty]        SMALLINT     NULL,
    [payterms]   VARCHAR (12) NULL,
    [title_id]   VARCHAR (6)  NOT NULL,
    [RowVersion] ROWVERSION   NOT NULL,
    PRIMARY KEY CLUSTERED ([stor_id] ASC, [ord_num] ASC, [title_id] ASC),
    FOREIGN KEY ([stor_id]) REFERENCES [dbo].[stores] ([stor_id]),
    FOREIGN KEY ([title_id]) REFERENCES [dbo].[titles] ([title_id])
);

