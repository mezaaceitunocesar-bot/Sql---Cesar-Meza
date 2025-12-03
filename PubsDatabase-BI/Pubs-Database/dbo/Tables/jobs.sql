CREATE TABLE [dbo].[jobs] (
    [job_id]     SMALLINT     NOT NULL,
    [job_desc]   VARCHAR (50) NULL,
    [min_lvl]    TINYINT      NULL,
    [max_lvl]    TINYINT      NULL,
    [RowVersion] ROWVERSION   NOT NULL,
    PRIMARY KEY CLUSTERED ([job_id] ASC)
);

