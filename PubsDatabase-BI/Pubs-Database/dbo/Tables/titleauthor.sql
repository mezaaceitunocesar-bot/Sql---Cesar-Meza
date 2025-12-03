CREATE TABLE [dbo].[titleauthor] (
    [au_id]      VARCHAR (11) NOT NULL,
    [title_id]   VARCHAR (6)  NOT NULL,
    [au_ord]     TINYINT      NULL,
    [royaltyper] INT          NULL,
    [RowVersion] ROWVERSION   NOT NULL,
    PRIMARY KEY CLUSTERED ([au_id] ASC, [title_id] ASC),
    FOREIGN KEY ([au_id]) REFERENCES [dbo].[authors] ([au_id]),
    FOREIGN KEY ([title_id]) REFERENCES [dbo].[titles] ([title_id])
);

