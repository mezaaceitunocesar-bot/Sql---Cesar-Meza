-- Verifica la calidad e integridad de los datos cargados en Pubs_DW

USE Pubs_DW;
GO

PRINT 'Iniciando validaciones ETL para Pubs_DW...';
GO

-- Validar que todas las dimensiones tienen datos
PRINT 'Validando dimensiones...';

IF NOT EXISTS (SELECT 1 FROM dim_time)
    PRINT 'ADVERTENCIA: Dimension tiempo está vacía';

IF NOT EXISTS (SELECT 1 FROM dim_titles) 
    PRINT 'ADVERTENCIA: Dimension títulos está vacía';

IF NOT EXISTS (SELECT 1 FROM dim_authors)
    PRINT 'ADVERTENCIA: Dimension autores está vacía';

IF NOT EXISTS (SELECT 1 FROM dim_stores)
    PRINT 'ADVERTENCIA: Dimension tiendas está vacía';

IF NOT EXISTS (SELECT 1 FROM dim_employee)
    PRINT 'ADVERTENCIA: Dimension empleados está vacía';

IF NOT EXISTS (SELECT 1 FROM dim_publishers)
    PRINT 'ADVERTENCIA: Dimension editoriales está vacía';
GO

-- Validar que la tabla de hechos tiene datos
PRINT 'Validando hechos...';

IF NOT EXISTS (SELECT 1 FROM fact_sales)
    PRINT 'ERROR: Tabla de hechos está vacía';
ELSE
    PRINT 'Hechos: ' + CAST((SELECT COUNT(*) FROM fact_sales) AS VARCHAR) + ' registros cargados';
GO

-- Validar integridad referencial entre BD
PRINT 'Validando integridad referencial entre Pubs y Pubs_DW...';

-- Verificar que todos los time_id existen en dim_time
IF EXISTS (
    SELECT 1 FROM Pubs_DW.dbo.fact_sales fs
    LEFT JOIN Pubs_DW.dbo.dim_time dt ON fs.time_id = dt.time_id
    WHERE dt.time_id IS NULL
) PRINT 'ERROR: Hay time_id en hechos sin correspondencia en dimension tiempo';

-- Verificar que todos los title_id existen en dim_titles
IF EXISTS (
    SELECT 1 FROM Pubs_DW.dbo.fact_sales fs
    LEFT JOIN Pubs_DW.dbo.dim_titles dt ON fs.title_id = dt.title_id
    WHERE dt.title_id IS NULL
) PRINT 'ERROR: Hay title_id en hechos sin correspondencia en dimension títulos';

-- Validar conteos básicos
DECLARE @ventas_fuente INT, @ventas_dw INT;
SET @ventas_fuente = (SELECT COUNT(*) FROM Pubs.dbo.sales);
SET @ventas_dw = (SELECT COUNT(*) FROM Pubs_DW.dbo.fact_sales);

PRINT 'Ventas en BD fuente (Pubs): ' + CAST(@ventas_fuente AS VARCHAR);
PRINT 'Ventas en BD destino (Pubs_DW): ' + CAST(@ventas_dw AS VARCHAR);

IF @ventas_fuente <> @ventas_dw
    PRINT 'ADVERTENCIA: Diferencia en conteo de ventas entre BD fuente y destino';
ELSE
    PRINT 'OK: Conteo de ventas coincide entre BD fuente y destino';
GO

PRINT 'Validaciones ETL completadas para Pubs_DW';
GO