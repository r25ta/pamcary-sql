CREATE TRIGGER DBPROD.TR_AU_TAVERBACAO_COMPLEM_ATM 
AFTER
UPDATE
    ON
    DBPROD.TAVERBACAO_COMPLEM_ATM REFERENCING
NEW AS c_new OLD AS c_old FOR EACH ROW MODE
DB2SQL
BEGIN
        ATOMIC
DECLARE v_sit_trans SMALLINT DEFAULT 0;
--
DECLARE v_sit_averb  SMALLINT DEFAULT 0;--
DECLARE v_flag       SMALLINT DEFAULT 0;--
DECLARE v_ctl_averb  BIGINT   DEFAULT 0;--
-- A PARTIR DO DIA 16/11/2015, NÃO SERÁ MAIS GERADO LOG PARA DATAS MENORES QUE 01/09/2015
-- A PARTIR DO DIA 22/02/2016, NÃO SERÁ MAIS GERADO LOG PARA DATAS MENORES QUE 01/02/2016
IF c_new.DHR_ALTER >= DATE('01/02/2016') THEN
                SET ( v_sit_trans, v_sit_averb ) = (
                               SELECT
                                               sit_trans,
                                               sit_averb
                               FROM
                                               DBPROD.taverbacao_indice
                               WHERE
                                               ctl_averb = c_new.ctl_averb
                );--
                CALL BILHET.SP_BIL_INSERE_LOG( c_new.ctl_averb, v_sit_trans, v_sit_averb, v_sit_trans, v_sit_averb, v_flag, 'TR_AU_TAVERBACAO_COMPLEM_ATM' );--

END IF;--
END