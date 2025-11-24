-- LOGGING DEL PROCESO ETL - DATA WAREHOUSE PUBS
-- Registra ejecuciones y resultados del ETL

USE Pubs;
GO

-- Tabla para logging (crear una sola vez)
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'etl_log')
CREATE TABLE etl_log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    proceso VARCHAR(50),
    fecha_ejecucion DATETIME DEFAULT GETDATE(),
    estado VARCHAR(20),
    registros_afectados INT,
    mensaje VARCHAR(500)
);
GO

-- Procedimiento para agregar logs
CREATE OR ALTER PROCEDURE sp_log_etl
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