/*FUNCIONALIDADE A INTEGRAÇÃO TALEND QUE VERIFICA EM QUAL HIERARQUIA COMERCIAL A APOLICE SE ENCAIXA*/

SELECT  DISTINCT
	T2.SEQ_NUMER_PRS,
	T1.NUM_HIERQ,
	T1.CTL_PRODR,
	T3.DAT_INICI_VIG
FROM 
	SEGURO.TSEG_PROPOSTA_SEGURO T1
	INNER JOIN BILHET.TBIL_PROPOSTA T2
		ON (T1.NUM_PROPT = T2.NUM_PROPT)
	INNER JOIN PAMAIS.TCRP_HIERARQUIA_COMEC_PRODR T3
		ON (T1.CTL_PRODR = T3.CTL_PRODR and T3.NUM_HIERQ = T1.NUM_HIERQ AND T3.DAT_FIM_VIG IS NULL)
WHERE 1=1 
AND T1.NUM_PROPT NOT BETWEEN 55000000 AND 55999999 /* incluído em 31/01/2022 a pedido do Adriano Nichimura */
AND T1.NUM_PROPT NOT BETWEEN 999000000 AND 999999999 /* incluído em 31/01/2022 a pedido do Adriano Nichimura */
AND t1.NUM_PROPT IN (24003377,24003505)

SELECT * FROM SEGURO.TSEG_PROPOSTA_SEGURO
WHERE NUM_APOLI = 210011895

SELECT * FROM pamais.TCRP_HIERARQUIA_COMEC_PRODR thcp 
WHERE CTL_PRODR = 768
AND NUM_HIERQ = 31

SELECT * FROM pamais.V_CRP_HIERARQUIA_COMEC_PRODR vchcp 
WHERE NUM_HIERQ = 31
AND CTL_PRODR = 768