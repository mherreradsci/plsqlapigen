CREATE OR REPLACE PACKAGE GAT.GAT_SUBPROGRAMS
-- Creado 20230603
AS
    SUBTYPE CODE_ST IS VARCHAR2 (6);

    --*

    K_EXI_PK_RET_BOOL    CONSTANT CODE_ST := 'EXI'; -- Generar la funcion existe por pk
    K_CNT_PK_RET_NUM     CONSTANT CODE_ST := 'CPK'; -- Genera función para contar registros pos su PK (control)
    --*
    K_QRR_PK_RET_REG     CONSTANT CODE_ST := 'QRR:PK'; -- Generar procedure qry por su PK, entrega un registro por parámetro de salida
    K_QRY_PK_RET_REG     CONSTANT CODE_ST := 'QRY'; -- QRY: Genera una función de qry por su pk, retorna un registro

    K_QCC_PK_RET_CUR     CONSTANT CODE_ST := 'QCC:PK'; -- Genera las consultas sobre la pk. Retorna un cursor por referencia
    K_QRR_UK_OUT_REG     CONSTANT CODE_ST := 'QRR:UK'; -- Generar procedure qry por su pk, entrega un registro por parámetro de salida
    K_QCC_UK_RET_CUR     CONSTANT CODE_ST := 'QCC:UK'; -- Genera las consultas sobe las UKi. Retorna un cursor por referencia
    K_QCC_FK_OUT_CUR     CONSTANT CODE_ST := 'QCC:FK'; -- Genera las consultas sobre las fk. Retorna un cursor por referencia

    --*
    K_QAL____RET_CUR     CONSTANT CODE_ST := 'QAL'; -- Gererar function Obtiene un cursor via una consulta sin where es decir, todos los registros
    K_QWC____RET_CUR     CONSTANT CODE_ST := 'QWC'; -- Generar funcion de query con where dinámico y retorna un cursor
    K_QWT____OUT_TAB     CONSTANT CODE_ST := 'QWT'; -- Generar un procedimiento de query con where dinámico y entrega una tabla de records

    --* Functions and procedures
    FUNCTION ACTIVE (P_CODE IN CODE_ST)
        RETURN BOOLEAN;

    PROCEDURE SHOW_CATALOG;
END GAT_SUBPROGRAMS;
/
SHOW ERRORS;


