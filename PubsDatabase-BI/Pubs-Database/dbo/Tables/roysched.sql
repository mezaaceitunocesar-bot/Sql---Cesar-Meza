CREATE TABLE [dbo].[roysched] (
    [title_id]   VARCHAR (6) NULL,
    [lorange]    INT         NULL,
    [hirange]    INT         NULL,
    [royalty]    INT         NULL,
    [RowVersion] ROWVERSION  NOT NULL,
    FOREIGN KEY ([title_id]) REFERENCES [dbo].[titles] ([title_id])
);

