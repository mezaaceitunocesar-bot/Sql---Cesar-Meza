-- LIMPIEZA DEL DATA WAREHOUSE - PUBS
-- Elimina todos los datos para reiniciar el ETL

USE Pubs;
GO

PRINT 'Iniciando limpieza del Data Warehouse...';
GO

-- Eliminar datos de tablas en orden correcto (evitar restricciones FK)
PRINT 'Eliminando datos de hechos...';
DELETE FROM fact_sales;
GO

PRINT 'Eliminando datos de dimensiones...';
DELETE FROM dim_time;
DELETE FROM dim_titles;
DELETE FROM dim_authors;
DELETE FROM dim_stores;
DELETE FROM dim_employee;
DELETE FROM dim_publishers;
GO

PRINT 'Limpieza completada. Data Warehouse listo para nuevo ETL.';
GO