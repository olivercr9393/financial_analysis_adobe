-- Proyecto: Analisis financiero de Adobe (2019-2025)

-- Crear base de datos general para alojar datos del archivo cvs
CREATE DATABASE adobe;
USE adobe;

-- Paso 1: Crear la tabla
CREATE TABLE finance (
	company VARCHAR(50),
    statement VARCHAR(50),
    metric VARCHAR(150),
    year INT,
    value DECIMAL(15,2)
);

-- Verificar que se creo con exito la tabla:
SELECT * FROM finance;

SELECT COUNT(*) FROM finance;

-- SE PROCEDE A IMPORTAR LA TABLA CVS CON LOS DATOS LIMPIOS 'adobe_financial'
-- CLIC DERECHO EN Schemas -> adobe -> Tables -> finance -> Table Data Import Wizard

-- Respuesta 5.1: Para saber el historico de Ingresos por año y ademas el crecimiento interanual
SELECT
    year                                            AS año,
    value                                           AS ingresos,
    LAG(value) OVER (ORDER BY year)                 AS ingresos_anterior,
    ROUND(
        (value - LAG(value) OVER (ORDER BY year))
        / LAG(value) OVER (ORDER BY year) * 100
    , 2)                                             AS crecimiento_interanual_pct
FROM finance
WHERE metric = 'Revenue'
ORDER BY year;

-- Respuesta 5.2: Para calcular los distintos margenes de rentabilidad y el porcentaje que representa cada uno
SELECT
    f1.year                                 AS año,
    f1.value                                AS ingresos,
    f2.value                                AS beneficio_bruto,
    f3.value                                AS ingresos_operativos,
    f4.value                                AS beneficio_neto,
    ROUND(f2.value / f1.value * 100, 2)     AS margen_bruto_pct,
    ROUND(f3.value / f1.value * 100, 2)     AS margen_operativo_pct,
    ROUND(f4.value / f1.value * 100, 2)     AS margen_neto_pct
FROM finance f1
JOIN finance f2 ON f1.year = f2.year AND f2.metric = 'Gross Profit'
JOIN finance f3 ON f1.year = f3.year AND f3.metric = 'Operating Income (Loss)'
JOIN finance f4 ON f1.year = f4.year AND f4.metric = 'Net Income'
WHERE f1.metric = 'Revenue'
ORDER BY f1.year;

-- Respuesta 5.3: Para calcular cuanto dinero usa la compañia para la recompra de acciones y cuanto porcentaje del flujo operativo representa
SELECT
    f1.year                                 AS año,
    f1.value                                AS flujo_operativo,
    ABS(f2.value)                           AS recompra_acciones,
    ROUND(ABS(f2.value) / f1.value * 100, 2) AS porcentaje_recompra
FROM finance f1
JOIN finance f2 ON f1.year = f2.year AND f2.metric = 'Cash From (Repurchase of) Equity'
WHERE f1.metric = 'Cash from Operating Activities'
ORDER BY f1.year;

-- Respuesta 5.4: Para calcular la cantidad de ingresos que invierte la compañia en investigación y desarrollo y cuanto porcentaje de los ingresos representa
SELECT
    f1.year                                 AS año,
    f1.value                                AS ingresos,
    ABS(f2.value)                           AS inversion_id,
    ROUND(ABS(f2.value) / f1.value * 100, 2) AS porcentaje_id
FROM finance f1
JOIN finance f2 ON f1.year = f2.year AND f2.metric = 'Research & Development'
WHERE f1.metric = 'Revenue'
ORDER BY f1.year;

-- Respuesta 5.5: Para calcular el porcentaje de endeudamiento de la empresa en relacion al patrimonio
SELECT
    f1.year                                 AS año,
    f1.value                                AS deuda_largo_plazo,
    f2.value                                AS patrimonio_total,
    ROUND(f1.value / f2.value * 100, 2)     AS pct_deuda_patrimonio,
    f3.value                                AS acciones_tesoro
FROM finance f1
JOIN finance f2 ON f1.year = f2.year AND f2.metric = 'Total Equity'
JOIN finance f3 ON f1.year = f3.year AND f3.metric = 'Treasury Stock'
WHERE f1.metric = 'Long Term Debt'
ORDER BY f1.year;

-- Tabla para visualizacion en Power BI:
CREATE VIEW adobe_bi AS
SELECT
    base.year,
    base.revenue,
    base.gross_profit,
    base.operating_income,
    base.net_income,
    base.total_assets,
    base.total_equity,
    base.long_term_debt,
    base.cash_from_operations,
    base.rd_investment,
    base.buybacks,
    base.treasury_stock,
    -- Márgenes
    ROUND(base.gross_profit     / base.revenue * 100, 2) AS gross_margin_pct,
    ROUND(base.operating_income / base.revenue * 100, 2) AS operating_margin_pct,
    ROUND(base.net_income       / base.revenue * 100, 2) AS net_margin_pct,
    -- Rentabilidad
    ROUND(base.net_income  / base.total_equity * 100, 2) AS roe_pct,
    ROUND(base.net_income  / base.total_assets * 100, 2) AS roa_pct,
    -- Deuda
    ROUND(base.long_term_debt / base.total_equity, 2)    AS debt_to_equity,
    -- R&D
    ROUND(ABS(base.rd_investment) / base.revenue * 100, 2) AS rd_pct_revenue,
    -- Buybacks
    ROUND(ABS(base.buybacks) / base.cash_from_operations * 100, 2) AS buybacks_pct_cashops,
    -- Cash quality
    ROUND(base.cash_from_operations / base.net_income, 2) AS cash_quality_ratio,
    -- Crecimiento YoY
    ROUND(
        (base.revenue - LAG(base.revenue) OVER (ORDER BY base.year))
        / LAG(base.revenue) OVER (ORDER BY base.year) * 100
    , 2)                                                   AS revenue_yoy_pct
FROM (
    SELECT
        f1.year,
        f1.value  AS revenue,
        f2.value  AS gross_profit,
        f3.value  AS operating_income,
        f4.value  AS net_income,
        f5.value  AS total_assets,
        f6.value  AS total_equity,
        f7.value  AS long_term_debt,
        f8.value  AS cash_from_operations,
        f9.value  AS rd_investment,
        f10.value AS buybacks,
        f11.value AS treasury_stock
    FROM finance f1
    JOIN finance f2  ON f1.year = f2.year  AND f2.metric  = 'Gross Profit'
    JOIN finance f3  ON f1.year = f3.year  AND f3.metric  = 'Operating Income (Loss)'
    JOIN finance f4  ON f1.year = f4.year  AND f4.metric  = 'Net Income'
    JOIN finance f5  ON f1.year = f5.year  AND f5.metric  = 'Total Assets'
    JOIN finance f6  ON f1.year = f6.year  AND f6.metric  = 'Total Equity'
    JOIN finance f7  ON f1.year = f7.year  AND f7.metric  = 'Long Term Debt'
    JOIN finance f8  ON f1.year = f8.year  AND f8.metric  = 'Cash from Operating Activities'
    JOIN finance f9  ON f1.year = f9.year  AND f9.metric  = 'Research & Development'
    JOIN finance f10 ON f1.year = f10.year AND f10.metric = 'Cash From (Repurchase of) Equity'
    JOIN finance f11 ON f1.year = f11.year AND f11.metric = 'Treasury Stock'
    WHERE f1.metric = 'Revenue'
) AS base
ORDER BY base.year;

-- Verificar los resultados de la tabla para visualizacion en Power BI 
SELECT * FROM adobe_bi;

-- Se exporta el archivo CVS de esta visualización para facilitar la creacion de las visualizaciones y KPIs en Power BI 
-- Schemas -> adobe -> Views -> adobe_bi -> Table Data Export Wizard
-- Guardamos el CVS y es el que usaremos al cargar datos en Power BI.