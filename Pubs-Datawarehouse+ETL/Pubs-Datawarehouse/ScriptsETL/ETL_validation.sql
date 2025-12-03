-- VALIDACIONES DEL PROCESO ETL - DATA WAREHOUSE PUBS
-- Verifica la calidad e integridad de los datos cargados

USE Pubs;
GO

PRINT 'Iniciando validaciones ETL...';
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

-- Validar integridad referencial
PRINT 'Validando integridad referencial...';

IF EXISTS (
    SELECT 1 FROM fact_sales fs
    LEFT JOIN dim_time dt ON fs.time_id = dt.time_id
    WHERE dt.time_id IS NULL
) PRINT 'ERROR: Hay time_id en hechos sin correspondencia en dimension tiempo';

IF EXISTS (
    SELECT 1 FROM fact_sales fs
    LEFT JOIN dim_titles dt ON fs.title_id = dt.title_id
    WHERE dt.title_id IS NULL
) PRINT 'ERROR: Hay title_id en hechos sin correspondencia en dimension títulos';
GO

PRINT 'Validaciones ETL completadas';
GO