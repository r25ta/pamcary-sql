/***************************************/
/*QUERY OFICIAL */
/*IDENTIFICA AS AVERBACOES COM DUPLICIDADE*/
SELECT NUM_AVERB_PAM,NUM_SEQUE_AVB 
		FROM bilhet.TBIL_AVERBACAO ta 
--		WHERE DHR_ALTER >='20220225000000'
		GROUP BY NUM_AVERB_PAM,NUM_SEQUE_AVB 
		HAVING count(1) > 1  
OPTIMIZE FOR 1 ROWS WITH UR

/*Duplidades DETALHADA POR NUM_AVERB_PAM*/
SELECT distinct a.SEQ_NUMER_AVB
	, a.NUM_AVERB_PAM
	, a.NUM_SEQUE_AVB 
	, b.SEQ_NUMER_FAT 
	,d.NUM_FATUR_CIA 	
FROM BILHET.TBIL_AVERBACAO a
        inner join BILHET.TBIL_RELAC_AVERB_PROPT b
        on a.SEQ_NUMER_AVB = b.SEQ_NUMER_AVB
        inner join BILHET.V_BIL_PROPOSTA c
        on c.SEQ_NUMER_PRS = b.SEQ_NUMER_PRS
        left outer join BILHET.TBIL_FATURA d
        on d.SEQ_NUMER_FAT = b.SEQ_NUMER_FAT 
WHERE a.NUM_AVERB_PAM = 451665061 --452936185
ORDER BY a.num_seque_avb
OPTIMIZE FOR 1 ROWS WITH UR

/***************************************************************/










SELECT
	A.NUM_MES_CPT AS num_mes_cpt ,
	A.SEQ_NUMER_FAT AS SEQ_NUMER_FAT ,
	B.NUM_APOLI AS NUM_APOLI ,
	A.NUM_FATUR_CIA AS NUM_FATUR_CIA
	, C.DES_SITUA_FAT
	,A.*
FROM
	BILHET.TBIL_FATURA A,
	BILHET.TBIL_PROPOSTA B,
	bilhet.TBIL_SITUACAO_FATURA C
WHERE
	A.SEQ_NUMER_PRS = B.SEQ_NUMER_PRS
	AND A.SIT_FATUR = C.SIT_FATUR 
	AND A.NUM_FATUR_CIA IS NOT NULL
	AND B.CTL_PEJUR_CIA =17341
	AND A.SIT_FATUR NOT IN (3, 6, 7)
	AND A.DHR_ALTER BETWEEN TIMESTAMP_FORMAT('2022-03-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
							AND TIMESTAMP_FORMAT('2022-03-30 23:59:59', 'YYYY-MM-DD HH24:MI-SS') 
	ORDER BY A.NUM_FATUR_CIA  
	WITH UR
 
SELECT * FROM bilhet.TBIL_AVERBACAO ta 
WHERE NUM_AVERB_PAM  =462065539



/*BUSCA DUPLICIDADES*/
SELECT NUM_AVERB_PAM
		FROM bilhet.TBIL_AVERBACAO ta 
		WHERE NUM_SEQUE_AVB = 1
		AND DHR_ALTER >='20230601000000'
		GROUP BY NUM_AVERB_PAM  
		HAVING count(1) > 1  
OPTIMIZE FOR 1 ROWS WITH UR





/*Duplidades POR NUM_AVERB_PAM*/
SELECT distinct a.SEQ_NUMER_AVB
	, a.NUM_AVERB_PAM
	, a.NUM_SEQUE_AVB 
	, b.SEQ_NUMER_FAT 
	,d.NUM_FATUR_CIA 	
FROM BILHET.TBIL_AVERBACAO a
        inner join BILHET.TBIL_RELAC_AVERB_PROPT b
        on a.SEQ_NUMER_AVB = b.SEQ_NUMER_AVB
        inner join BILHET.V_BIL_PROPOSTA c
        on c.SEQ_NUMER_PRS = b.SEQ_NUMER_PRS
        left outer join BILHET.TBIL_FATURA d
        on d.SEQ_NUMER_FAT = b.SEQ_NUMER_FAT 
WHERE a.NUM_AVERB_PAM =463776534
ORDER BY a.num_seque_avb
OPTIMIZE FOR 1 ROWS WITH UR



/*Duplidades full*/
SELECT c.SEQ_NUMER_PRS
	, c.NUM_APOLI
	, c.NUM_PROPT
	, c.SIG_RAMO 
	, c.CTL_PEJUR_CIA 
	, c.NOM_PEJUR_CIA  
	, c.CTL_PESSO_CLI 
	, c.NOM_PESSO_CLI AS segurado
	, c.COD_DOCUM_CLI AS CNPJ
	, c.NOM_PERIO_PRS
	, a.SEQ_NUMER_AVB
	, a.NUM_AVERB_PAM
	, b.SEQ_NUMER_FAT 
	,(SELECT DES_SITUA_FAT 
		FROM bilhet.TBIL_SITUACAO_FATURA
		WHERE SIT_FATUR = d.sit_fatur ) AS sit_fat
	,(SELECT DES_SITUA_ENV  
		FROM bilhet.TBIL_SITUACAO_ENVIO_FATURA
		WHERE SIT_ENVIO_FAT = d.sit_envio_fat  ) AS sit_envio
	,d.NUM_FATUR_CIA 	
FROM BILHET.TBIL_AVERBACAO a
,BILHET.TBIL_RELAC_AVERB_PROPT b
,BILHET.V_BIL_PROPOSTA c
,BILHET.TBIL_FATURA d
WHERE a.SEQ_NUMER_AVB = b.SEQ_NUMER_AVB
AND c.SEQ_NUMER_PRS = b.SEQ_NUMER_PRS
AND d.SEQ_NUMER_FAT = b.SEQ_NUMER_FAT 
AND 
a.NUM_AVERB_PAM IN (
	SELECT NUM_AVERB_PAM
		FROM bilhet.TBIL_AVERBACAO ta 
		WHERE NUM_SEQUE_AVB = 1
			AND DHR_AVERB <= '20220331235959'
		GROUP BY NUM_AVERB_PAM  
		HAVING count(1) > 1  
)
AND a.DHR_AVERB <= '20220331235959'
AND c.CTL_PEJUR_CIA = 19793
AND b.SEQ_NUMER_FAT IS NOT NULL 
OPTIMIZE FOR 1 ROWS WITH UR





-- MAPFRE 17341
-- SOMPO 37960
-- CHUBB 19793
-- BERKLEY 37922


/*Duplidades faturas processadas*/
SELECT a.SEQ_NUMER_AVB
	, a.NUM_AVERB_PAM
	, a.NUM_SEQUE_AVB 
	, b.SEQ_NUMER_FAT 
	,d.NUM_FATUR_CIA 	
FROM BILHET.TBIL_AVERBACAO a
,BILHET.TBIL_RELAC_AVERB_PROPT b
,BILHET.V_BIL_PROPOSTA c
,BILHET.TBIL_FATURA d
WHERE a.SEQ_NUMER_AVB = b.SEQ_NUMER_AVB
AND c.SEQ_NUMER_PRS = b.SEQ_NUMER_PRS
AND d.SEQ_NUMER_FAT = b.SEQ_NUMER_FAT 
AND 
a.NUM_AVERB_PAM IN (
	SELECT NUM_AVERB_PAM
		FROM bilhet.TBIL_AVERBACAO ta 
		WHERE NUM_SEQUE_AVB = 1
		GROUP BY NUM_AVERB_PAM  
		HAVING count(1) > 1  
)
AND a.DHR_ALTER >='20220225000000'
AND	d.NUM_FATUR_CIA IS NOT NULL	
AND d.SIT_ENVIO_FAT = 4
AND b.SEQ_NUMER_FAT IS NOT NULL 
OPTIMIZE FOR 1 ROWS WITH UR

SELECT a.SEQ_NUMER_AVB
	, a.NUM_AVERB_PAM
	, a.NUM_SEQUE_AVB 
	, b.SEQ_NUMER_FAT 
	,d.NUM_FATUR_CIA 	
FROM BILHET.TBIL_AVERBACAO a
,BILHET.TBIL_RELAC_AVERB_PROPT b
,BILHET.V_BIL_PROPOSTA c
,BILHET.TBIL_FATURA d
WHERE a.SEQ_NUMER_AVB = b.SEQ_NUMER_AVB
AND c.SEQ_NUMER_PRS = b.SEQ_NUMER_PRS
AND d.SEQ_NUMER_FAT = b.SEQ_NUMER_FAT 
AND a.NUM_AVERB_PAM = 462214890
OPTIMIZE FOR 1 ROWS WITH UR




SELECT a.SEQ_NUMER_AVB ,a.NUM_SEQUE_AVB , a.NUM_AVERB_PAM , b.SEQ_NUMER_PRS , b.SEQ_NUMER_FAT  FROM bilhet.TBIL_AVERBACAO a
			,bilhet.TBIL_RELAC_AVERB_PROPT b
WHERE a.SEQ_NUMER_AVB = b.SEQ_NUMER_AVB 
AND b.SEQ_NUMER_FAT IS NULL 
AND a.NUM_AVERB_PAM = 462214890
AND a.NUM_AVERB_PAM IN (
	SELECT NUM_AVERB_PAM
		FROM bilhet.TBIL_AVERBACAO ta 
		WHERE NUM_AVERB_PAM = 462214890

		GROUP BY NUM_AVERB_PAM  
		HAVING count(1) > 1  
)
AND a.DHR_ALTER >='20220225000000'
ORDER BY a.num_seque_avb 
OPTIMIZE FOR 1 ROWS WITH UR


SELECT * FROM bilhet.TBIL_RELAC_AVERB_PROPT trap 
WHERE SEQ_NUMER_AVB = 982422074

SELECT * FROM BILHET.TBIL_AVERBACAO ta
WHERE NUM_AVERB_PAM = 462214890
ORDER BY NUM_SEQUE_AVB 

NUM_SEQUE_AVB > 1
and dhr_alter between '2022-02-25 00:00:00' and '2022-03-31 23:59:59'
order by num_averb_pam desc

num_AVERB_PAM = 436121005


SELECT * FROM bilhet.TBIL_PROPOSTA tp 
WHERE SEQ_NUMER_PRS IN (500554
,500555)

SELECT * FROM bilhet.TBIL_RELAC_AVERB_PROPT trap  
WHERE SEQ_NUMER_AVB In(
982422075
,982422076
,982422077
,982422078
,982422079
,982422080
,982422081
,982422082
,982422083
,982422084
,982422085
,982422086
,982422087
,982422088
,982422089
,982422090
,982422091
,982422092
,982422093
,982422094
,982422095
,982422096
,982422097
,982422098
,982422099
,982422100
,982422101)







SELECT distinct a.SEQ_NUMER_AVB
	, a.NUM_AVERB_PAM
	, a.NUM_SEQUE_AVB 
	, b.SEQ_NUMER_FAT 
	,d.NUM_FATUR_CIA 	
FROM BILHET.TBIL_AVERBACAO a
        inner join BILHET.TBIL_RELAC_AVERB_PROPT b
        on a.SEQ_NUMER_AVB = b.SEQ_NUMER_AVB
        inner join BILHET.V_BIL_PROPOSTA c
        on c.SEQ_NUMER_PRS = b.SEQ_NUMER_PRS
        left outer join BILHET.TBIL_FATURA d
        on d.SEQ_NUMER_FAT = b.SEQ_NUMER_FAT 
WHERE a.NUM_AVERB_PAM =436976790
ORDER BY a.num_seque_avb
OPTIMIZE FOR 1 ROWS WITH UR


SELECT * FROM bilhet.TBIL_PROPOSTA tp 
WHERE SEQ_NUMER_PRS IN (504328
,504329
,506324)


DELETE  FROM bilhet.TBIL_RELAC_AVERB_PROPT
WHERE (SEQ_NUMER_PRS , SEQ_NUMER_AVB) IN ( 
SELECT trap.SEQ_NUMER_PRS, trap.SEQ_NUMER_AVB  FROM bilhet.TBIL_RELAC_AVERB_PROPT trap , bilhet.TBIL_AVERBACAO ta 
WHERE trap.SEQ_NUMER_AVB = ta.SEQ_NUMER_AVB  
--AND trap.seq_numer_avb = 1152920854
AND ta.DHR_EMBAR BETWEEN '2023-06-01 00:00:00' AND '2023-06-30 23:59:59'
AND SEQ_NUMER_FAT IS NULL )
--AND SEQ_NUMER_PRS = 506324 )
AND SEQ_NUMER_PRS = 506324

COMMIT 
AND DHR_ALTER BETWEEN '2023-06-01 00:00:00' AND '2023-06-30 23:59:59'
AND SEQ_NUMER_FAT IS NULL 

seq_numer_avb = 1152920854

SELECT * FROM bilhet.TBIL_AVERBACAO_INDICE tai 
WHERE NUM_AVERB_PAM  = 690458897

SELECT * FROM bilhet.TBIL_AVERBACAO ta 
WHERE NUM_AVERB_PAM  = 690458897

SEQ_NUMER_FAT = 7000295525