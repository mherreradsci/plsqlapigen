CREATE OR REPLACE FORCE VIEW GAT.GAT_CATALOGO
(
    OWNER,
    TABLE_NAME,
    TABLE_PREFIX,
    TABLE_SUBJECT,
    NOMBRE_PACKAGE,
    TPAC_CODIGO,
    OBJECT_TYPE,
    EXISTE
)
AS
    WITH CATALOGO
         AS (SELECT OWNER,
                    TABLE_NAME,
                    SUBSTR (TABL.TABLE_NAME, 1, 3) AS TABLE_PREFIX,
                    SUBSTR (TABL.TABLE_NAME, 5) AS TABLE_SUBJECT,
                    CASE
                        WHEN SUBSTR (TABL.TABLE_NAME, 4, 7) = '_TIPOS_' THEN
                            'S'
                        ELSE
                            'N'
                    END
                        AS GENERA_KP
             FROM   DBA_TABLES TABL
             WHERE      OWNER IN ('PYSNIP_OWN', 'PYSNIN_OWN')
                    AND (   TABLE_NAME LIKE 'BAP\_%' ESCAPE '\'
                         OR TABLE_NAME LIKE 'GEO\_%' ESCAPE '\'
                         OR TABLE_NAME LIKE 'ORG\_%' ESCAPE '\'
                         OR TABLE_NAME LIKE 'AUS\_%' ESCAPE '\'
                         OR TABLE_NAME LIKE 'INT\_%' ESCAPE '\'
                         OR TABLE_NAME LIKE 'PGN\_%' ESCAPE '\'
                         OR TABLE_NAME LIKE 'COP\_%' ESCAPE '\'
                         OR TABLE_NAME LIKE 'CAT\_%' ESCAPE '\'
                         OR TABLE_NAME LIKE 'UTL\_%' ESCAPE '\'))
    SELECT CATA.OWNER,
           CATA.TABLE_NAME,
           CATA.TABLE_PREFIX,
           TABLE_SUBJECT,
           GAT_UTL.GEN_PACKAGE_NAME (NULL, CATA.TABLE_NAME, TPAC.TPAC_CODIGO)
               NOMBRE_PACKAGE,
           TPAC.TPAC_CODIGO,
           'PACKAGE' AS OBJECT_TYPE,
           (SELECT 'S'
            FROM   DBA_OBJECTS OBJE
            WHERE      OBJE.OWNER = CATA.OWNER
                   AND OBJE.OBJECT_NAME =
                           GAT_UTL.GEN_PACKAGE_NAME (
                               NULL,
                               CATA.TABLE_NAME,
                               TPAC.TPAC_CODIGO)
                   AND OBJE.OBJECT_TYPE = 'PACKAGE')
               AS EXISTE
    FROM   CATALOGO CATA, GAT_TIP_PACKAGES TPAC
    WHERE --
          --         tpac.generado = 'S' AND
           TPAC.TPAC_CODIGO != 'KP'
    UNION ALL
    SELECT CATA.OWNER,
           CATA.TABLE_NAME,
           CATA.TABLE_PREFIX,
           TABLE_SUBJECT,
           GAT_UTL.GEN_PACKAGE_NAME (NULL, CATA.TABLE_NAME, TPAC.TPAC_CODIGO)
               NOMBRE_PACKAGE,
           TPAC.TPAC_CODIGO,
           'PACKAGE' AS OBJECT_TYPE,
           (SELECT 'S'
            FROM   DBA_OBJECTS OBJE
            WHERE      OBJE.OWNER = CATA.OWNER
                   AND OBJE.OBJECT_NAME =
                           GAT_UTL.GEN_PACKAGE_NAME (
                               NULL,
                               CATA.TABLE_NAME,
                               TPAC.TPAC_CODIGO)
                   AND OBJE.OBJECT_TYPE = 'PACKAGE')
               AS EXISTE
    FROM   CATALOGO CATA, GAT_TIP_PACKAGES TPAC
    WHERE --
          --         tpac.generado = 'S' AND
               TPAC.TPAC_CODIGO = 'KP'
           AND CATA.GENERA_KP = 'S'
    ORDER BY OWNER, TABLE_NAME
/


