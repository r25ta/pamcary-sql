/*CONTAGEM DAS FATURAS POR CIA e RAMO*/
SELECT c.CTL_PEJUR_CIA, c.NUM_RAMO_SEG, count(1) total --, a.SEQ_NUMER_FAT , a.SEQ_NUMER_PRS, b.SEQ_NUMER_AVB  
FROM bilhet.TBIL_FATURA a
, bilhet.TBIL_RELAC_AVERB_PROPT b
, bilhet.TBIL_PROPOSTA c
WHERE (a.SEQ_NUMER_FAT, a.SEQ_NUMER_PRS) = (b.SEQ_NUMER_FAT, b.SEQ_NUMER_PRS)
AND c.SEQ_NUMER_PRS = b.SEQ_NUMER_PRS 
AND a.NUM_MES_CPT = 202206
--AND c.NUM_RAMO_SEG IN (1,2)
GROUP BY c.CTL_PEJUR_CIA, c.NUM_RAMO_SEG



/* PROCESSO PARA CANCELAR E DISPONIBILIZAR EM LOTE*/

SELECT a.SEQ_NUMER_FAT , a.SEQ_NUMER_PRS, b.SEQ_NUMER_AVB  
FROM bilhet.TBIL_FATURA a
, bilhet.TBIL_RELAC_AVERB_PROPT b
, bilhet.TBIL_PROPOSTA c
WHERE (a.SEQ_NUMER_FAT, a.SEQ_NUMER_PRS) = (b.SEQ_NUMER_FAT, b.SEQ_NUMER_PRS)
AND c.SEQ_NUMER_PRS = b.SEQ_NUMER_PRS 
AND a.NUM_MES_CPT = 202207
AND c.NUM_RAMO_SEG IN (1,2)
AND c.CTL_PEJUR_CIA = 17341

SELECT * FROM bilhet.TBIL_AVERBACAO_INDICE 
WHERE NUM_AVERB_PAM IN (SELECT x.NUM_AVERB_PAM FROM bilhet.TBIL_AVERBACAO x WHERE x.SEQ_NUMER_AVB = ? ) 


LOOP 
	
UPDATE bilhet.TBIL_FATURA SET 
	NUM_FATUR_CIA  = NULL
	,IDT_ENVIO_CBR = 'C'
	, sit_fatur = 6
	, SIT_ENVIO_FAT = 1
	, num_motiv_sit = 17
	,COD_USER ='ROBO_CANCELAMENTO'
	,DHR_ALTER = CURRENT TIMESTAMP
WHERE F.SEQ_NUMER_FAT = ?


UPDATE
	bilhet.tbil_relac_averb_propt
SET
	seq_numer_fat = NULL,
	num_etapa_avb = 1,
	dhr_alter = CURRENT TIMESTAMP
WHERE
	SEQ_NUMER_PRS = R_CUR.SEQ_NUMER_PRS
	AND SEQ_NUMER_AVB = R_CUR.SEQ_NUMER_AVB;

DELETE
FROM
	bilhet.tbil_relac_visao_percu_padra
WHERE
	seq_numer_prs = r_cur.seq_numer_prs
	AND seq_numer_avb = r_cur.seq_numer_avb;

DELETE
FROM
	bilhet.tbil_relac_visao_percu_propt
WHERE
	seq_numer_prs = r_cur.seq_numer_prs
	AND seq_numer_avb = r_cur.seq_numer_avb;

DELETE
FROM
	bilhet.tbil_relac_visao_propt
WHERE
	seq_numer_prs = r_cur.seq_numer_prs
	AND seq_numer_avb = r_cur.seq_numer_avb;

UPDATE
	bilhet.tbil_averbacao_indice
SET
	sit_trans = 3,
	dhr_alter = CURRENT TIMESTAMP
WHERE NUM_AVERB_PAM IN (SELECT NUM_AVERB_PAM 
							FROM bilhet.TBIL_AVERBACAO 
							WHERE b.SEQ_NUMER_AVB = ? )	