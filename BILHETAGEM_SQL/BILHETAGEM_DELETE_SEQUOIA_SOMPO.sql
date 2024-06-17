SELECT * 
FROM bilhet.tbil_relac_averb_propt d
, bilhet.tbil_relac_visao_percu_propt a
, bilhet.tbil_averbacao b
, bilhet.tbil_proposta c
, bilhet.tbil_vencimento_fatura_propt e
, gedad.v_dad_consulta_procs_propt_bilhe f


SELECT * FROM  bilhet.tbil_relac_averb_propt
SELECT * FROM  bilhet.tbil_relac_visao_percu_propt
SELECT * FROM  bilhet.tbil_averbacao

/*PROPOSTAS SEQUOIA PELA SOMPO*/
SELECT *   FROM  bilhet.tbil_proposta
WHERE 1=1
AND CTL_PESSO_CLI = 16674 --SEQUOIA LOGISTICA E TRANSPORTES S A
AND CTL_PEJUR_CIA = 37960 --SOMPO SEGUROS S A


SELECT * 
FROM BILHET.TBIL_FATURA tf
	,bilhet.tbil_proposta tp
	,BILHET.TBIL_RELAC_AVERB_PROPT trap 
	,BILHET.TBIL_RELAC_TAXA_PROPOSTA trtp
WHERE 1=1
AND tp.seq_numer_prs = tf.SEQ_NUMER_PRS 
AND tf.SEQ_NUMER_PRS = trap.SEQ_NUMER_PRS
AND tf.SEQ_NUMER_PRS = trtp.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674 --SEQUOIA LOGISTICA E TRANSPORTES S A
AND tp.CTL_PEJUR_CIA = 37960 --SOMPO SEGUROS S A


/*MAPEAMENTO BILHETAGEM AVERBAÇÃO + PROPOSTA + FATURA*/
--CTL_PESSO_CLI = 16674 --SEQUOIA LOGISTICA E TRANSPORTES S A
--CTL_PEJUR_CIA = 37960 --SOMPO SEGUROS S A

/*Propostas*/
/*11*/
SELECT * FROM bilhet.tbil_proposta tp
WHERE 1=1
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960

/*
 * Quantidades dentro de cada proposta
 * 
 * Propt     Total
 * 498236	4704
 * 487248	2.536.788
 * 487247	2.823.901
 * 491117	4.159.742
 * 488688	7.721.591
 * 488687	8.466.553
 * 496583	26.434.111
 * 496580	26.436.121
 * 496582	26.436.121
 * 
 * */




/*Averbações*/
/*105.019.632*/
/*5 minutos 28segundos*/
SELECT count(*) 
FROM BILHET.TBIL_AVERBACAO ta 
,BILHET.TBIL_RELAC_AVERB_PROPT trap 
WHERE ta.SEQ_NUMER_AVB = trap.SEQ_NUMER_AVB 
AND trap.SEQ_NUMER_PRS IN ( SELECT tp.SEQ_NUMER_PRS 
						 	FROM BILHET.TBIL_PROPOSTA tp
						 	WHERE 1=1
								AND tp.CTL_PESSO_CLI = 16674
								AND tp.CTL_PEJUR_CIA = 37960
							)
/*Averbações*/
/*105.019.632*/
/*2 minutos e 16 segundos*/
/*Mais performatico passando os IDS das propostas*/
SELECT trap.SEQ_NUMER_PRS , count(*) total
FROM BILHET.TBIL_AVERBACAO ta 
,BILHET.TBIL_RELAC_AVERB_PROPT trap 
WHERE ta.SEQ_NUMER_AVB = trap.SEQ_NUMER_AVB 
AND trap.SEQ_NUMER_PRS IN (498236
,496580
,496581
,496582
,496583
,491117
,491118
,488687
,488688
,487247
,487248)
GROUP BY trap.SEQ_NUMER_PRS

/*UPDATE SOMENTE NESSA TABELA */
/*115.093.755*/
SELECT * 
FROM BILHET.TBIL_RELAC_AVERB_PROPT trap
, bilhet.tbil_proposta tp
WHERE 1=1
AND tp.SEQ_NUMER_PRS = trap.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960
AND trap.NUM_ETAPA_AVB = 1
AND tp.SEQ_NUMER_PRS = 498236 --PROPOSTA

/*260*/
SELECT count(*) 
FROM BILHET.TBIL_RELAC_AVERB_PROPT_EXTPO trape 
, bilhet.tbil_proposta tp
WHERE 1=1
AND tp.SEQ_NUMER_PRS = trape.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960


/*40.204.889*/
SELECT count(*) 
FROM BILHET.TBIL_RELAC_VISAO_PROPT trvp
, bilhet.tbil_proposta tp
WHERE 1=1
AND tp.SEQ_NUMER_PRS = trvp.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960

/*0*/
SELECT count(*) 
FROM BILHET.TBIL_RELAC_VISAO_PERCU_PROPT trvpp 
, bilhet.tbil_proposta tp
WHERE 1=1
AND tp.SEQ_NUMER_PRS = trvpp.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960

/*54*/
SELECT count(*) 
FROM BILHET.TBIL_RELAC_TAXA_PROPOSTA trtp
, bilhet.tbil_proposta tp
WHERE 1=1
AND tp.SEQ_NUMER_PRS = trtp.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960

/*0*/
SELECT count(*) 
FROM BILHET.TBIL_RELAC_PROPOSTA_DIVIS_CIA trpdc 
, bilhet.tbil_proposta tp
WHERE 1=1
AND tp.SEQ_NUMER_PRS = trpdc.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960

/*0*/
SELECT count(*) 
FROM BILHET.TBIL_TARIF_PERCU_PROPOSTA ttpp 
, bilhet.tbil_proposta tp
WHERE 1=1
AND tp.SEQ_NUMER_PRS = ttpp.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960

/*32*/
SELECT count(*) 
FROM BILHET.TBIL_PROPOSTA_CREDITO_DEBITO tpcd 
, bilhet.tbil_proposta tp
WHERE 1=1
AND tp.SEQ_NUMER_PRS = tpcd.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960

/*7*/
SELECT count(*) 
FROM BILHET.TBIL_RELAC_TECNICO_PROPOSTA trtp 
, bilhet.tbil_proposta tp
WHERE 1=1
AND tp.SEQ_NUMER_PRS = trtp.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960

/*40.312.136*/
SELECT count(*) 
FROM BILHET.TBIL_RELAC_VISAO_PERCU_PADRA trvpp 
, bilhet.tbil_proposta tp
WHERE 1=1
AND tp.SEQ_NUMER_PRS = trvpp.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960

/*11*/
SELECT count(*) 
FROM BILHET.TBIL_VENCIMENTO_FATURA_PROPT tvfp 
, bilhet.tbil_proposta tp
WHERE 1=1
AND tp.SEQ_NUMER_PRS = tvfp.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960


/*FATURA*/

/*160*/
SELECT count(1) 
FROM BILHET.TBIL_FATURA tf
, bilhet.tbil_proposta tp
WHERE 1=1
AND tp.SEQ_NUMER_PRS = tf.SEQ_NUMER_PRS 
AND tp.CTL_PESSO_CLI = 16674
AND tp.CTL_PEJUR_CIA = 37960

/*0*/
SELECT count(*) 
FROM BILHET.TBIL_FATURA_ARQUIVO tfa
WHERE tfa.SEQ_NUMER_FAT IN (
	SELECT tf.SEQ_NUMER_FAT 
		FROM BILHET.TBIL_FATURA tf
			, bilhet.tbil_proposta tp
		WHERE 1=1
			AND tp.SEQ_NUMER_PRS = tf.SEQ_NUMER_PRS 
			AND tp.CTL_PESSO_CLI = 16674
			AND tp.CTL_PEJUR_CIA = 37960 )


 
/*0*/
SELECT count(*) 
FROM BILHET.TBIL_CONTROLE_ENVIO_COBRANCA tcec 
WHERE tcec.SEQ_NUMER_FAT IN (
	SELECT tf.SEQ_NUMER_FAT 
		FROM BILHET.TBIL_FATURA tf
			, bilhet.tbil_proposta tp
		WHERE 1=1
			AND tp.SEQ_NUMER_PRS = tf.SEQ_NUMER_PRS 
			AND tp.CTL_PESSO_CLI = 16674
			AND tp.CTL_PEJUR_CIA = 37960 )

/*75*/
SELECT count(*) 
FROM BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB tadw
WHERE tadw.SEQ_NUMER_FAT IN (
	SELECT tf.SEQ_NUMER_FAT 
		FROM BILHET.TBIL_FATURA tf
			, bilhet.tbil_proposta tp
		WHERE 1=1
			AND tp.SEQ_NUMER_PRS = tf.SEQ_NUMER_PRS 
			AND tp.CTL_PESSO_CLI = 16674
			AND tp.CTL_PEJUR_CIA = 37960 )

/*2.081*/
SELECT count(*) 
FROM BILHET.TBIL_VALOR_SOMA_TIPO_TARIFA tvstt 
WHERE tvstt.SEQ_NUMER_FAT IN (
	SELECT tf.SEQ_NUMER_FAT 
		FROM BILHET.TBIL_FATURA tf
			, bilhet.tbil_proposta tp
		WHERE 1=1
			AND tp.SEQ_NUMER_PRS = tf.SEQ_NUMER_PRS 
			AND tp.CTL_PESSO_CLI = 16674
			AND tp.CTL_PEJUR_CIA = 37960 )

/*29*/
SELECT count(*) 
FROM BILHET.TBIL_VIGENCIA_PROPOSTA_CREDB tvpc 
WHERE tvpc.SEQ_NUMER_FAT IN (
	SELECT tf.SEQ_NUMER_FAT 
		FROM BILHET.TBIL_FATURA tf
			, bilhet.tbil_proposta tp
		WHERE 1=1
			AND tp.SEQ_NUMER_PRS = tf.SEQ_NUMER_PRS 
			AND tp.CTL_PESSO_CLI = 16674
			AND tp.CTL_PEJUR_CIA = 37960 )

