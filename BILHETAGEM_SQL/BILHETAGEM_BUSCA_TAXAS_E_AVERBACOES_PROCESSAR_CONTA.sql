/*TAXA_PERCURSO*/
/*** TARIFAS 
RCTRC(1, true), 
    RCTVI(2, true), 
    RCTAC(8, true), 
    RCFDC_CME(3, true), 
    RCFDC_SME(4, true), 
    TRNAC_A(5, true), 
    TRNAC_B(6, true), 
    TRNAC_C(7, true), 
    RCTRC_PU(9, true), 
    TRNAC_A_PU(10, true), 
    TAXA_ROUBO(15, false), 
    TAXA_UNICA(16, false), 
    TRNAC_B_PU(31, true), 
    TRNAC_C_PU(32, true), 
    OCD(33, false), 
    OCDI(34, false), 
    VPT(35, false), 
    FLUVIAL(37, false), 
    VPN(38, false), 
    VPU(39, false),
    AVARIA(14, false),
    LIMPEZA_PISTA(90,false),
    TAXA_EMBARCADOR(91,false),
    CONCENTRACAO_RISCO(53, true), 
    PERNA_RODOVIARIA_ORIGEM(36, false), 
    PERNA_RODOVIARIA_DESTINO(66, false), 
    TAXA_COMERCIAL_INTERNACIONAL(74, false);

NUM_TARIF IN (1, 2, 8, 3, 4, 5, 6, 7, 9, 10, 15, 16, 31, 32, 33, 34, 35, 37, 38, 39, 14, 90, 91, 53, 36, 66, 74)

PERIODO DAT_INICIO = '2023-04-01 00:00:00' AND DAT_FIM = '2023-05-31 23:59:59'
**/

SELECT
	tarifaperc0_.CTL_VIGEN_PEC AS CTL_VIGE1_15_0_,
	tarifaperc1_.NUM_TARIF_PEC AS NUM_TARI1_5_1_,
	tipotarifa2_.NUM_TARIF AS NUM_TARI1_11_2_,
	localidade3_.SEQ_NUMER_LOC AS SEQ_NUME1_16_3_,
	localidade4_.SEQ_NUMER_LOC AS SEQ_NUME1_16_4_,
	tarifaperc0_.NUM_TARIF_PEC AS NUM_TARI7_15_0_,
	tarifaperc0_.VLR_LIMIT_INF AS VLR_LIMI2_15_0_,
	tarifaperc0_.VLR_LIMIT_SPE AS VLR_LIMI3_15_0_,
	tarifaperc0_.DAT_FIM_VIG AS DAT_FIM_4_15_0_,
	tarifaperc0_.DAT_INICI_VIG AS DAT_INIC5_15_0_,
	tarifaperc0_.PCE_TARIF_PEC AS PCE_TARI6_15_0_,
	tarifaperc1_.SEQ_LOCAL_DES AS SEQ_LOCA2_5_1_,
	tarifaperc1_.SEQ_LOCAL_ORI AS SEQ_LOCA3_5_1_,
	tarifaperc1_.NUM_TARIF AS NUM_TARI4_5_1_,
	tipotarifa2_.PCE_MULTI_TAR AS PCE_MULT2_11_2_,
	localidade3_.COD_IDENT_PAD AS COD_IDEN2_16_3_,
	localidade3_.SEQ_LOCAL_PAI AS SEQ_LOCA6_16_3_,
	localidade3_.STA_NINFO AS STA_NINF3_16_3_,
	localidade3_.STA_URSUB AS STA_URSU4_16_3_,
	localidade3_.TIP_LOCAL AS TIP_LOCA5_16_3_,
	localidade4_.COD_IDENT_PAD AS COD_IDEN2_16_4_,
	localidade4_.SEQ_LOCAL_PAI AS SEQ_LOCA6_16_4_,
	localidade4_.STA_NINFO AS STA_NINF3_16_4_,
	localidade4_.STA_URSUB AS STA_URSU4_16_4_,
	localidade4_.TIP_LOCAL AS TIP_LOCA5_16_4_
FROM
	BILHET.TBIL_VIGEN_TARIFA_PERCURSO tarifaperc0_
INNER JOIN BILHET.TBIL_RELAC_TARIFA_PERCURSO tarifaperc1_ ON
	tarifaperc0_.NUM_TARIF_PEC = tarifaperc1_.NUM_TARIF_PEC
INNER JOIN BILHET.TBIL_TIPO_TARIFA_PROPOSTA tipotarifa2_ ON
	tarifaperc1_.NUM_TARIF = tipotarifa2_.NUM_TARIF
INNER JOIN BILHET.V_BIL_LOCALIDADE localidade3_ ON
	tarifaperc1_.SEQ_LOCAL_ORI = localidade3_.SEQ_NUMER_LOC
INNER JOIN BILHET.V_BIL_LOCALIDADE localidade4_ ON
	tarifaperc1_.SEQ_LOCAL_DES = localidade4_.SEQ_NUMER_LOC
WHERE
	((tarifaperc0_.DAT_INICI_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
		AND (tarifaperc0_.DAT_FIM_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
			OR (tarifaperc0_.DAT_INICI_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
				AND (tarifaperc0_.DAT_FIM_VIG NOT BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
					OR (tarifaperc0_.DAT_INICI_VIG NOT BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
						AND (tarifaperc0_.DAT_FIM_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
							OR tarifaperc0_.DAT_INICI_VIG<'2023-12-01 00:00:00'
							AND tarifaperc0_.DAT_FIM_VIG>'2023-12-31 23:59:59')
	AND (tipotarifa2_.NUM_TARIF IN (1, 2, 8, 3, 4, 5, 6, 7, 9, 10, 15, 16, 31, 32, 33, 34, 35, 37, 38, 39, 14, 90, 91, 53, 36, 66, 74))


SELECT
	DISTINCT vigenciata0_.NUM_SEQUE_VIG AS NUM_SEQU1_14_0_,
	tarifaprop1_.NUM_SEQUE_TAR AS NUM_SEQU1_6_1_,
	tipotarifa2_.NUM_TARIF AS NUM_TARI1_11_2_,
	vigenciata0_.NUM_SEQUE_TAR AS NUM_SEQU2_14_0_,
	vigenciata0_.VLR_TARIF AS VLR_TARI3_14_0_,
--	vigenciata0_.STA_AGREGA_FILIAL AS STA_AGRE4_14_0_,
	vigenciata0_.DAT_FIM_VIG AS DAT_FIM_5_14_0_,
	vigenciata0_.DAT_INICI_VIG AS DAT_INIC6_14_0_,
--	tarifaprop1_.COD_CNPJ_EMBARCADOR AS COD_CNPJ2_6_1_,
	tarifaprop1_.SEQ_NUMER_PRS AS SEQ_NUME3_6_1_,
	tarifaprop1_.NUM_TARIF AS NUM_TARI4_6_1_,
	tipotarifa2_.PCE_MULTI_TAR AS PCE_MULT2_11_2_
FROM
	BILHET.TBIL_VIGENCIA_TAXA_CLIENTE vigenciata0_
INNER JOIN BILHET.TBIL_RELAC_TAXA_PROPOSTA tarifaprop1_ ON
	vigenciata0_.NUM_SEQUE_TAR = tarifaprop1_.NUM_SEQUE_TAR
INNER JOIN BILHET.TBIL_TIPO_TARIFA_PROPOSTA tipotarifa2_ ON
	tarifaprop1_.NUM_TARIF = tipotarifa2_.NUM_TARIF
WHERE
	((vigenciata0_.DAT_INICI_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
		AND (vigenciata0_.DAT_FIM_VIG BETWEEN '2023-04-12 00:00:00' AND '2023-12-31 23:59:59')
			OR (vigenciata0_.DAT_INICI_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
				AND (vigenciata0_.DAT_FIM_VIG NOT BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
					OR (vigenciata0_.DAT_INICI_VIG NOT BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
						AND (vigenciata0_.DAT_FIM_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
							OR vigenciata0_.DAT_INICI_VIG<'2023-12-01 00:00:00'
							AND vigenciata0_.DAT_FIM_VIG>'2023-12-31 23:59:59')
	AND (tipotarifa2_.NUM_TARIF IN (1, 2, 8, 3, 4, 5, 6, 7, 9, 10, 15, 16, 31, 32, 33, 34, 35, 37, 38, 39, 14, 90, 91, 53, 36, 66, 74))	
	

SELECT
	tarifaperc0_.SEQ_NUMER_PEC AS SEQ_NUME1_10_0_,
	tarifaperc1_.NUM_TARIF_PEC AS NUM_TARI1_5_1_,
	tipotarifa2_.NUM_TARIF AS NUM_TARI1_11_2_,
	localidade3_.SEQ_NUMER_LOC AS SEQ_NUME1_16_3_,
	localidade4_.SEQ_NUMER_LOC AS SEQ_NUME1_16_4_,
	tarifaperc0_.NUM_TARIF_PEC AS NUM_TARI8_10_0_,
	tarifaperc0_.VLR_LIMIT_INF AS VLR_LIMI2_10_0_,
	tarifaperc0_.VLR_LIMIT_SPE AS VLR_LIMI3_10_0_,
	tarifaperc0_.DAT_FIM_VIG AS DAT_FIM_4_10_0_,
	tarifaperc0_.DAT_INICI_VIG AS DAT_INIC5_10_0_,
	tarifaperc0_.SEQ_NUMER_PRS AS SEQ_NUME6_10_0_,
	tarifaperc0_.PCE_TARIF_PEC AS PCE_TARI7_10_0_,
	tarifaperc1_.SEQ_LOCAL_DES AS SEQ_LOCA2_5_1_,
	tarifaperc1_.SEQ_LOCAL_ORI AS SEQ_LOCA3_5_1_,
	tarifaperc1_.NUM_TARIF AS NUM_TARI4_5_1_,
	tipotarifa2_.PCE_MULTI_TAR AS PCE_MULT2_11_2_,
	localidade3_.COD_IDENT_PAD AS COD_IDEN2_16_3_,
	localidade3_.SEQ_LOCAL_PAI AS SEQ_LOCA6_16_3_,
	localidade3_.STA_NINFO AS STA_NINF3_16_3_,
	localidade3_.STA_URSUB AS STA_URSU4_16_3_,
	localidade3_.TIP_LOCAL AS TIP_LOCA5_16_3_,
	localidade4_.COD_IDENT_PAD AS COD_IDEN2_16_4_,
	localidade4_.SEQ_LOCAL_PAI AS SEQ_LOCA6_16_4_,
	localidade4_.STA_NINFO AS STA_NINF3_16_4_,
	localidade4_.STA_URSUB AS STA_URSU4_16_4_,
	localidade4_.TIP_LOCAL AS TIP_LOCA5_16_4_
FROM
	BILHET.TBIL_TARIF_PERCU_PROPOSTA tarifaperc0_
INNER JOIN BILHET.TBIL_RELAC_TARIFA_PERCURSO tarifaperc1_ ON
	tarifaperc0_.NUM_TARIF_PEC = tarifaperc1_.NUM_TARIF_PEC
INNER JOIN BILHET.TBIL_TIPO_TARIFA_PROPOSTA tipotarifa2_ ON
	tarifaperc1_.NUM_TARIF = tipotarifa2_.NUM_TARIF
INNER JOIN BILHET.V_BIL_LOCALIDADE localidade3_ ON
	tarifaperc1_.SEQ_LOCAL_ORI = localidade3_.SEQ_NUMER_LOC
INNER JOIN BILHET.V_BIL_LOCALIDADE localidade4_ ON
	tarifaperc1_.SEQ_LOCAL_DES = localidade4_.SEQ_NUMER_LOC
WHERE
	((tarifaperc0_.DAT_INICI_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
		AND (tarifaperc0_.DAT_FIM_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
			OR (tarifaperc0_.DAT_INICI_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
				AND (tarifaperc0_.DAT_FIM_VIG NOT BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
					OR (tarifaperc0_.DAT_INICI_VIG NOT BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
						AND (tarifaperc0_.DAT_FIM_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
							OR tarifaperc0_.DAT_INICI_VIG<'2023-12-01 00:00:00'
							AND tarifaperc0_.DAT_FIM_VIG>'2023-12-31 23:59:59')
	AND (tipotarifa2_.NUM_TARIF IN (1, 2, 8, 3, 4, 5, 6, 7, 9, 10, 15, 16, 31, 32, 33, 34, 35, 37, 38, 39, 14, 90, 91, 53, 36, 66, 74))


	SELECT
	averbacao0_.SEQ_NUMER_AVB AS SEQ_NUME1_4_0_,
	proposta1_.SEQ_NUMER_PRS AS SEQ_NUME1_3_1_,
	fatura5_.SEQ_NUMER_FAT AS SEQ_NUME1_2_2_,
	vencimento6_.SEQ_NUMER_PRS AS SEQ_NUME1_13_3_,
	averbacaoi2_.NUM_AVERB_PAM AS NUM_AVER1_1_4_,
	localidade3_.SEQ_NUMER_LOC AS SEQ_NUME1_16_5_,
	localidade4_.SEQ_NUMER_LOC AS SEQ_NUME1_16_6_,
	averbacao0_.NUM_ETAPA_AVB AS NUM_ETAP2_4_0_,
	averbacao0_.SEQ_NUMER_PRS AS SEQ_NUME4_4_0_,
	averbacao0_.VLR_IS AS VLR_IS3_4_0_,
--	averbacao0_1_.COD_CNPJ_EMITENTE AS COD_CNPJ1_0_0_,
--	averbacao0_1_.COD_CNPJ_RESPONSAVEL AS COD_CNPJ2_0_0_,
--	averbacao0_1_.COD_CNPJ_TOMADOR AS COD_CNPJ3_0_0_,
	averbacao0_1_.DHR_EMBAR AS DHR_EMBA4_0_0_,
	averbacao0_1_.SEQ_LOCAL_DES AS SEQ_LOC13_0_0_,
	averbacao0_1_.STA_AVARI AS STA_AVAR5_0_0_,
	averbacao0_1_.IDT_TARIF AS IDT_TARI6_0_0_,
	averbacao0_1_.STA_FLUVI AS STA_FLUV7_0_0_,
	averbacao0_1_.NUM_AVERB_PAM AS NUM_AVE14_0_0_,
	averbacao0_1_.SEQ_LOCAL_INT AS SEQ_LOC15_0_0_,
	averbacao0_1_.SEQ_LOCAL_ORI AS SEQ_LOC16_0_0_,
	averbacao0_1_.STA_PERNA_DES AS STA_PERN8_0_0_,
	averbacao0_1_.STA_PERNA_ORI AS STA_PERN9_0_0_,
	averbacao0_1_.IDT_CARGA_DSC AS IDT_CAR10_0_0_,
	averbacao0_1_.TIP_ISENC_SEG AS TIP_ISE11_0_0_,
	averbacao0_1_.IDT_VEICU AS IDT_VEI12_0_0_,
	proposta1_.CTL_PEJUR_CIA AS CTL_PEJU2_3_1_,
	proposta1_.NUM_COBER_BAS AS NUM_COBE3_3_1_,
	proposta1_.CTL_PESSO_CLI AS CTL_PESS4_3_1_,
	proposta1_.DAT_FIM_VIG AS DAT_FIM_5_3_1_,
	proposta1_.NUM_APOLI AS NUM_APOL6_3_1_,
	proposta1_.NUM_PERIO AS NUM_PERI7_3_1_,
	proposta1_.NUM_RAMO_SEG AS NUM_RAMO8_3_1_,
	proposta1_.NUM_ETAPA_PRS AS NUM_ETAP9_3_1_,
	proposta1_.TIP_AVERB AS TIP_AVE10_3_1_,
	proposta1_.TIP_NEGOC AS TIP_NEG11_3_1_,
	fatura5_.DHR_FATUR AS DHR_FATU2_2_2_,
	fatura5_.DAT_VENCI_FAT AS DAT_VENC3_2_2_,
	fatura5_.NUM_MES_CPT AS NUM_MES_4_2_2_,
	fatura5_.SIT_FATUR AS SIT_FATU5_2_2_,
	fatura5_.SEQ_NUMER_PRS AS SEQ_NUME6_2_2_,
	fatura5_.SEQ_NUMER_PRS AS SEQ_NUME6_3_0__,
	fatura5_.SEQ_NUMER_FAT AS SEQ_NUME1_2_0__,
	vencimento6_.NUM_DIA_VEC AS NUM_DIA_2_13_3_,
	vencimento6_.NUM_PERIO_FAT AS NUM_PERI3_13_3_,
	averbacaoi2_.SIT_TRANS AS SIT_TRAN2_1_4_,
	averbacaoi2_.VLR_EMBAR_TOT AS VLR_EMBA3_1_4_,
	averbacaoi2_.VLR_PAMTX AS VLR_PAMT4_1_4_,
	localidade3_.COD_IDENT_PAD AS COD_IDEN2_16_5_,
	localidade3_.SEQ_LOCAL_PAI AS SEQ_LOCA6_16_5_,
	localidade3_.STA_NINFO AS STA_NINF3_16_5_,
	localidade3_.STA_URSUB AS STA_URSU4_16_5_,
	localidade3_.TIP_LOCAL AS TIP_LOCA5_16_5_,
	localidade4_.COD_IDENT_PAD AS COD_IDEN2_16_6_,
	localidade4_.SEQ_LOCAL_PAI AS SEQ_LOCA6_16_6_,
	localidade4_.STA_NINFO AS STA_NINF3_16_6_,
	localidade4_.STA_URSUB AS STA_URSU4_16_6_,
	localidade4_.TIP_LOCAL AS TIP_LOCA5_16_6_
FROM
	BILHET.TBIL_RELAC_AVERB_PROPT averbacao0_
LEFT OUTER JOIN BILHET.TBIL_AVERBACAO averbacao0_1_ ON
	averbacao0_.SEQ_NUMER_AVB = averbacao0_1_.SEQ_NUMER_AVB
INNER JOIN BILHET.TBIL_PROPOSTA proposta1_ ON
	averbacao0_.SEQ_NUMER_PRS = proposta1_.SEQ_NUMER_PRS
LEFT OUTER JOIN BILHET.TBIL_FATURA fatura5_ ON
	proposta1_.SEQ_NUMER_PRS = fatura5_.SEQ_NUMER_PRS
LEFT OUTER JOIN BILHET.TBIL_VENCIMENTO_FATURA_PROPT vencimento6_ ON
	fatura5_.SEQ_NUMER_PRS = vencimento6_.SEQ_NUMER_PRS
INNER JOIN BILHET.TBIL_AVERBACAO_INDICE averbacaoi2_ ON
	averbacao0_1_.NUM_AVERB_PAM = averbacaoi2_.NUM_AVERB_PAM
LEFT OUTER JOIN BILHET.V_BIL_LOCALIDADE localidade3_ ON
	averbacao0_1_.SEQ_LOCAL_ORI = localidade3_.SEQ_NUMER_LOC
LEFT OUTER JOIN BILHET.V_BIL_LOCALIDADE localidade4_ ON
	averbacao0_1_.SEQ_LOCAL_DES = localidade4_.SEQ_NUMER_LOC
WHERE
	averbacao0_1_.DHR_EMBAR <='2023-12-31'
	AND proposta1_.NUM_APOLI =3836900435121
	AND averbacao0_.NUM_ETAPA_AVB =1
	AND proposta1_.NUM_APOLI>0
	AND proposta1_.NUM_PERIO =3
--	AND proposta1_.NUM_RAMO_SEG = 1	
--	AND fatura5_.SIT_FATUR NOT IN (2,8,4,6)
--	AND averbacao0_.SEQ_NUMER_FAT IS NULL
ORDER BY SEQ_NUME1_4_0_
	

SELECT * FROM bilhet.TBIL_SITUACAO_FATURA tsf 

SELECT
	propostata0_.SEQ_NUMER_PRS AS SEQ_NUME2_3_1_,
	propostata0_.NUM_SEQUE_TAR AS NUM_SEQU1_17_1_,
	propostata0_.NUM_SEQUE_TAR AS NUM_SEQU1_17_0_,
	propostata0_.SEQ_NUMER_PRS AS SEQ_NUME2_17_0_,
	propostata0_.NUM_TARIF AS NUM_TARI3_17_0_,
	propostata0_.VLR_TARIF AS VLR_TARI4_17_0_,
	propostata0_.DAT_FIM_VIG AS DAT_FIM_5_17_0_,
	propostata0_.DAT_INICI_VIG AS DAT_INIC6_17_0_
FROM
	BILHET.V_BIL_PROPOSTA_TAXA_APLICAVEL propostata0_
WHERE
	( (propostata0_.DAT_INICI_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59'
		AND propostata0_.DAT_FIM_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
	OR (propostata0_.DAT_INICI_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59'
		AND propostata0_.DAT_FIM_VIG NOT BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
	OR (propostata0_.DAT_INICI_VIG NOT BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59'
		AND propostata0_.DAT_FIM_VIG BETWEEN '2023-12-01 00:00:00' AND '2023-12-31 23:59:59')
	OR (propostata0_.DAT_INICI_VIG < '2023-12-01'
		AND propostata0_.DAT_FIM_VIG > '2023-12-31') )
	AND propostata0_.NUM_TARIF IN (1, 2, 8, 3, 4, 5, 6, 7, 9, 10, 15, 16, 31, 32, 33, 34, 35, 37, 38, 39, 14, 90, 91, 53, 36, 66, 74)
	AND propostata0_.SEQ_NUMER_PRS =506250
	
	
	
	SELECT a.SEQ_NUMER_FAT
		,a.NUM_TARIF 
		,b.NOM_APELI_TAR 
		,a.VLR_CALCU 
		,b.PCE_MULTI_TAR 
		,a.VLR_CALCU 
		,a.IDT_PREMI 
		FROM BILHET.TBIL_VALOR_SOMA_TIPO_TARIFA a INNER join bilhet.TBIL_TIPO_TARIFA_PROPOSTA b
	on b.NUM_TARIF = a.NUM_TARIF 
	WHERE a.SEQ_NUMER_FAT = 7000315723
	
SELECT
   7000313987,
   69,
   'A',
   nvl(sum(x.vlr_is), 0),
   'v_data_procs',
   'p_cod_user'
FROM    (
   SELECT
       DISTINCT d.seq_numer_prs,
                                  d.seq_numer_avb,
                                  d.vlr_is
   FROM        bilhet.tbil_relac_averb_propt d,
                                  bilhet.tbil_averbacao avb,
                                  bilhet.tbil_relac_visao_percu_padra c
   WHERE        d.seq_numer_prs = 506250
       AND d.seq_numer_fat IS NULL
       AND trunc(avb.dhr_embar) <= last_day('2023-12-31')
           AND avb.seq_numer_avb = d.seq_numer_avb
           AND d.seq_numer_prs = c.seq_numer_prs
           AND d.seq_numer_avb = c.seq_numer_avb ) x ;	
	
SELECT * FROM bilhet.tbil_relac_averb_propt d 
INNER JOIN bilhet.tbil_averbacao avb
ON avb.SEQ_NUMER_AVB = d.SEQ_NUMER_AVB 
WHERE d.SEQ_NUMER_PRS = 506250
AND d.seq_numer_fat IS NULL


SELECT * FROM bilhet.tbil_relac_visao_percu_padra c
WHERE c.SEQ_NUMER_PRS =  506250
AND c.SEQ_NUMER_AVB  IN (SELECT d.SEQ_NUMER_AVB FROM bilhet.tbil_relac_averb_propt d 
INNER JOIN bilhet.tbil_averbacao avb
ON avb.SEQ_NUMER_AVB = d.SEQ_NUMER_AVB 
WHERE d.SEQ_NUMER_PRS = 506250
AND d.seq_numer_fat IS NULL
)



	SELECT * FROM bilhet.TBIL_RELAC_TAXA_PROPOSTA trtp 
	WHERE SEQ_NUMER_PRS = 506250

SELECT * FROM bilhet.TBIL_TIPO_TARIFA_PROPOSTA tttp 
WHERE NUM_TARIF IN (16,
19,
52,
63)


SELECT * FROM SEGURO.V_SEG_PROPOSTA_SEGURO vsps 
WHERE NUM_APOLI = 3836900435121

