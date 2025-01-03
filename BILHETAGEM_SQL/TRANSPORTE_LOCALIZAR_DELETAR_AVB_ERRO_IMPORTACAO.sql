
SELECT count(*) FROM apltrans.RELAC_SITUA_AVERB_ATM 
WHERE (SIT_IMPOR_ATM, CTL_ATM) IN  ( 
	SELECT TSAA.SIT_IMPOR_ATM, TSAA.CTL_ATM FROM apltrans.RELAC_SITUA_AVERB_ATM TSAA
	INNER JOIN apltrans.AVERBACAO_IMPOR_ATM TIA ON TIA.CTL_ATM = TSAA.CTL_ATM
	inner JOIN apltrans.SITUA_IMPOR_ATM TIA2 ON TIA2.SIT_IMPOR_ATM = TSAA.SIT_IMPOR_ATM
	WHERE TIA.COD_CNPJ_SEG = '03010559000190' 
	AND TSAA.SIT_IMPOR_ATM <> 0
	AND TIA.dhr_AVERB BETWEEN '2023-01-01 00:00:00' AND  '2024-01-01 23:59:59' 
)  


DELETE FROM apltrans.RELAC_SITUA_AVERB_ATM 
WHERE (SIT_IMPOR_ATM, CTL_ATM) IN  ( 
	SELECT TSAA.SIT_IMPOR_ATM, TSAA.CTL_ATM FROM apltrans.RELAC_SITUA_AVERB_ATM TSAA
	INNER JOIN apltrans.AVERBACAO_IMPOR_ATM TIA ON TIA.CTL_ATM = TSAA.CTL_ATM
	inner JOIN apltrans.SITUA_IMPOR_ATM TIA2 ON TIA2.SIT_IMPOR_ATM = TSAA.SIT_IMPOR_ATM
	WHERE TIA.COD_CNPJ_SEG = '03010559000190' 
	AND TSAA.SIT_IMPOR_ATM <> 0
	AND TIA.dhr_AVERB BETWEEN '2023-01-01 00:00:00' AND  '2024-01-01 23:59:59' 

)  

COMMIT