SELECT * FROM AVERBACAO_ERRO 
WHERE CTL_AVERB IN ( SELECT a.ctl_averb FROM AVERBACAO_INDICE ai INNER JOIN AVERBACAO a ON a.ctl_averb = ai.ctl_averb WHERE ai.NUM_RAMO = 1
AND ai.CTL_PESSO = 340614
AND ai.CTL_VINCD_SED = 517902
AND ai.sit_averb= 5
AND a.dhr_alter BETWEEN '2024-07-26 11:30:00' AND '2024-07-29 10:40:00' ) 
 
SELECT ai.NUM_PROPT, p.nom_pesso,p.COD_DOCUM_PRi, ai.SIT_AVERB,sa.DES_SITUA_AVB, count(1) AS total
FROM AVERBACAO_INDICE ai 
INNER JOIN APLTRANS.SITUACAO_AVERBACAO sa ON sa.SIT_AVERB = ai.SIT_AVERB 
INNER JOIN PAMAIS.CRP_PESSOA p ON p.ctl_pesso = ai.CTL_PESSO 
INNER JOIN AVERBACAO a ON a.ctl_averb = ai.ctl_averb 
WHERE ai.CTL_AVERB > 800000000 
--AND ai.NUM_RAMO = 1
	AND ai.CTL_PESSO in( 340614 , 75431, 6856 )
	AND ai.CTL_VINCD_SED IN (517902 ,510740, 2830 )
--AND ai.sit_averb<> 4
	AND a.dhr_alter BETWEEN '2024-07-29 10:40:00' AND CURRENT timestamp 
GROUP BY ai.num_propt,p.nom_pesso, p.COD_DOCUM_PRI, ai.SIT_AVERB, sa.DES_SITUA_AVB         
optimize for 1 rows with ur

SELECT * FROM TAVERBACAO_CONSISTENCIA tc  INNER JOIN AVERBACAO_INDICE ai 
ON ai.CTL_AVERB = tc.CTL_AVERB 
WHERE AI.CTL_AVERB = 908492952
ai.NUM_PROPT = 24000787
ORDER BY DHR_ALTER DESC 

SELECT * FROM AVERBACAO_INDICE 
SELECT * FROM SITUACAO_AVERBACAO 

SELECT * FROM AVERBACAO
WHERE CTL_AVERB = 860736841


SELECT * FROM ITEM_DESTINO 
WHERE CTL_AVERB = 860736841


SELECT * FROM RESULTADO_AGRAVA 
WHERE CTL_AVERB = 860736841

SELECT * FROM RESPOSTA_AGRAVA 
WHERE CTL_AVERB = 860736841


AND UPPER(COD_MANIF) LIKE UPPER('%tst%')  

SELECT * FROM DBPROD.TAVERBACAO_CONSISTENCIA
WHERE CTL_AVERB = 909440815


SELECT ai.CTL_AVERB AS averbacao
,ai.NUM_PROPT AS proposta
,ai.NUM_RAMO AS ramo
,(SELECT nom_vincd FROM vinculado WHERE ctl_vincd = ai.CTL_VINCD_SED) AS segurado
,a.DHR_AVERB 
,a.DHR_ALTER
,a.COD_USER 
 ,* FROM AVERBACAO_INDICE Ai 
INNER JOIN AVERBACAO a ON a.CTL_AVERB = ai.CTL_AVERB 
WHERE ai.SIT_AVERB = 0
AND a.COD_USER = 'Link-Sinistro'
ORDER BY a.DHR_AVERB DESC 

AND ai.CTL_PESSO IN (340614 , 75431, 6856)
AND ai.CTL_AVERB NOT IN (SELECT CTL_AVERB FROM AVERBACAO_CONSISTENCIA )

WHERE 

SELECT * FROM AVERBACAO_INDICE 
WHERE CTL_AVERB = 908492952

SELECT * FROM HIST_AVERBACAO 
WHERE CTL_AVERB = 908492952

SELECT * FROM AVERBACAO_VEICULO 
WHERE CTL_AVERB = 908492952


SELECT * FROM ITEM_DESTINO 
WHERE CTL_AVERB = 908492952

SELECT * FROM DESTINO 
WHERE CTL_AVERB = 908492952



SELECT * FROM APLTRANS.AVERBACAO_INDICE ai INNER JOIN APLTRANS.AVERBACAO a 
ON a.CTL_AVERB = ai.CTL_AVERB 
INNER JOIN APLTRANS.AVERBACAO_CONSISTENCIA ac 
ON ac.CTL_AVERB = ai.CTL_AVERB 
WHERE ai.CTL_AVERB IN (909048514,
909048519,
909048521
909048526)




SELECT COALESCE(a.NUM_PROPT,0) AS num_propt, c.DAT_EMBAR, a.DAT_INICI_VIG, a.DAT_FIM_VIG, b.CTL_VINCD_SED, b.CTL_PESSO  
             FROM averbacao_indice b  
             INNER JOIN averbacao c ON b.ctl_averb = c.ctl_averb  
             LEFT JOIN seguro.tseg_proposta_seguro a ON (a.CTL_CLIEN_PPS,a.NUM_RAMO_SEG) = (b.CTL_PESSO,b.NUM_RAMO) AND A.NUM_VERSA_PRS = 1 AND A.TIP_PROPT = 1  
             AND a.sit_tipo_prs = 1  
             AND c.dat_embar BETWEEN a.dat_inici_vig AND a.dat_fim_vig  
             AND a.NUM_PROPT NOT BETWEEN 55000000 AND 55999999  
             AND a.NUM_PROPT NOT BETWEEN 999000000 AND 999999999  
             WHERE b.ctl_averb IN (908167760)


SELECT ea.tip_erro, ea.DES_ERRO, count(1) 
FROM APLTRANS.AVERBACAO_ERRO ae INNER JOIN APLTRANS.ERRO_AVERBACAO ea 
ON ea.TIP_ERRO = ae.TIP_ERRO 
GROUP BY ea.tip_erro, ea.DES_ERRO


UPDATE AVERBACAO_INDICE SET 
SIT_AVERB = 0
WHERE CTL_AVERB IN
(906899979
)



INSERT INTO AVERBACAO_CONSISTENCIA (CTL_AVERB, CTL_USER, DHR_ALTER, SIT_AVERB, NUM_SEQ)
SELECT CTL_AVERB, 15, CURRENT timestamp, 0, 0  
from AVERBACAO
WHERE CTL_AVERB IN 
(906899979
)


COMMIT

SELECT * FROM AVERBACAO_ERRO 

SELECT * FROM AVERBACAO_INDICE 
WHERE CTL_AVERB = 871499515

SELECT * from APLTRANS.SEGURADO_PARALELO
COMMIT

INSERT INTO APLTRANS.SEGURADO_PARALELO
(ctl_vinc_sed, ctl_pesso, num_ramo_seg, cod_user, dhr_alter)
VALUES (2830,6856,1,'ronaldo',CURRENT timestamp)



SELECT * FROM VINCULADO 
WHERE CTL_VINCD = 510740

SELECT * FROM CRP_PESSOA 
WHERE CTL_PESSO = 75431



571720605
571720603