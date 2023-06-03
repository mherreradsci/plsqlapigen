CREATE OR REPLACE PACKAGE GAT.GAT_DEFS
/*
Empresa:    Explora-IT
Proyecto:   Utilidades para desarrolladores
Objetivo:   Definiciones generales para el generador de APIs de tablas

Historia    Quien    Descripción
----------- -------- -------------------------------------------------------------
03-Dic-2004 mherrera Separa las definiciones generales UTL_TAB_API
15-Feb-2009 mherrera Agrega coleccion linea_t para cargar más de una linea
                     al cuerpo de las constantes
25-May-2009 mherrera Agrega k_package_perfix
02-Feb-2012 mherrera Agrega k_tipa_Konstants_package
06-Feb-2012 mherrera Agrega subtipo package_name_t
19-Mar-2012 mherrera Agrega la constante k_sufijo_secuencia
04-mar-2012 mherrera Agrega Konstante k_tipa_update_package
14-jun-2012 mherrera Agrega constante k_tipa_delete_package
27-jun-2012 mherrera Cambia la constante k_prog_next_key_spec para que la función
                     retorne un INTEGER en vez de NUMBER
12-jul-2012 mherrera Agrega constante k_tipa_insert_package para los
                     insert adhoc, por ejemplo, insert con ERR$_
*/
IS
    -- Constantes para identificar el package
    K_PACKAGEX                  CONSTANT FDC_DEFS.PACKAGE_NAME_T := 'GAT_DEFS';

    --
    K_PACKAGE_PERFIX            CONSTANT VARCHAR2 (10) := 'PKG_'; --NULL; --'PKG_';
    -- Constantes
    K_MAX_ID_LEN                CONSTANT NUMBER (2) := 30.0;
    K_MAX_NAME_LEN_SUFIX        CONSTANT NUMBER (2) := 27.0;
    K_MAX_NAME_LEN_PREFIX       CONSTANT NUMBER (2) := 28.0;

    -- Tipo de prefijo
    SUBTYPE TIPO_PREFIJO_LISTA_COLS_T IS VARCHAR2 (1);

    K_TPLC_TABLA                CONSTANT TIPO_PREFIJO_LISTA_COLS_T := 'T';
    K_TPLC_COLUMNA              CONSTANT TIPO_PREFIJO_LISTA_COLS_T := 'C';

    -- Subtipos generales
    SUBTYPE PALABRA IS VARCHAR2 (80);

    SUBTYPE LINEA IS VARCHAR2 (512);

    SUBTYPE LINEA_LARGA IS VARCHAR2 (2000);

    SUBTYPE ID_NAME_T IS VARCHAR2 (30);

    -- Subtipos parámetros
    SUBTYPE DEFAULT_VALUE_T IS VARCHAR2 (3);

    K_DEVA_DB_DEFAULT           CONSTANT DEFAULT_VALUE_T := 'DBD';
    K_DEVA_DB_ALL_NULL          CONSTANT DEFAULT_VALUE_T := 'ALN';
    K_DEVA_DB_NO_DEFAULT        CONSTANT DEFAULT_VALUE_T := 'NOD';
    -- Constantes
    K_PROY                      CONSTANT PALABRA := '%PROYECTO%';
    K_OWNER_PACKAGE             CONSTANT PALABRA := '%OWNER%';
    K_NOMBRE_PACKAGE            CONSTANT PALABRA := '%NOMBRE_PACKAGE%';
    K_NOMBRE_PACKAGE_TIPO       CONSTANT PALABRA := '%NOMBRE_PACKAGE_TIPO%';
    K_TABLA                     CONSTANT PALABRA := '%TABLA%';
    K_TABLA_NC                  CONSTANT PALABRA := '%TABLA_NC%';
    K_TABLA_NC_PREFIX           CONSTANT PALABRA := '%TABLA_NC_PREFIX%';
    K_COLUMNA                   CONSTANT PALABRA := '%COLUMNA%';
    K_COLUMNA_NC                CONSTANT PALABRA := '%COLUMNA_NC%'; -- Nombre corto de la col
    K_COLUMNA_NC_SUFIX          CONSTANT PALABRA := '%COLUMNA_NC_SUFIX%'; -- Nombre corto de la col
    K_QUIEN                     CONSTANT PALABRA := '%QUIEN%';
    K_FECHA                     CONSTANT PALABRA := '%FECHA%';
    K_FECHA_HORA                CONSTANT PALABRA := '%FECHA_HORA%';
    K_BODY                      CONSTANT PALABRA := '%BODY%';
    K_PROGRAM_NAME              CONSTANT PALABRA := '%NOMBRE_PROGRAMA%';

    -- Manejo y redefinición de excepciones
    SUBTYPE USER_EXCEPTION_NAME_T IS PALABRA;

    K_UEN_NOT_FOUND             CONSTANT USER_EXCEPTION_NAME_T := 'ue_not_found';
    K_REDEF_NO_DATA_FOUND       CONSTANT PALABRA
        := 'PRAGMA EXCEPTION_INIT(ue_not_found,-01403)' ;

    -- Comentario a ser generado
    TYPE LINEAS_T IS TABLE OF VARCHAR2 (255);

    --subTYPE lineas_t IS utl_line.lines_t;
    K_PACKAGE_COM               CONSTANT UTL_LINE.STATIC_LINES_T
                                             := UTL_LINE.STATIC_LINES_T (
                                                    '/*------------------------------------------------------------------------------',
                                                    --                '-- Generado por Gencod V1.3.3 Spring 2011',
                                                    --                '-- Autor: Marcelo Herrera Tejada',
                                                    --                '--',
                                                    --                '-- No modifique este código',
                                                    --                '-- TSTAMP:%FECHA_HORA%',
                                                    --                '--------------------------------------------------------------------------------',
                                                    --                '',
                                                    'Proyecto: %PROYECTO%',
                                                    'Objetivo: Definicion de tipos/Proc para APIs de tabla %TABLA%',
                                                    CHR (10),
                                                    'Historia    Quien    Descripción',
                                                    '----------- -------- -----------------------------------------------------------',
                                                    '%FECHA% %QUIEN% Creación',
                                                    '*/') ;
    --   k_package_com_1_x          CONSTANT linea_larga
    --      := '/*
    ---- Generado por Gencod V1.3.1
    ---- Empresa: Explora IT
    ---- Autor: Marcelo Herrera Tejada
    ----        mherrera@explora-it.cl
    ---- www.explora-it.cl
    ----
    ---- No modifique este código
    ---- TSTAMP:%FECHA_HORA%
    ----------------------------------------------------------------------------------

    --Proyecto: %PROYECTO%
    --Objetivo: Definicion de tipos/Proc para APIs de tabla %TABLA%
    --';
    --   k_package_com_2_x          CONSTANT linea_larga
    --      := 'Historia    Quien    Descripción
    ------------- -------- -----------------------------------------------------------
    --%FECHA% %QUIEN% Creación
    --*/';
    -- Encabezados
    K_PROMPT                    CONSTANT LINEA
        := 'prompt Creando package %NOMBRE_PACKAGE%' ;
    K_CREATE                    CONSTANT LINEA := 'CREATE OR REPLACE ';
    K_PACKAGE_NAME              CONSTANT LINEA
        := 'package %BODY% %OWNER%.%NOMBRE_PACKAGE%' ;
    K_IS_AS                     CONSTANT LINEA := ' is ';
    K_PACKAGE_END               CONSTANT LINEA := 'end %NOMBRE_PACKAGE%;';
    K_BLANK                     CONSTANT LINEA := NULL;
    K_NEW_LINE                  CONSTANT LINEA := CHR (10);
    -- Generales
    K_PREFJO_PARAM              CONSTANT LINEA := 'p_';
    K_SUFIJO_SUBTYPE            CONSTANT LINEA := '_t';
    K_PREFIJO_VAR               CONSTANT LINEA := 'v_';
    --
    K_SUFIJO_SECUENCIA          CONSTANT LINEA := '_SEC';
    K_SUFIJO_SECUENCIA_ID       CONSTANT LINEA := '_ID';
    -- columnas, record y tabla
    K_COLUMN_VAR                CONSTANT LINEA
                                             := K_PREFIJO_VAR || '%COLUMNA_NC%' ;
    K_COLUMN_TYPE               CONSTANT LINEA := '%TIPO_COLUMNA%';
    K_COLUMNA_SUBTYPE_DEF       CONSTANT LINEA
        :=    'subtype %COLUMNA_NC%'
           || K_SUFIJO_SUBTYPE
           || ' is %TABLA%.%COLUMNA%%type;' ;
    K_COLUMN_COLLECTION         CONSTANT LINEA
        :=    'type %COLUMNA_NC%_ct IS TABLE OF %COLUMNA_NC_SUFIX%'
           || K_SUFIJO_SUBTYPE
           || ' INDEX BY BINARY_INTEGER;' ;
    K_COLLECTION                CONSTANT LINEA := '%COLECCION%';
    -- Constraints
    K_CONSTRAINT_PUF            CONSTANT PALABRA := '%CONSTRAINT%';
    K_CONSTRAINT_PUF_NC         CONSTANT PALABRA := '%CONSTRAINT_NC%';
    K_REC_TYPE                  CONSTANT LINEA
        := 'subtype %TABLA_NC%_rt is %TABLA%%rowtype;' ;
    K_TAB_TYPE                  CONSTANT LINEA
        := 'type    %TABLA_NC%_ct is table of %TABLA_NC%_rt index by binary_integer;' ;
    K_CUR_TYPE                  CONSTANT LINEA
        := 'type    %TABLA_NC%_rc is ref cursor;' ;
    -- Exceptions
    K_EXCEPTION_NAME            CONSTANT LINEA := '%EXCEPTION_NAME%';
    K_WHEN_EXCEPTION_THEN       CONSTANT LINEA := 'when %EXCEPTION_NAME% then';
    K_RAISE_EXCEPTION           CONSTANT LINEA := 'raise %EXCEPTION_NAME%';
    K_NO_DATA_FOUND             CONSTANT LINEA := 'no_data_found';
    -- Otras Constantes generales
    K_SQL_ROWCOUNT              CONSTANT LINEA := 'p_num_regs := SQL%ROWCOUNT;';
    K_SQL_VAR_ROWCOUNT          CONSTANT LINEA := 'v_num_regs := SQL%ROWCOUNT;';

    --*
    --* Procedimiento de query por PK
    K_QRY_PROC_COM              CONSTANT VARCHAR2 (2000)
        := '-- Consulta el registro de la %TABLA% basado en la PK' ;
    -- ****** ATENCION-- ATENCION -- ATENCION -- ATENCION -- ATENCION -- ******
    -- La función que genera este programa está obsoleta, debe reemplazarse por
    -- "sel_<Nombre_de_la_Constraint>". El nuevo código generado
    -- levanta una excepción cuando no existe el registro, además, ya
    -- no retornan los record sino que se hace vía parámetro in out nocopy
    -- para mejor performance.';
    K_QRY_PROC_NAME             CONSTANT LINEA := 'sel_pk';
    K_QRY_PROC                  CONSTANT LINEA := 'function ' || K_QRY_PROC_NAME;
    K_QRY_CURSOR                CONSTANT LINEA
                                             := 'cursor c_%TABLA_NC% is select' ;
    K_QRY_PROC_RET              CONSTANT LINEA
        := 'return %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_rt' ;
    K_QRY_PROC_VAR              CONSTANT LINEA
        :=    K_PREFIJO_VAR
           || '%TABLA_NC_PREFIX% %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_rt;' ;
    K_QRY_PROC_FROM             CONSTANT LINEA := 'from %TABLA%';
    K_QRY_PROC_OPEN             CONSTANT LINEA := 'open c_%TABLA_NC%;';
    K_QRY_PROC_FETCH            CONSTANT LINEA
        := 'fetch c_%TABLA_NC% into v_%TABLA_NC%;' ;
    K_QRY_PROC_CLOSE            CONSTANT LINEA := 'close c_%TABLA_NC%;';
    K_QRY_PROC_RETV             CONSTANT LINEA := 'return v_%TABLA_NC%;';
    K_QRY_END                   CONSTANT LINEA := 'end ' || K_QRY_PROC_NAME;

    --*
    --* Procedimiento de query por PK/UK que entrega un record type como parametro de salida
    K_QRR_PROC_COM              CONSTANT LINEA
        :=    '-- Consulta un registro de %TABLA% '
           || CHR (10)
           || '   -- basado en la constraint %CONSTRAINT%' ;
    K_QRR_PROC_NAME             CONSTANT LINEA := 'sel_%CONSTRAINT_NC%';
    --   k_qrr_proc                CONSTANT linea := 'procedure ' || k_qrr_proc_name;
    K_QRR_CURSOR                CONSTANT LINEA
                                             := 'cursor c_%TABLA_NC% is select' ;
    K_QRR_PROC_OUT_RECORD1      CONSTANT LINEA
        :=    K_PREFJO_PARAM
           || '%TABLA_NC_PREFIX% OUT NOCOPY %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_rt' ;
    K_QRR_PROC_V_FOUND          CONSTANT LINEA := 'v_found BOOLEAN;';
    --   k_qrr_proc_var            CONSTANT linea := k_prefijo_var || '%TABLA_NC_PREFIX% %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_rt;';
    K_QRR_PROC_FROM             CONSTANT LINEA := 'from %TABLA%';
    K_QRR_PROC_OPEN             CONSTANT LINEA := 'open c_%TABLA_NC%;';
    K_QRR_PROC_FETCH            CONSTANT LINEA
        := 'fetch c_%TABLA_NC% into p_%TABLA_NC%;' ;
    K_QRR_PROC_SET_FOUND        CONSTANT LINEA
        := 'v_found := c_%TABLA_NC%%FOUND;' ;
    K_QRR_PROC_CLOSE            CONSTANT LINEA := 'close c_%TABLA_NC%;';
    K_QRR_PROC_IF_NDF_RAISE     CONSTANT LINEA
        := 'if not v_found then raise no_data_found; end if;' ;
    K_QRR_END                   CONSTANT LINEA := 'end ' || K_QRR_PROC_NAME;

    --*
    --* Procedimiento para consultar por la existencia de un registro
    K_EXI_PROC_COM              CONSTANT LINEA
        :=    '-- Consulta la exitencia de un registro'
           || CHR (10)
           || '   -- de la %TABLA% basado en la PK' ;
    K_EXI_PROC                  CONSTANT LINEA := 'existe';
    K_EXI_PROC_RET              CONSTANT LINEA := 'return BOOLEAN';
    K_EXI_PROC_VAR_L01          CONSTANT LINEA
        := K_PREFIJO_VAR || 'valor VARCHAR2(1);' ;
    K_EXI_PROC_VAR_L02          CONSTANT LINEA
        := K_PREFIJO_VAR || 'retval BOOLEAN;' ;
    K_EXI_PROC_CURSOR           CONSTANT LINEA
        := q'<cursor un_registro is select 'x' from %TABLA%>' ;
    K_EXI_PROC_OPEN             CONSTANT LINEA := 'open un_registro;';
    K_EXI_PROC_FETCH            CONSTANT LINEA
        := 'FETCH un_registro INTO v_valor;' ;
    K_EXI_PROC_FOUND            CONSTANT LINEA
        := K_PREFIJO_VAR || 'retval := un_registro%FOUND;' ;
    K_EXI_PROC_CLOSE            CONSTANT LINEA := 'CLOSE un_registro;';
    K_EXI_PROC_RETURN           CONSTANT LINEA := 'RETURN v_retval;';
    K_EXI_END                   CONSTANT LINEA := 'end existe';

    --*
    --* Funcion para obtener la cantidad de registros a partir de la pk
    K_CPK_PROC_COM              CONSTANT LINEA
        :=    '-- Funcion para obtener la cantidad de registros'
           || CHR (10)
           || '   -- de la tabla %TABLA% a partir de la pk' ;
    K_CPK_PROC_NAME             CONSTANT LINEA := 'cuenta_por_pk';
    K_CPK_PROC                  CONSTANT LINEA
                                             := 'function ' || K_CPK_PROC_NAME ;
    K_CPK_PROC_RET              CONSTANT LINEA := 'return SIMPLE_INTEGER';
    K_CPK_VAR_COUNT             CONSTANT LINEA
        := K_PREFIJO_VAR || 'cantidad SIMPLE_INTEGER := 0;' ;
    K_CPK_SEL_COUNT             CONSTANT LINEA
        := 'select count(*) into v_cantidad from %TABLA%' ;
    K_CPK_PROC_RETURN           CONSTANT LINEA := 'return v_cantidad;';
    K_CPK_END                   CONSTANT LINEA := 'end cuenta_por_pk';

    --*
    --* Constantes para obtener un cursor con todos los registros de una tabla.
    --* Generalmente utilizado para Mantenedores, por ejemplo, tablas de Tipos
    -- (QAL):Query ALl
    --* Where dinámico. Retorma un Cursor
    K_QAL_PROC_COM              CONSTANT LINEA
        :=    '-- Obtiene un cursor para onsultar todos los registros'
           || CHR (10)
           || '   -- de la tabla %TABLA%' ;
    K_QAL_PROC_NAME             CONSTANT LINEA := 'sel';
    K_QAL_PROC                  CONSTANT LINEA
        := 'function ' || K_QAL_PROC_NAME || '' ;
    K_QAL_PROC_RET              CONSTANT LINEA
        := 'return %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_rc' ;
    K_QAL_VAR_CURSOR1           CONSTANT LINEA
        := 'c_%TABLA_NC_PREFIX% %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_rc;' ;
    K_QAL_OPEN_CURSOR           CONSTANT LINEA := 'open c_%TABLA_NC% for';
    K_QAL_RETURN                CONSTANT LINEA := 'return c_%TABLA_NC%;';
    K_QAL_END                   CONSTANT LINEA := 'end ' || K_QAL_PROC_NAME;

    --*
    --* Constantes para obtener un cursor con where dinámico (QWC):Query con
    --* Where dinámico. Retorma un Cursor
    K_QWC_PROC_COM              CONSTANT LINEA
        :=    '-- Obtiene un cursor via una consulta con where '
           || CHR (10)
           || '   -- dinámico sobre la tabla %TABLA%' ;
    K_QWC_PROC_NAME             CONSTANT LINEA := 'sel_where';
    K_QWC_PROC                  CONSTANT LINEA
        := 'function ' || K_QWC_PROC_NAME || '(p_where IN varchar2)' ;
    K_QWC_PROC_RET              CONSTANT LINEA
        := 'return %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_rc' ;
    K_QWC_VAR_CURSOR1           CONSTANT LINEA
        := 'c_%TABLA_NC_PREFIX% %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_rc;' ;
    K_QWC_OPEN_CURSOR           CONSTANT LINEA := 'open c_%TABLA_NC% for';
    K_QWC_RETURN                CONSTANT LINEA := 'return c_%TABLA_NC%;';
    K_QWC_END                   CONSTANT LINEA := 'end ' || K_QWC_PROC_NAME;

    --*
    --* Procedimiento para obtener un conjunto de registros (QWT:Query con Where dinámico y retorma una tabla)
    K_QWT_PROC_COM              CONSTANT LINEA
        :=    '-- Obtiene una tabla (index by) con los registros '
           || CHR (10)
           || '   -- de la tabla %TABLA%' ;
    -- con where dinámico.
    -- Observacón: La colección obtenida no tiene límite por lo que podría usar
    -- gran cantidad de memoria
    -- --------------------------------------------------------------------------';
    K_QWT_PROC_NAME             CONSTANT LINEA := 'sel_where';
    K_QWT_PROC1                 CONSTANT LINEA
        :=    'procedure '
           || K_QWT_PROC_NAME
           || ' (p_where IN varchar2, p_%TABLA_NC_PREFIX% IN OUT NOCOPY %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_ct)' ;
    K_QWT_PROC_VAR_L01          CONSTANT LINEA
        := 'type cursor_rc is ref cursor;' ;
    K_QWT_PROC_VAR_L02          CONSTANT LINEA
        := K_PREFIJO_VAR || 'cursor cursor_rc;' ;
    K_QWT_PROC_OPEN             CONSTANT LINEA := 'open v_cursor for';
    K_QWT_PROC_FETCH            CONSTANT LINEA
        := 'fetch v_cursor into p_%TABLA_NC%(p_%TABLA_NC%.COUNT + 1);' ;
    K_QWT_PROC_EXIT             CONSTANT LINEA
                                             := 'exit when v_cursor%NOTFOUND;' ;
    K_QWT_PROC_CLOSE            CONSTANT LINEA := 'CLOSE v_cursor;';
    K_QWT_END                   CONSTANT LINEA := 'end ' || K_QWT_PROC_NAME;

    --*
    --* Constantes para procedimiento de query por sus PK/UK/FK (Query sobre la PK/UK/Fk que retornma un cursor )
    K_QCC_PROC_COM              CONSTANT LINEA
        :=    '-- Obtiene un cursor via una consulta sobre la constraint'
           || CHR (10)
           || '   -- %CONSTRAINT% de la tabla %TABLA%' ;
    K_QCC_PROC_NAME             CONSTANT LINEA := 'sel_%CONSTRAINT_NC%';
    K_QCC_PROC                  CONSTANT LINEA := 'function %NOMBRE_PROGRAMA%';
    K_QCC_PROC_RET1             CONSTANT LINEA
        := 'return %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_rc' ;
    K_QCC_VAR_CURSOR1           CONSTANT LINEA
        := 'cu_%TABLA_NC% %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_rc;' ;
    K_QCC_OPEN_CURSOR           CONSTANT LINEA := 'open cu_%TABLA_NC% for';
    K_QCC_RETURN                CONSTANT LINEA := 'return cu_%TABLA_NC%;';
    K_QCC_END                   CONSTANT LINEA := 'end sel_%CONSTRAINT_NC%';

    --*
    --* Contantes para el procedure ins
    K_INS_PROC_REC_COM          CONSTANT LINEA
        := '-- Inserta un registro de la %TABLA% via un record' ;
    K_INS_PROC_LCO_COM          CONSTANT LINEA
        := '-- Inserta un registro de la %TABLA% via la Lista de Columnas' ;
    K_INS_PROC_COL_COM          CONSTANT LINEA
        :=    '-- Inserta (modo bulk) registros de '
           || CHR (10)
           || '   -- la %TABLA% vía un record de colección de columnas' ;
    K_INS_PROC                  CONSTANT LINEA := 'ins';
    K_INS_PROC_REC_PARM1        CONSTANT LINEA
        := 'p_%TABLA_NC_PREFIX% %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_rt' ;
    K_INS_PROC_COL_PARM1        CONSTANT LINEA
        := 'p_regs %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_ct' ;
    K_INS_PROC_SQL              CONSTANT LINEA := 'insert into %TABLA%';
    K_INS_END                   CONSTANT LINEA := 'end ins';
    K_INS_PROC_COL_COL_COM      CONSTANT LINEA
        :=    '-- Inserta (modo bulk) registros de '
           || CHR (10)
           || '   -- la %TABLA% vía colecciones de columnas' ;

    --*
    --* Contantes para el procedure upd
    K_UPD_PROC_COM              CONSTANT LINEA
        :=    '-- Actualiza un registro de %TABLA% en función '
           || CHR (10)
           || '   -- de la constraint %CONSTRAINT%' ;
    K_UPD_PROC_CALL_COM         CONSTANT LINEA
        := '-- Actualizar registro de %TABLA% en función de la %CONSTRAINT%' ;
    K_UPD_PROC_UPD_CONST        CONSTANT LINEA := 'upd_%CONSTRAINT_NC%';
    K_UPD_PROC_CALL             CONSTANT LINEA := 'upd_%CONSTRAINT_NC%';
    K_UPD_PROC_PARM1            CONSTANT LINEA
        := 'p_%TABLA_NC_PREFIX% IN %NOMBRE_PACKAGE_TIPO%.%TABLA_NC%_rt' ;
    K_UPD_PROC_SQL              CONSTANT LINEA := 'update %TABLA%';
    K_UPD_END                   CONSTANT LINEA := 'end upd_%CONSTRAINT_NC%';

    --*
    --* Update by On Column condition
    K_UOC_PROC_COM              CONSTANT LINEA
        :=    '-- Actualiza una columna de la tabla %TABLA% '
           || CHR (10)
           || '   -- en función de un where dinámico' ;
    K_UOC_PROC                  CONSTANT LINEA := 'upd_por_una_columna';
    K_UOC_PROC_IN_PARM_1        CONSTANT LINEA
                                             := 'p_Nombre_Columna in varchar2' ;
    K_UOC_PROC_IN_PARM_2        CONSTANT LINEA
        := 'p_Valor_Columna in %TIPO_COLUMNA%' ;
    K_UOC_PROC_IN_PARM_3        CONSTANT LINEA := 'p_Where in VARCHAR2';
    --k_uoc_proc_out_parm        CONSTANT linea := 'p_num_regs out NUMBER';
    K_UOC_TYPE_RET              CONSTANT LINEA := 'PLS_INTEGER';
    K_UOC_VAR_RET               CONSTANT LINEA := 'v_num_regs';
    K_UOC_PROC_RET              CONSTANT LINEA := 'RETURN ' || K_UOC_TYPE_RET;
    K_UOC_PROC_RETV             CONSTANT LINEA := 'RETURN ' || K_UOC_VAR_RET;

    K_UOC_EXECUTE_DEL           CONSTANT LINEA
        := 'EXECUTE IMMEDIATE ' || '''' || 'update %TABLA% ' || '''' ;
    K_UOC_SET_COLUMN            CONSTANT LINEA
        := '||''SET '' || P_NOMBRE_COLUMNA || ''= :1 ''' ;
    K_UOC_WHERE                 CONSTANT LINEA
        := '||''WHERE ''|| NVL(P_WHERE, ''1=1'')' ;
    K_UOC_USING                 CONSTANT LINEA := 'USING p_Valor_Columna';
    K_UOC_END                   CONSTANT LINEA := 'end upd_por_una_columna';

    --* Update By Columns Via constraint PK/UK/Fk
    --* *************************************************************************
    K_UBC_PROC_COM              CONSTANT LINEA_LARGA
        :=    '-- Actualiza un conjunto de columnas de la tabla'
           || CHR (10)
           || '   -- %TABLA% en función de la'
           || CHR (10)
           || '   -- constraint %CONSTRAINT%' ;
    -- Cuando el parámetro p_Ignore_Valores_Nulos es FALSE (omisión), los parámetros (columnas) que tiene valor NULL
    -- se actualizan con este valor en la base de datos, en el caso contrario, se ignoran los parámetros (columnas) que
    -- tienen valores nulos, es decir, los parámetros que vienen con valor null no se actualizan';
    --k_ubc_param_ignore_null    CONSTANT linea := k_prefjo_param || 'Ignore_Valores_Nulos';
    --k_ubc_param_in_param       CONSTANT linea
    --   := k_ubc_param_ignore_null || ' IN NUMBER DEFAULT GAT_TYPES.K_DBB_FALSE' ;
    --:= k_ubc_param_ignore_null || ' IN BOOLEAN DEFAULT FALSE' ;
    K_UBC_NOTHING_TO_DO         CONSTANT LINEA
        :=    '-- No se genera el update por '
           || K_CONSTRAINT_PUF
           || ' ya que no hay columnas fuera del constraint' ;

    --* Delete by COnstraint
    --* *************************************************************************
    K_DCO_PROC_COM              CONSTANT LINEA
        :=    '-- Borra registro(s) de %TABLA% en'
           || CHR (10)
           || '   -- función de la constraint %CONSTRAINT%' ;
    K_DCO_PROC                  CONSTANT LINEA := 'del_%CONSTRAINT_NC%';
    --k_dco_proc_out_parm        CONSTANT linea := 'p_num_regs out number';
    K_DCO_TYPE_RET              CONSTANT LINEA := 'SIMPLE_INTEGER';
    K_DCO_VAR_RET               CONSTANT LINEA := 'v_num_regs';
    K_DCO_PROC_RET              CONSTANT LINEA := 'RETURN ' || K_DCO_TYPE_RET;
    K_DCO_PROC_RETV             CONSTANT LINEA := 'RETURN ' || K_DCO_VAR_RET;

    K_DCO_PROC_SQL              CONSTANT LINEA := 'delete %TABLA%';
    K_DCO_END                   CONSTANT LINEA := 'end del_%CONSTRAINT_NC%';

    --* Delete by Dynamic Where
    --* *************************************************************************
    K_DDW_PROC_COM              CONSTANT LINEA
        :=    '-- Borra registro(s) de %TABLA% en '
           || CHR (10)
           || '   -- función de un where dinámico' ;
    K_DDW_PROC                  CONSTANT LINEA := 'del_din';
    K_DDW_PROC_IN_PARM          CONSTANT LINEA := 'p_where in varchar2';
    --k_ddw_proc_out_parm        CONSTANT linea := 'p_num_regs out number';
    K_DDW_TYPE_RET              CONSTANT LINEA := 'PLS_INTEGER';
    K_DDW_VAR_RET               CONSTANT LINEA := 'v_num_regs';
    K_DDW_PROC_RET              CONSTANT LINEA := 'RETURN ' || K_DDW_TYPE_RET;
    K_DDW_PROC_RETV             CONSTANT LINEA := 'RETURN ' || K_DDW_VAR_RET;

    K_DDW_EVAL_NULL_COND        CONSTANT LINEA := 'if p_where is null then';
    K_DDW_EXECUTE_DEL           CONSTANT LINEA
        := 'EXECUTE IMMEDIATE ' || '''' || 'delete %TABLA%' || '''' ;
    K_DDW_EXECUTE_DEL_WW        CONSTANT LINEA
        :=    'EXECUTE IMMEDIATE '
           || ''''
           || 'delete %TABLA% where '' || '
           || 'p_where' ;
    K_DDW_END                   CONSTANT LINEA := 'end del_din';

    --* Delete by One Column condition
    --* *************************************************************************
    K_DOC_PROC_COM              CONSTANT LINEA
        :=    '-- Borra registro(s) de %TABLA% en '
           || CHR (10)
           || '   -- función de una columna especifica' ;
    K_DOC_PROC                  CONSTANT LINEA := 'del_por_una_columna';
    K_DOC_PROC_IN_PARM_1        CONSTANT LINEA
                                             := 'p_Nombre_Columna in varchar2' ;
    K_DOC_PROC_IN_PARM_2        CONSTANT LINEA
        := 'p_Valor_Columna in %TIPO_COLUMNA%' ;
    --k_doc_proc_out_parm        CONSTANT linea := 'p_num_regs out number';

    K_DOC_TYPE_RET              CONSTANT LINEA := 'PLS_INTEGER';
    K_DOC_VAR_RET               CONSTANT LINEA := 'v_num_regs';
    K_DOC_PROC_RET              CONSTANT LINEA := 'RETURN ' || K_UOC_TYPE_RET;
    K_DOC_PROC_RETV             CONSTANT LINEA := 'RETURN ' || K_UOC_VAR_RET;

    K_DOC_EXECUTE_DEL           CONSTANT LINEA
        := 'EXECUTE IMMEDIATE ' || '''' || 'delete %TABLA%' || ''' ||' ;
    K_DOC_WHERE                 CONSTANT LINEA
        :=    ''''
           || ' WHERE '
           || ''''
           || '||'
           || ' P_NOMBRE_COLUMNA '
           || ''
           || '||'''
           || ' = :1'
           || '''' ;
    K_DOC_USING                 CONSTANT LINEA := 'USING p_Valor_Columna';
    K_DOC_END                   CONSTANT LINEA := 'end del_por_una_columna';

    --*
    --* Loop para asignación de lista de record a lista de columnas
    K_FOR_TABLE_COL             CONSTANT LINEA
        := 'FOR indx IN p_regs.FIRST .. p_regs.LAST LOOP' ;
    K_RCOLL_TO_COLLECTION       CONSTANT LINEA
        := K_PREFIJO_VAR || '%COLUMNA_NC%(indx) := p_regs(indx).%COLUMNA%;' ;
    K_FORALL                    CONSTANT LINEA
        := 'FORALL indx IN %COLECCION%.FIRST .. %COLECCION%.LAST' ;

    --*
    --* Comunes

    K_PROCEDURE                 CONSTANT LINEA := 'procedure';
    K_FUNCTION                  CONSTANT LINEA := 'function';
    K_IF                        CONSTANT LINEA := 'if';
    K_ELSE                      CONSTANT LINEA := 'else';
    K_ELSIF                     CONSTANT LINEA := 'elsif';
    K_ENDIF                     CONSTANT LINEA := 'end if';
    K_SELECT                    CONSTANT LINEA := 'select';
    K_LOOP                      CONSTANT LINEA := 'loop';
    K_END_LOOP                  CONSTANT LINEA := 'end loop;';
    K_BEGIN                     CONSTANT LINEA := 'begin';
    K_SET                       CONSTANT LINEA := 'set    ';
    K_THEN                      CONSTANT LINEA := 'then';
    K_EXCEPTION                 CONSTANT LINEA := 'exception';
    K_WHEN                      CONSTANT LINEA := 'when';
    K_WHERE                     CONSTANT LINEA := 'where  ';
    K_AND                       CONSTANT LINEA := 'and   ';
    K_VALUES                    CONSTANT LINEA := 'values';
    K_OTHERS                    CONSTANT LINEA := 'others';
    K_EXC_VALUE_ERROR           CONSTANT LINEA := 'value_error';
    K_RAISE                     CONSTANT LINEA := 'raise';

    --*
    --* Instrucciones específicas
    K_PROG_NEXT_KEY_NAME        CONSTANT LINEA := 'siguiente_clave';
    K_PROG_NEXT_KEY_SPEC        CONSTANT LINEA
        :=    'function '
           || K_PROG_NEXT_KEY_NAME
           || ' (p_secuencia IN VARCHAR2 DEFAULT ''%TABLA%'
           || K_SUFIJO_SECUENCIA
           || ''') '
           || K_NEW_LINE
           || '      RETURN INTEGER' ;
    --   k_prog_next_key_spec       CONSTANT utl_line.static_lines_t
    --      := utl_line.static_lines_t (   'function '
    --                                  || k_prog_next_key_name
    --                                  || ' (p_secuencia IN VARCHAR2 DEFAULT ''%TABLA%_SEC'') '
    --                                  || k_new_line
    --                                  || '   RETURN NUMBER'
    --                                 );
    K_PROG_NEXT_KEY_BODY        CONSTANT UTL_LINE.STATIC_LINES_T
                                             := UTL_LINE.STATIC_LINES_T (
                                                       K_PROG_NEXT_KEY_SPEC
                                                    || ' IS',
                                                    'retval NUMBER;',
                                                    'begin',
                                                    '   EXECUTE IMMEDIATE',
                                                    '      ''SELECT '' || p_secuencia || ''.NEXTVAL FROM DUAL''',
                                                    '        INTO retval;',
                                                    '   RETURN retval;') ;
    --   k_prog_next_key_body       CONSTANT VARCHAR2 (1024)
    --      :=    k_prog_next_key_spec
    --         || k_new_line
    --         || '   IS
    --      retval NUMBER;
    --   begin
    --     EXECUTE IMMEDIATE
    --            ''SELECT '' || p_secuencia || ''.NEXTVAL FROM DUAL''
    --            INTO retval;
    --      RETURN retval;');
    K_PROG_NEXT_KEY_BODY_END    CONSTANT VARCHAR2 (1024)
        := 'end ' || K_PROG_NEXT_KEY_NAME ;
--SUBTYPE program_name_t IS user_objects.object_name%TYPE;
--SUBTYPE package_name_t IS user_objects.object_name%TYPE;
END GAT_DEFS;
/
SHOW ERRORS;


