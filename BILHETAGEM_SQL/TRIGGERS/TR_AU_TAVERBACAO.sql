CREATE TRIGGER DBPROD.TR_AU_TAVERBACAO
AFTER
UPDATE
    ON
    DBPROD.TAVERBACAO REFERENCING
NEW AS c_new OLD AS c_old FOR EACH ROW MODE
DB2SQL
BEGIN
        ATOMIC
DECLARE v_sit_trans SMALLINT DEFAULT 0;
--
DECLARE v_sit_averb  SMALLINT DEFAULT 0;--
DECLARE v_flag       SMALLINT DEFAULT 0;--
DECLARE v_ctl_averb  BIGINT   DEFAULT 0;--
---- insere na tabela de log para carga do BI ----
set v_ctl_averb = c_new.ctl_averb; -- alterei
INSERT INTO  DBPROD.TAVERBACAO_LOG_BI (CTL_AVERB,DHR_CADAS )
SELECT v_ctl_averb AS CTL_AVERB, CURRENT_DATE AS DHR_CADAS  --alterei
FROM DBPROD.DUAL
WHERE v_ctl_averb NOT IN (SELECT CTL_AVERB FROM DBPROD.TAVERBACAO_LOG_BI ) ;--alterei

-- A PARTIR DO DIA 16/11/2015, NÃO SERÁ MAIS GERADO LOG PARA DATAS MENORES QUE 01/09/2015
-- A PARTIR DO DIA 22/02/2016, NÃO SERÁ MAIS GERADO LOG PARA DATAS MENORES QUE 01/02/2016
IF c_new.DAT_EMBAR >= DATE('01/02/2016') THEN
                SET ( v_sit_trans, v_sit_averb ) = (
                               SELECT
                                               sit_trans,
                                               sit_averb
                               FROM
                                               DBPROD.taverbacao_indice
                               WHERE
                                               ctl_averb = c_new.ctl_averb
                );--
                CALL BILHET.SP_BIL_INSERE_LOG( c_new.ctl_averb, v_sit_trans, v_sit_averb, v_sit_trans, v_sit_averb, v_flag, 'TR_AU_TAVERBACAO' );--

END IF;--
END