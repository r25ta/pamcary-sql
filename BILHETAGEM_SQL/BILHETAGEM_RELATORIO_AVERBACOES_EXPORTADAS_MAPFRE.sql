/*RELATORIO DE AVERBAÇÕES EXPORTADAS MAPFRE*/

select DISTINCT YEAR(DHR_PROCESSAMENTO) AS yyyy   
			  ,MONTH(DHR_PROCESSAMENTO) AS mm 
			  , day(DHR_PROCESSAMENTO) AS dd 
			  , count(1) AS faturas
			  , sum(QTDE_AVERBACAO) AS QTDE_AVERBACAO 
from BILHET.TBIL_LOG_ENVIO_FATURA_MAPFRE tlefm 
GROUP BY YEAR(DHR_PROCESSAMENTO), MONTH(DHR_PROCESSAMENTO), day(DHR_PROCESSAMENTO)
ORDER BY yyyy desc , mm DESC , dd DESC 



498332/502168132/2201000/1



SELECT A.NUM_AVERB_CLI, P.SEQ_NUMER_PRS, PROPT.NUM_ETAPA_AVB 
FROM bilhet.tBIL_AVERBACAO A
INNER JOIN bilhet.tBIL_RELAC_AVERB_PROPT PROPT ON A.SEQ_NUMER_AVB = PROPT.SEQ_NUMER_AVB
INNER JOIN bilhet.tBIL_PROPOSTA P ON P.SEQ_NUMER_PRS = PROPT.SEQ_NUMER_PRS
WHERE A.NUM_AVERB_CLI = 514716376   
	AND P.SEQ_NUMER_PRS = 500584 
	AND PROPT.NUM_ETAPA_AVB > 1
fetch first 1 rows only 

SELECT * FROM bilhet.TBIL_AVERBACAO ta 
WHERE NUM_AVERB_CLI =514716376
ORDER BY SEQ_NUMER_AVB DESC 


SELECT * FROM bilhet.TBIL_RELAC_AVERB_PROPT trap 
WHERE SEQ_NUMER_AVB = 1058931649


SELECT * FROM bilhet.TBIL_AVERBACAO ta 
WHERE SEQ_NUMER_AVB IN (846308030,846308717,846308719,846305540,858696623)
502137  846308030  382784825	4
500714	846308717  382785039	4
500714	846308719  382785045	4
500714	846305540  382785053	4
500598	858696623  389133445



SELECT * FROM bilhet.TBIL_PROPOSTA tp
WHERE NUM_ETAPA_PRS = 1
fetch first 1 rows only 

SELECT * FROM bilhet.TBIL_SITUA_ETAPA_AVERB tsea 


SELECT
	A.SEQ_NUMER_AVB ,
	A.NUM_AVERB_CLI ,
	COALESCE(A.NOM_FANTS_CLI || '(' || PESSOACOG.NOM_FANTS || ')', A.NOM_FANTS_CLI)|| CASE
		WHEN AJ.SEQ_NUMER_PRS IS NOT NULL THEN '(AJ)'
		ELSE ''
	END AS NOM_FANTS_CLI ,
	A.SIG_SIMBO_MOE ,
	A.NUM_APOLI ,
	A.NUM_SEQUE_AVB ,
	A.SIG_RAMO ,
	A.DHR_EMBAR ,
	A.COD_DOCUM_EMB ,
	A.ORIGEM ,
	A.DESTINO ,
	A.VLR_IS IS ,
	A.VLR_IS_TOT IS_TOTAL ,
	A.VLR_EMBAR ,
	A.VLR_LIMIT_PRS ,
	A.VLR_EMBAR - A.VLR_IS VLR_EMBAR_LIMIT_PRS ,
	A.SEQ_NUMER_PRS ,
	A.CTL_PESSO_CLI ,
	A.NUM_AVERB_PAM ,
	A.VLR_LIMIT_PTX ,
	A.NUM_ETAPA_AVB
FROM
	BILHET.V_BIL_CONSULTA_AVERB_PROPT_EXTPO A
LEFT JOIN BILHET.TBIL_PROPOSTA PROPOSTA ON
	A.SEQ_NUMER_PRS = PROPOSTA.SEQ_NUMER_PRS
LEFT JOIN BILHET.TBIL_PROPOSTA_AJUSTAVEL AJ ON
	AJ.SEQ_NUMER_PRS = PROPOSTA.SEQ_NUMER_PRS
LEFT JOIN PAMAIS.V_CRP_PESSOA PESSOACOG ON
	PESSOACOG.CTL_PESSO = PROPOSTA.CTL_PESSO_COG
WHERE
	YEAR(A.DHR_EMBAR) = 2022
	AND MONTH(A.DHR_EMBAR) = 6
	AND ( A.NUM_AVERB_PAM = 514716376
		OR A.NUM_AVERB_CLI = 514716376 ) OPTIMIZE FOR 1 ROWS WITH UR



CALL bilhet.SP_BIL_ALTERA_AVERB_PROPT_EXTPO(501124,501764941,1036750.5,1,'seset19')

seqNumerPrs: 500584 ctlAverb: 514716376 value: 453400 trecho: 1 login:seave24

COMMIT 

SELECT
	DISTINCT A.SEQ_NUMER_AVB
FROM
	BILHET.TBIL_AVERBACAO A
INNER JOIN BILHET.TBIL_RELAC_AVERB_PROPT PROPT ON
	A.SEQ_NUMER_AVB = PROPT.SEQ_NUMER_AVB
INNER JOIN BILHET.TBIL_PROPOSTA P ON
	P.SEQ_NUMER_PRS = PROPT.SEQ_NUMER_PRS
WHERE
	A.NUM_AVERB_PAM = 514716376
	AND 
    P.SEQ_NUMER_PRS = 500584
	AND 
    A.NUM_SEQUE_AVB = 1

                                  
                   SELECT * FROM  BILHET.TBIL_RELAC_AVERB_PROPT PROPT
                   WHERE SEQ_NUMER_PRS = 500584
                     AND SEQ_NUMER_AVB = 1058931649;                                  
                                  
                    
508774562 => 5.087.745,62
