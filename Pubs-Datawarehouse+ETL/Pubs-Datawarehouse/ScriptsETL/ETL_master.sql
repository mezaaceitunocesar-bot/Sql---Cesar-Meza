-- SCRIPT MAESTRO ETL - DATA WAREHOUSE PUBS
USE Pubs;
GO

BEGIN TRY
    PRINT 'INICIANDO PROCESO ETL COMPLETO';
    
    PRINT 'Creando tablas dimensionales...';
    -- Ejecutar: DataWarehouse/Dimensiones_datawarehouse.sql
    
    PRINT 'Creando tabla de hechos...';
    -- Ejecutar: DataWarehouse/Hechos-ventas.sql
    
    PRINT 'Cargando dimensiones...';
    -- Ejecutar: ETL/ETL_Dimensions.sql
    
    PRINT 'Cargando hechos...';
    -- Ejecutar: ETL/ETL_Facts.sql
    
    PRINT 'Ejecutando validaciones...';
    -- Ejecutar: ETL/ETL_Validation.sql
    
    PRINT 'Creando vistas analíticas...';
    -- Ejecutar: DataWarehouse/Vistas_paraBI.sql
    
    DECLARE @hechos INT = (SELECT COUNT(*) FROM fact_sales);
    PRINT 'PROCESO COMPLETADO - Hechos cargados: ' + CAST(@hechos AS VARCHAR);
    
END TRY
BEGIN CATCH
    DECLARE @error_msg VARCHAR(500) = ERROR_MESSAGE();
    PRINT 'ERROR: ' + @error_msg;
    THROW;
END CATCH
GO