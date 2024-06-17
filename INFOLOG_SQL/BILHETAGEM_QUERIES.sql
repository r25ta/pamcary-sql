/*
	Select executado na consulta 
*/

select * from bilhet.tbil_fatura


SELECT bilhet.tBIL_PROPOSTA.*,
	   bilhet.tBIL_FATURA.*
FROM bilhet.TBIL_PROPOSTA
LEFT OUTER JOIN bilhet.tBIL_FATURA ON bilhet.tBIL_PROPOSTA.SEQ_NUMER_PRS = bilhet.tBIL_FATURA.SEQ_NUMER_PRS 
INNER JOIN APLBIL.V_CRP_PESSOA pessoa2_ ON bilhet.tBIL_PROPOSTA.CTL_PESSO_CLI = pessoa2_.CTL_PESSO 
WHERE bilhet.tBIL_PROPOSTA.SEQ_NUMER_PRS = bilhet.tBIL_PROPOSTA.SEQ_NUMER_PRS 
  --AND bilhet.tBIL_FATURA.SIT_ENVIO_FAT = 1 /*Situacao Proposta*/
  --AND ( bilhet.tBIL_FATURA.SIT_FATUR NOT IN(3,6) ) 
  
  --CLAUSULA ESPECIAL PARA RETORNAR A DUPLICIDADE NO GRID
  AND bilhet.tBIL_PROPOSTA.SEQ_NUMER_PRS = '489320'
  
ORDER BY pessoa2_.NOM_FANTS asc,
         bilhet.tBIL_FATURA.NUM_MES_CPT desc,
         bilhet.tBIL_FATURA.SEQ_NUMER_FAT
		 
/*------------------------------------------------------------------------------------------------------*/
/*
	SELECT executado para consultar os detalhes
*/

SELECT bilhet.tBIL_FATURA.*
FROM bilhet.tBIL_FATURA
WHERE bilhet.tBIL_FATURA.SEQ_NUMER_FAT = '7000133974'

/*------------------------------------------------------------------------------------------------------*/

SELECT bilhet.tBIL_PROPOSTA.SEQ_NUMER_PRS as SEQ_NUME1_21_0_,
       bilhet.tBIL_PROPOSTA.CTL_PESSO_CLI as CTL_PESS3_21_0_,
       bilhet.tBIL_PROPOSTA.CTL_PEJUR_CIA as CTL_PEJU2_21_0_,
       bilhet.tBIL_PROPOSTA.CTL_PESSO_COG as CTL_PESS4_21_0_,
       bilhet.tBIL_PROPOSTA.CTL_CORRE as CTL_CORR5_21_0_,
       bilhet.tBIL_PROPOSTA.CTL_SUCUR as CTL_SUCU6_21_0_,
       bilhet.tBIL_PROPOSTA.DHR_ALTER as DHR_ALTE7_21_0_,
       bilhet.tBIL_PROPOSTA.DAT_FIM_VIG as DAT_FIM_8_21_0_,
       bilhet.tBIL_PROPOSTA.TIP_NEGOC as TIP_NEGO9_21_0_,
       bilhet.tBIL_PROPOSTA.DAT_INICI_VIG as DAT_INI10_21_0_,
       bilhet.tBIL_PROPOSTA.NUM_ETAPA_PRS as NUM_ETA11_21_0_,
       bilhet.tBIL_PROPOSTA.NUM_PERIO as NUM_PER12_21_0_,
       bilhet.tBIL_PROPOSTA.NUM_APOLI as NUM_APO13_21_0_,
       bilhet.tBIL_PROPOSTA.NUM_COBER_BAS as NUM_COB14_21_0_,
       bilhet.tBIL_PROPOSTA.NUM_MOEDA_PRS as NUM_MOE15_21_0_,
       bilhet.tBIL_PROPOSTA.NUM_PROPT as NUM_PRO16_21_0_,
       bilhet.tBIL_PROPOSTA.NUM_RAMO_SEG as NUM_RAM17_21_0_,
       bilhet.tBIL_PROPOSTA.SEQ_PROPT_ATG as SEQ_PRO18_21_0_,
       bilhet.tBIL_PROPOSTA.STA_PAMTX as STA_PAM19_21_0_,
       bilhet.tBIL_PROPOSTA.TIP_AVERB as TIP_AVE20_21_0_,
       APLBIL.V_CRP_PESSOA.CTL_PESSO as CTL_PESS1_12_1_,
       APLBIL.V_CRP_PESSOA.COD_DOCUM_PRI as COD_DOCU2_12_1_,
       APLBIL.V_CRP_PESSOA.NOM_FANTS as NOM_FANT3_12_1_,
       APLBIL.V_CRP_PESSOA.NOM_PESSO as NOM_PESS4_12_1_,
       APLBIL.V_CRP_PESSOA.TIP_DOCUM_PRI as TIP_DOCU5_12_1_,
       APLBIL.V_CRP_PESSOA.TIP_PESSO as TIP_PESS6_12_1_,
       bilhet.tBIL_HIERQ_PRODR_PROPT.SEQ_NUMER_PRS as SEQ_NUME1_1_2_,
       bilhet.tBIL_HIERQ_PRODR_PROPT.CTL_PRODR as CTL_PROD2_1_2_,
       bilhet.tBIL_HIERQ_PRODR_PROPT.DHR_ALTER as DHR_ALTE3_1_2_,
       bilhet.tBIL_HIERQ_PRODR_PROPT.DAT_INICI_VIG as DAT_INIC4_1_2_,
       bilhet.tBIL_HIERQ_PRODR_PROPT.NUM_HIERQ as NUM_HIER5_1_2_,
       bilhet.tBIL_PROPOSTA_AJUSTAVEL.SEQ_NUMER_PRS as SEQ_NUME1_22_3_,
       bilhet.tBIL_PROPOSTA_AJUSTAVEL.DHR_ALTER as DHR_ALTE2_22_3_,
       bilhet.tBIL_PROPOSTA_AJUSTAVEL.NUM_PERIO as NUM_PERI3_22_3_,
       bilhet.tBIL_PROPOSTA_AJUSTAVEL.QTD_PARCE_SEG as QTD_PARC4_22_3_,
       bilhet.tBIL_PROPOSTA_AJUSTAVEL.VLR_PREMI_FIX as VLR_PREM5_22_3_ 
FROM bilhet.tBIL_PROPOSTA 
LEFT OUTER JOIN APLBIL.V_CRP_PESSOA ON bilhet.tBIL_PROPOSTA.CTL_PESSO_CLI = APLBIL.V_CRP_PESSOA.CTL_PESSO 
LEFT OUTER JOIN bilhet.tBIL_HIERQ_PRODR_PROPT ON bilhet.tBIL_PROPOSTA.SEQ_NUMER_PRS = bilhet.tBIL_HIERQ_PRODR_PROPT.SEQ_NUMER_PRS 
LEFT OUTER JOIN bilhet.tBIL_PROPOSTA_AJUSTAVEL ON bilhet.tBIL_PROPOSTA.SEQ_NUMER_PRS = bilhet.tBIL_PROPOSTA_AJUSTAVEL.SEQ_NUMER_PRS 
WHERE bilhet.tBIL_PROPOSTA.SEQ_NUMER_PRS = '489320'

'7000133974' 


select 

select * from bilhet.tBIL_HIERQ_PRODR_PROPT
select * from APLBIL.BIL_HIERQ_PRODR_PROPT
/*------------------------------------------------------------------------------------------------------*/

SELECT bilhet.tBIL_PROPOSTA.*
FROM bilhet.tBIL_PROPOSTA 
WHERE bilhet.tBIL_PROPOSTA.SEQ_NUMER_PRS = '489320'
'7000124050'  

/*------------------------------------------------------------------------------------------------------*/

SELECT bilfatura0_.*
FROM bilhet.tBIL_FATURA bilfatura0_ 
WHERE ( bilfatura0_.SEQ_NUMER_PRS in ( 489320) ) 
  and bilfatura0_.NUM_MES_CPT < '201811' 
  and bilfatura0_.NUM_PERIO_FAT = 3
  and ( bilfatura0_.SIT_FATUR not in  ( 3 , 6 )) 
ORDER BY bilfatura0_.NUM_MES_CPT DESC
LIMIT(3)

/*------------------------------------------------------------------------------------------------------*/

SELECT COALESCE(bilhet.tBIL_VALOR_SOMA_TIPO_TARIFA.NUM_TARIF,
        bilhet.tBIL_MOVIM_FATURA.NUM_TARIF) as col_0_0_,
        bilhet.tBIL_TIPO_TARIFA_PROPOSTA.NOM_TARIF as col_1_0_,
        bilhet.tBIL_TIPO_TARIFA_PROPOSTA.NOM_APELI_PRE as col_2_0_,
        COALESCE(RTRIM(CHAR(bilhet.tBIL_VALOR_SOMA_TIPO_TARIFA.VLR_CALCU)),
        bilhet.tBIL_MOVIM_FATURA.DES_MOVIM_FAT) as col_3_0_,
        COALESCE(bilhet.tBIL_VALOR_SOMA_TIPO_TARIFA.IDT_PREMI, 'D') as col_4_0_ 
FROM bilhet.tBIL_TIPO_TARIFA_PROPOSTA 
LEFT OUTER JOIN bilhet.tBIL_VALOR_SOMA_TIPO_TARIFA ON bilhet.tBIL_TIPO_TARIFA_PROPOSTA.NUM_TARIF=bilhet.tBIL_VALOR_SOMA_TIPO_TARIFA.NUM_TARIF AND ( bilhet.tBIL_VALOR_SOMA_TIPO_TARIFA.SEQ_NUMER_FAT = '7000133974') 
LEFT OUTER JOIN bilhet.tBIL_MOVIM_FATURA ON bilhet.tBIL_TIPO_TARIFA_PROPOSTA.NUM_TARIF=bilhet.tBIL_MOVIM_FATURA.NUM_TARIF AND ( bilhet.tBIL_MOVIM_FATURA.SEQ_NUMER_FAT = '7000133974' ) 
WHERE COALESCE(bilhet.tBIL_VALOR_SOMA_TIPO_TARIFA.NUM_TARIF, bilhet.tBIL_MOVIM_FATURA.NUM_TARIF) is not null
