CREATE OR REPLACE PACKAGE BODY GAT.GAT_SUBPROGRAMS
-- Creado 20230603
IS
    TYPE CATALOG_TT IS TABLE OF BOOLEAN
        INDEX BY CODE_ST;

    V_CATALOG    CATALOG_TT;

    FUNCTION ACTIVE (P_CODE IN CODE_ST)
        RETURN BOOLEAN
    IS
    BEGIN
        RETURN V_CATALOG (P_CODE);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE (
                   'GAT_SUBPROGRAMS:ACTIVE:'
                || 'Código ['
                || P_CODE
                || '] no encontrado.');
            RETURN NULL;
    END ACTIVE;

    PROCEDURE SHOW_CATALOG
    IS
        V_CODE    CODE_ST;
    BEGIN
        V_CODE := V_CATALOG.FIRST;

        WHILE V_CODE IS NOT NULL LOOP
            DBMS_OUTPUT.PUT_LINE (
                   V_CODE
                || ':'
                || CASE
                       WHEN V_CATALOG (V_CODE) = TRUE THEN 'TRUE'
                       ELSE 'FALSE'
                   END);
            V_CODE := GAT_SUBPROGRAMS.V_CATALOG.NEXT (V_CODE);
        END LOOP;
    END SHOW_CATALOG;
BEGIN
    V_CATALOG (K_EXI_PK_RET_BOOL) := TRUE;
    V_CATALOG (K_CNT_PK_RET_NUM) := FALSE;

    V_CATALOG (K_QRR_PK_RET_REG) := TRUE;
    V_CATALOG (K_QRY_PK_RET_REG) := FALSE;

    V_CATALOG (K_QCC_PK_RET_CUR) := TRUE;
    V_CATALOG (K_QRR_UK_OUT_REG) := FALSE;
    V_CATALOG (K_QCC_UK_RET_CUR) := TRUE;
    V_CATALOG (K_QCC_FK_OUT_CUR) := TRUE;

    V_CATALOG (K_QAL____RET_CUR) := TRUE;
    V_CATALOG (K_QWC____RET_CUR) := FALSE;
    V_CATALOG (K_QWT____OUT_TAB) := FALSE;
END GAT_SUBPROGRAMS;
/
SHOW ERRORS;


