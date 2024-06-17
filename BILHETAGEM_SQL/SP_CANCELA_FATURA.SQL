CREATE PROCEDURE "BILHET"."SP_CANCELA_FATURA"
  (IN p_seq_numer_fat VARCHAR(10000),
   IN p_qtd_fatura INTEGER,
   IN p_cod_user VARCHAR(50),
   IN p_num_motiv_sit INTEGER,
   OUT v_out_result SMALLINT,
OUT v_out_err_message VARCHAR(255))
 
LANGUAGE SQL
  NOT DETERMINISTIC
  CALLED ON
NULL INPUT
 
MODIFIES SQL DATA
 
INHERIT SPECIAL REGISTERS
BEGIN
   DECLARE v_step INTEGER DEFAULT 0;


DECLARE v_seq_numer_fat BIGINT;


DECLARE v_err_sqlstate CHAR(5) DEFAULT '00000';


DECLARE v_err_message VARCHAR(255) DEFAULT '';


DECLARE v_linha INTEGER DEFAULT 1;


DECLARE SQLSTATE CHAR(5);


DECLARE EXIT HANDLER FOR SQLEXCEPTION
      P1:
   BEGIN
         SET    v_err_sqlstate = SQLSTATE;


SET v_err_message = 'ERRO PROC: SP_CANCELA_FATURA - Passo: ' CONCAT RTRIM(LTRIM(CHAR(v_step))) CONCAT ' - Linha: ' CONCAT v_linha CONCAT ' - SQLSTATE:' CONCAT v_err_sqlstate;


SET v_out_result = -1;


SET v_out_err_message = v_err_message;

END P1;


SET v_step = 1;


WHILE v_linha <= p_qtd_fatura DO
       SET v_step = 2;


SET v_seq_numer_fat = pamais.split(v_linha - 1,
',',
p_seq_numer_fat);


SET v_step = 3;


UPDATE
   bilhet.tbil_fatura
SET    sit_fatur = 3,
   num_motiv_sit = p_num_motiv_sit,
   cod_user = p_cod_user,
   dhr_alter = CURRENT TIMESTAMP
WHERE    seq_numer_fat = v_seq_numer_fat;


UPDATE
   BILHET.TBIL_CONTROLE_ENVIO_COBRANCA
SET    IDT_ENVIO_CBR = 'C',
   STA_ENVIO_CBR = 'S',
   DHR_ALTER = CURRENT TIMESTAMP
WHERE    SEQ_NUMER_FAT = v_seq_numer_fat;


DELETE 
   FROM BILHET.TBIL_RELAC_VISAO_PERCU_PADRA A 
      WHERE A.SEQ_NUMER_PRS NOT IN ( SELECT SEQ_NUMER_PRS FROM GEDAD.V_DAD_CONSULTA_PROCS_PROPT_BILHE )
      AND (A.SEQ_NUMER_PRS, A.SEQ_NUMER_AVB) IN (SELECT B.SEQ_NUMER_PRS, B.SEQ_NUMER_AVB 
                                                   FROM BILHET.V_BIL_AVERBACAO B WHERE B.SEQ_NUMER_FAT IS NULL)
      AND A.SEQ_NUMER_PRS = v_seq_numer_fat;

DELETE 
   FROM BILHET.TBIL_RELAC_VISAO_PERCU_PROPT A 
      WHERE A.SEQ_NUMER_PRS NOT IN ( SELECT SEQ_NUMER_PRS FROM GEDAD.V_DAD_CONSULTA_PROCS_PROPT_BILHE )
      AND (A.SEQ_NUMER_PRS, A.SEQ_NUMER_AVB) IN (SELECT B.SEQ_NUMER_PRS, B.SEQ_NUMER_AVB 
                                                   FROM BILHET.V_BIL_AVERBACAO B WHERE B.SEQ_NUMER_FAT IS NULL)
      AND A.SEQ_NUMER_PRS = v_seq_numer_fat;

DELETE
   FROM BILHET.TBIL_RELAC_VISAO_PROPT A 
      WHERE A.SEQ_NUMER_PRS NOT IN ( SELECT SEQ_NUMER_PRS FROM GEDAD.V_DAD_CONSULTA_PROCS_PROPT_BILHE )
      AND (A.SEQ_NUMER_PRS, A.SEQ_NUMER_AVB) IN (SELECT B.SEQ_NUMER_PRS, B.SEQ_NUMER_AVB 
                                                   FROM BILHET.V_BIL_AVERBACAO B WHERE B.SEQ_NUMER_FAT IS NULL)
      AND A.SEQ_NUMER_PRS = v_seq_numer_fat;

SET v_step = 4;


SET v_linha = v_linha + 1;

END WHILE;


SET v_step = 5;

--SETANDO O STATUS DE FINALIZAÇÃO DA PROCEDURE
  SET v_out_result = 0;

  SET v_out_err_message = '';

  COMMIT;

END
