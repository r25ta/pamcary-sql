CREATE PROCEDURE "BILHET"."SP_GERA_TAXA_LIMPEZA_PISTA"
  (IN p_competencia DATE,
   IN p_seq_numer_prs BIGINT,
   IN p_seq_numer_fat BIGINT,
   IN p_cod_user VARCHAR(50),
   IN p_dat_fim_vig DATE,
   OUT v_out_result SMALLINT,
OUT v_out_err_message VARCHAR(255))   
   
 
LANGUAGE SQL
 
DYNAMIC RESULT SETS 1
BEGIN

DECLARE v_limpeza_pista DECIMAL(17,4) DEFAULT 0;

DECLARE v_tarifa_limpeza_pista DECIMAL(17,4) DEFAULT 0;

DECLARE v_total_limpeza_pista  DECIMAL(17,4) DEFAULT 0;

DECLARE v_step INTEGER DEFAULT 0;


DECLARE v_err_message VARCHAR(255) DEFAULT '';


DECLARE SQLSTATE CHAR(5);


DECLARE v_err_sqlstate CHAR(5) DEFAULT '00000';


DECLARE EXIT HANDLER FOR SQLEXCEPTION
      P1:
   BEGIN
         SET    v_err_sqlstate = SQLSTATE;


SET v_err_message = 'ERRO PROC: SP_GERA_TAXA_LIMPEZA_PISTA - Passo: ' CONCAT RTRIM(LTRIM(CHAR(v_step))) CONCAT ' - SQLSTATE:' CONCAT v_err_sqlstate;


SET v_out_result = -1;


SET v_out_err_message = v_err_message;

END P1;


SET v_step = 1;


--  SET v_limpeza_pista = COALESCE(bilhet.fc_tarifa_fatura(p_seq_numer_fat, 90, 'C'), 0);
/*
--VALOR TAXA LIMPEZA PISTA
  SET v_tarifa_limpeza_pista =  (SELECT round(a.VLR_TARIF/100,4) as VLR_TARIF 
                                FROM BILHET.TBIL_VIGENCIA_TAXA_CLIENTE A 
                                ,BILHET.TBIL_RELAC_TAXA_PROPOSTA B
                                ,BILHET.TBIL_TIPO_TARIFA_PROPOSTA C
                                WHERE A.NUM_SEQUE_TAR = B.NUM_SEQUE_TAR 
                                  AND C.NUM_TARIF = B.NUM_TARIF 
                                  AND B.SEQ_NUMER_PRS = p_seq_numer_prs
                                  AND c.NUM_TARIF = 90);
*/

SET v_tarifa_limpeza_pista = COALESCE(bilhet.fc_tarifa_propt(p_seq_numer_prs, 90, p_competencia), 0);

SET v_total_limpeza_pista = (
                              SELECT
                                NVL(SUM(x.vlr_is), 0)
                              FROM
                                (SELECT
                                  DISTINCT d.seq_numer_prs,
                                  d.seq_numer_avb,
                                  d.vlr_is,
                                  c.vlr_tarif_pec
                                FROM
                                  bilhet.tbil_relac_averb_propt d,
                                  bilhet.tbil_averbacao avb,
                                  bilhet.tbil_relac_visao_percu_padra c
                                WHERE
                                  d.seq_numer_prs = p_seq_numer_prs
                                  AND d.seq_numer_fat IS NULL
                                  AND TRUNC(avb.dhr_embar) <= LAST_DAY(p_dat_fim_vig)
                                  AND avb.seq_numer_avb = d.seq_numer_avb
                                  AND d.seq_numer_prs = c.seq_numer_prs
                                  AND d.seq_numer_avb = c.seq_numer_avb 
                                  ) x
                            );
  

SET v_step = 2;

  INSERT INTO bilhet.tbil_valor_soma_tipo_tarifa (seq_numer_fat, num_tarif, idt_premi, vlr_calcu, dhr_alter, cod_user)
  VALUES (p_seq_numer_fat, 90, 'C', (ROUND(v_total_limpeza_pista * v_tarifa_limpeza_pista, 4)), CURRENT TIMESTAMP, p_cod_user);

  
SET v_step = 3;


-- SETANDO O STATUS DE FINALIZAÇÃO DA PROCEDURE
  SET v_out_result = 0;

  SET v_out_err_message = '';

END