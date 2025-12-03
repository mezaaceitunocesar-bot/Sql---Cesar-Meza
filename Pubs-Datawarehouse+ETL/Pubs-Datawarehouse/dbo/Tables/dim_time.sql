CREATE TABLE [dbo].[dim_time] (
    [time_id]    INT          NOT NULL,
    [full_date]  DATE         NULL,
    [day]        INT          NULL,
    [month]      INT          NULL,
    [year]       INT          NULL,
    [quarter]    INT          NULL,
    [semester]   INT          NULL,
    [day_name]   VARCHAR (15) NULL,
    [is_weekend] BIT          NULL,
    PRIMARY KEY CLUSTERED ([time_id] ASC)
);

