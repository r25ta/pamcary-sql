/*DETECTA DUPPLICIDADES*/
select count(1)
/*
,CTL_ATM
,COD_CNPJ_SEG
,COD_RAMO
,VLR_MERCA
,COD_DANFE
,COD_NTFIS
**/ 
,COD_AVERB_OFC || 'X'  
from dbprod.taverbacao_impor_atm
WHERE DHR_EMBAR  between '2021-06-18-00.00.00.000000'  and  '2021-06-19-23.59.59.999999'
AND COD_PROTO_CAN IS NULL 
GROUP BY COD_AVERB_OFC  
HAVING count(1) >1
--AND COD_AVERB_OFC ='0623802220023306500018757050000389580137'
--ORDER BY COD_AVERB_OFC 
optimize for 1 rows
with ur;

SELECT * FROM DBPROD.SITUACAO_AVERBACAO 
SELECT * FROM DBPROD.AVERBACAO_IMPOR_ATM 
WHERE COD_AVERB_OFC = '0141401227739336100017057001000109883101'
SELECT * FROM DBPROD.AVERBACAO_INDICE 
SELECT * FROM DBPROD.RELAC_AVERBACAO_ATM 
SELECT * FROM dbprod.AVERBACAO 

/*SELECT DO PROGRAMA*/
SELECT AI.CTL_AVERB
	   ,VARCHAR_FORMAT(AIA.COD_AVERB_OFC) || 'X' AS COD_AVERB_OFC
	   ,AIA.COD_CNPJ_SEG
--	   ,P.COD_DOCUM_PRI
	   ,P.NOM_PESSO
	   ,P.NOM_FANTS
	   ,AI.SIT_AVERB
FROM DBPROD.AVERBACAO_IMPOR_ATM AIA 
	 ,DBPROD.AVERBACAO_INDICE AI
	 ,DBPROD.RELAC_AVERBACAO_ATM RAA
	 ,APLAIS.V_CRP_PESSOA P
WHERE AIA.CTL_ATM = RAA.CTL_ATM 
AND AI.CTL_AVERB = RAA.CTL_AVERB
AND P.COD_DOCUM_PRI =  AIA.COD_CNPJ_SEG 
AND AIA.DHR_EMBAR  between '2021-06-18-00.00.00.000000'  and  '2021-06-19-23.59.59.999999'
AND AIA.COD_PROTO_CAN IS NULL 
AND AI.SIT_AVERB <> 3
--AND COD_AVERB_OFC IS NULL
--AND COD_AVERB_OFC ='0141401227739336100017057001000109883101'
ORDER BY COD_AVERB_OFC ASC
optimize for 1 rows
with ur;

variavel = null
CURSOR 
WHILE CURSOR NOT eof
	IF(variavel != CURSOR.COD_AVERB_OFC)
		variavel = CURSOR.COD_AVERB_OFC

	ELSE
		UPDATE ALTERAR STATUS AVERBACAO INDICE
		
		
	
SELECT * FROM APLAIS.CRP_PESSOA 