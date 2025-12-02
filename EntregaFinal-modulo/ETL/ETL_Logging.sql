-- LOGGING DEL PROCESO ETL - DATA WAREHOUSE PUBS 
-- Registra ejecuciones y resultados del ETL en Pubs_DW

USE Pubs_DW;
GO

-- Tabla para logging (crear una sola vez)
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'etl_log')
CREATE TABLE etl_log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    proceso VARCHAR(50),
    fecha_ejecucion DATETIME DEFAULT GETDATE(),
    estado VARCHAR(20),
    registros_afectados INT,
    mensaje VARCHAR(500),
    bd_fuente VARCHAR(50) DEFAULT 'Pubs',
    bd_destino VARCHAR(50) DEFAULT 'Pubs_DW'
);
GO

-- Procedimiento para agregar logs
CREATE OR ALTER PROCEDURE sp_log_etl_dw
    @proceso VARCHAR(50),
    @estado VARCHAR(20),
    @registros INT = NULL,
    @mensaje VARCHAR(500) = NULL
AS
BEGIN
    INSERT INTO etl_log (proceso, estado, registros_afectados, mensaje)
    VALUES (@proceso, @estado, @registros, @mensaje);
END;
GO

-- Procedimiento para loggear inicio/fin de ETL
CREATE OR ALTER PROCEDURE sp_log_etl_completo
AS
BEGIN
    DECLARE @inicio DATETIME = GETDATE();
    DECLARE @registros INT;
    
    EXEC sp_log_etl_dw 'ETL_COMPLETO', 'INICIADO', NULL, 'Inicio proceso ETL completo';
    
    -- Ejecutar ETL aquí o llamar a otros procedimientos
    
    SET @registros = (SELECT COUNT(*) FROM fact_sales);
    
    EXEC sp_log_etl_dw 'ETL_COMPLETO', 'COMPLETADO', @registros, 
        'ETL completado en ' + CAST(DATEDIFF(SECOND, @inicio, GETDATE()) AS VARCHAR) + ' segundos';
END;
GO