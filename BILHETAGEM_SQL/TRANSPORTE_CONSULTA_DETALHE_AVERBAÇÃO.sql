--CONSULTAR/ ALTERAR DETALHES DA AVERBA��O
SELECT
	AV.CTL_AVERB AS CTL_AVERB_1 , --1
	(SELECT NUM_APOLI  FROM SEG_PROPOSTA_SEGURO WHERE NUM_PROPT = AVI.NUM_PROPT AND SIT_TIPO_PRS = 1 AND TIP_PROPT = 1) AS NUM_APOLI_2, --2
	AVI.NUM_PROPT AS NUM_PROPT_3, --3
	C.DES_TIPO_AVB AS DES_TIPO_AVB_4,--4
	V1.NOM_FANTS AS NOM_FANTS_5, -- 5
	V1.NOM_PESSO AS NOM_PESSO_5, --5
	V1.COD_DOCUM_PRI AS COD_DOCUM_PRI_5, --5
	R1.SIG_RAMO AS SIG_RAMO_6, --6
	(SELECT NOM_CIA_PAM FROM V_CRP_CIA_SEGURADORA_PAMCARY CSP,SEG_PROPOSTA_SEGURO SPS  WHERE CSP.NUM_CIA_PAM = SPS.NUM_CIA_PAM  AND SPS.NUM_PROPT = AVI.NUM_PROPT ) AS NOM_CIA_PAM_7, --7
	AV.COD_MANIF AS COD_MANIF_8,--8
	AV.DAT_EMBAR AS DAT_EMBAR_9,--9
	(SELECT DES_MERCA FROM MERC_ESPECIFICA WHERE NUM_MERCA = AV.NUM_MERCA ) AS DES_MERCA_10, --10
	AV.DHR_ENTRA AS DHR_ENTRA_10_1, --10.1
	AV.VLR_EMBAR AS VLR_EMBAR_10_2, --10.2
	(SELECT VLR_FATOR_AGR FROM resultado_agrava -- 10.3 
	WHERE ctl_averb = AV.CTL_AVERB
	AND num_fator_agr IN (17)) AS VLR_PREMIO_COBRADO_10_3, --Valor de Pr�mio Cobrado
	(SELECT VLR_FATOR_AGR FROM resultado_agrava --10.4
	WHERE ctl_averb = AV.CTL_AVERB
	AND num_fator_agr IN (20)) AS VLR_SEGURADO_10_4, --Valor Segurado
	(SELECT VLR_FATOR_AGR FROM resultado_agrava -- 10.5
	WHERE ctl_averb = AV.CTL_AVERB
	AND num_fator_agr IN (16)) AS TAXA_FINAL_AGR_10_5, --Taxa Final de Agrava��o (TFA)
	AV.COD_CEP AS COD_CEP_10_6, --10.6
	(SELECT DES_PRACA  FROM PRACA WHERE NUM_PRACA = AV.NUM_PRACA_EMI ) AS DES_PRACA_EMI_10_7, --10.7
	(SELECT DES_PRACA  FROM PRACA WHERE NUM_PRACA = AV.NUM_PRACA_ORI ) AS DES_PRACA_ORI_10_8, --10.8
	AV.DHR_AVERB AS DHR_AVERB_10_9, --10.9 
	S1.DES_SITUA_AVB AS DES_SITUA_AVB_10_10, --10.10
	(SELECT DES_MTSIT_AVB FROM MTSIT_AVERBACAO WHERE TIP_MTSIT_AVB = AV.TIP_MTSIT_AVB) AS DES_MTSIT_AVB_10_11 , --10.11
	AV.DHR_LIBER AS DHR_LIBER_10_13,--10.13
	I.DES_SITUA_TRM AS DES_SITUA_TRM_10_14, --10.14
	P2.COD_DANFE, 
	P2.VLR_DOCUM_DDR, 
	AV.DHR_ALTER AS DHR_ALTER_10_15, --10.15
	AV.COD_USER AS COD_USER_10_16  --10.16
FROM
	CRP_PESSOA V1,
	V_CRP_RAMO_SEGURO R1,
	V_CRP_MOEDA M1,
	SITUACAO_AVERBACAO S1,
	SITUACAO_TRANSM I,
	AVERBACAO AV,
	AVERBACAO_INDICE AVI,
	TIPO_AVERBACAO C
LEFT OUTER JOIN TAVERBACAO_COMPLEM_ATM P2 
                ON
	(P2.CTL_AVERB = AV.CTL_AVERB)
WHERE
	AVI.CTL_AVERB = AV.CTL_AVERB 
	AND V1.CTL_PESSO = AVI.CTL_PESSO
	AND R1.NUM_RAMO_SEG = AVI.NUM_RAMO
	AND M1.NUM_MOEDA = AV.NUM_MOEDA
	AND S1.SIT_AVERB = AVI.SIT_AVERB
	AND AVI.TIP_AVERB = C.TIP_AVERB
	AND AVI.SIT_TRANS = I.SIT_TRANS
	AND AV.CTL_AVERB = 594079427--571571698
	
	
