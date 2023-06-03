CREATE TABLE GAT.FDC_VALORES_GENERALES
(
  ID_VALORES_GENERALES  NUMBER(10)              NOT NULL,
  NOMBRE                VARCHAR2(100 BYTE)      NOT NULL,
  DESCRIPCION           VARCHAR2(4000 BYTE),
  VALOR                 VARCHAR2(2000 BYTE),
  IDENTIFICADOR         VARCHAR2(100 BYTE)      NOT NULL,
  TIPO_VALOR            VARCHAR2(100 BYTE)      DEFAULT 'VARCHAR2(32767)'     NOT NULL,
  FORMATO_VALOR         VARCHAR2(2000 BYTE),
  TIPO_VALOR_RETORNO    VARCHAR2(100 BYTE),
  FEC_INI_VIGENCIA      DATE                    NOT NULL,
  FEC_FIN_VIGENCIA      DATE                    NOT NULL,
  IND_ESTADO            NUMBER(10)              DEFAULT 1                     NOT NULL,
  FEC_ESTADO            DATE                    DEFAULT SYSDATE               NOT NULL,
  ID_ENTIDAD_MULTI      NUMBER(10)              NOT NULL,
  AUD_CREADO_POR        VARCHAR2(40 BYTE)       DEFAULT USER                  NOT NULL,
  AUD_FEC_CREAC         DATE                    DEFAULT SYSDATE               NOT NULL,
  AUD_MODIF_POR         VARCHAR2(40 BYTE),
  AUD_FEC_MODIF         DATE
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
/

COMMENT ON TABLE GAT.FDC_VALORES_GENERALES IS 'Valores Generales de poca modificación. Por ejemplo, %Comisión o % IPC o Cota máxima en UF para Salud. Esta tabla sirve para generar en forma automática el package PKG_VALORES_GENERALES'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.ID_VALORES_GENERALES IS 'Id de Valores Generales'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.NOMBRE IS 'Nombre del parámetro'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.DESCRIPCION IS 'Descripción del Valor'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.VALOR IS 'Valor, puede representar Numericos (por omisión el separador de decimales es una coma ","), texto, fechas'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.IDENTIFICADOR IS 'Identificador del valor'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.TIPO_VALOR IS 'Tipo del valor, VARCHAR2, NUMBER, DATE'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.FORMATO_VALOR IS 'Formato del valor, usado para los campos de tipo DATE, por ejemplo,  DD/MM/YYYY o YYYYMMDD'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.TIPO_VALOR_RETORNO IS 'Tipo del valor de retorno de la función que recupera el valor'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.FEC_INI_VIGENCIA IS 'Fecha de inicio de vigencia'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.FEC_FIN_VIGENCIA IS 'Fecha de fin de vigencia'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.IND_ESTADO IS 'Indicador de estado, 1::= Vigente; 0::= No vigente'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.FEC_ESTADO IS 'Última fecha en la que el IND_ESTADO cambió'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.ID_ENTIDAD_MULTI IS 'Id de Entidad'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.AUD_CREADO_POR IS 'Auditoría: Usuario que creó el registro'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.AUD_FEC_CREAC IS 'Auditoría: Fecha Creación'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.AUD_MODIF_POR IS 'Auditoría: Último usuario que modificó el registro'
/

COMMENT ON COLUMN GAT.FDC_VALORES_GENERALES.AUD_FEC_MODIF IS 'Auditoría: Última Fecha de Modificación'
/



