SELECT * FROM BILHET.TBIL_FATURA tf 
WHERE SEQ_NUMER_FAT = 7000234079

SELECT * FROM bilhet.tbil_relac_visao_percu_propt
SELECT * FROM bilhet.tbil_relac_averb_propt

SELECT * FROM bilhet.TBIL_AVERBACAO ta 
SELECT * FROM BILHET.TBIL_PROPOSTA tp 
WHERE SEQ_NUMER_PRS = 499909

SELECT * FROM BILHET.TBIL_TIPO_TARIFA_PROPOSTA tttp 
WHERE NUM_TARIF IN (36,66, 37)



SELECT *
						    FROM bilhet.tbil_valor_soma_tipo_tarifa a
						    , bilhet.tbil_fatura b
						  WHERE a.seq_numer_fat = 7000234079
							AND a.idt_premi = 'C'
							AND a.num_tarif = 37 --Fluvial
							AND a.vlr_calcu = 0  --Somente se o valor ficar ZERADO
							AND b.seq_numer_fat = a.seq_numer_fat



SELECT  
G.NUM_MES_CPT,
A.seq_numer_avb
,C.SEQ_NUMER_PRS 
,A.NUM_AVERB_PAM
,A.DHR_AVERB
,A.DHR_EMBAR
,A.COD_DOCUM_EMB
, A.SEQ_LOCAL_ORI 
, (SELECT CONCAT (UF.SIG_UNFED, CONCAT('-',  L.NOM_LOCAL))  
	FROM PAMAIS.TCRP_LOCALIDADE L 
		,PAMAIS.TCRP_UNIDADE_FEDERAL UF 
	WHERE UF.NUM_UNFED = L.NUM_UNFED
		AND L.CTL_LOCAL = A.SEQ_LOCAL_ORI
	) AS origem
, (SELECT CONCAT (UF.SIG_UNFED, CONCAT('-',  L.NOM_LOCAL))  
	FROM PAMAIS.TCRP_LOCALIDADE L 
		,PAMAIS.TCRP_UNIDADE_FEDERAL UF 
	WHERE UF.NUM_UNFED = L.NUM_UNFED
		AND L.CTL_LOCAL = A.SEQ_LOCAL_DES
	) AS destino
, (SELECT sig_simbo_moe FROM PAMAIS.TCRP_MOEDA WHERE num_moeda = A.NUM_MOEDA_AVB ) AS sig_simbo_moe 
,A.vlr_embar 
,C.VLR_IS 
,A.STA_FLUVI
,A.IDT_VEICU
,F.nom_apeli_tar
,D.pce_tarif_pec

,B.vlr_tarif_pec

FROM
    BILHET.TBIL_AVERBACAO A
INNER JOIN BILHET.TBIL_RELAC_VISAO_PERCU_PROPT B
ON
  A.SEQ_NUMER_AVB = B.SEQ_NUMER_AVB
 INNER JOIN BILHET.TBIL_RELAC_AVERB_PROPT C 
 ON
 	B.SEQ_NUMER_AVB = C.SEQ_NUMER_AVB  
 AND B.SEQ_NUMER_PRS = C.SEQ_NUMER_PRS 
 
 INNER JOIN BILHET.TBIL_TARIF_PERCU_PROPOSTA D
ON
    D.SEQ_NUMER_PEC = B.SEQ_NUMER_PEC
INNER JOIN BILHET.TBIL_RELAC_TARIFA_PERCURSO E
ON
    E.NUM_TARIF_PEC = D.NUM_TARIF_PEC
INNER JOIN BILHET.TBIL_TIPO_TARIFA_PROPOSTA F
ON
    E.NUM_TARIF = F.NUM_TARIF
INNER JOIN BILHET.TBIL_FATURA G 
ON 
	G.SEQ_NUMER_PRS  = C.SEQ_NUMER_PRS  
WHERE 
	G.SEQ_NUMER_FAT = 7000232361
AND 
	G.NUM_MES_CPT = 202201
 	
	
SELECT * FROM BILHET.TBIL_FATURA tf 
WHERE SEQ_NUMER_PRS =499909


SELECT * FROM bilhet.TBIL_MOVIM_FATURA tmf 
WHERE SEQ_NUMER_FAT = 7000232361

SELECT * FROM bilhet.TBIL_RELAC_VISAO_PROPT trvp 
WHERE SEQ_NUMER_PRS = 499909

SELECT * FROM bilhet.TBIL_RELAC_AVERB_PROPT trap 
		, bilhet.TBIL_RELAC_VISAO_PROPT trvp 
WHERE trap.SEQ_NUMER_PRS = 499909
AND trap.SEQ_NUMER_PRS = trvp.SEQ_NUMER_PRS
AND trap.SEQ_NUMER_AVB = trvp.SEQ_NUMER_AVB 
AND trap.SEQ_NUMER_FAT = 7000232361


SELECT * FROM TDOWNLOAD_ARQUIVO ta 
WHERE NOM_ARQUI like '%7000324203%'

