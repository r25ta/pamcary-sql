
/*QUANTIDADE AVERBA��ES PENDENTES DE PROCESSAMENTO*/
SELECT
	t1.NUM_APOLI
	,COALESCE(t2.NOM_FANTS || '(' || t4.NOM_FANTS || ')', t2.NOM_FANTS) || CASE
				 WHEN t3.NOM_PERIO IS NOT NULL THEN '(AJ)'
		ELSE ''
	END AS NOM_FANTS_CLI
	,YEAR(A.DAT_EMBAR) || '/' || RIGHT('0' || MONTH(A.DAT_EMBAR), 2) AS NUM_MES_CPT
	,COUNT(UNIQUE I.CTL_AVERB) AS QTD_AVERB
FROM
				 BILHET.TBIL_LOG_AVERBACAO LOG
INNER JOIN DBPROD.TAVERBACAO_INDICE I ON
				 I.CTL_AVERB = LOG.NUM_AVERB_PAM
INNER JOIN DBPROD.AVERBACAO A ON
				 I.CTL_AVERB = A.CTL_AVERB
INNER JOIN bilhet.tbil_proposta t1 ON
				 t1.NUM_PROPT = I.NUM_PROPT
INNER JOIN PAMAIS.tcrp_pessoa t2 ON 
				 t2.ctl_pesso = t1.ctl_pesso_cli
LEFT JOIN bilhet.tbil_proposta_ajustavel t13 ON 
				 t13.seq_numer_prs = t1.seq_numer_prs
LEFT JOIN bilhet.tbil_periodo t3 ON
				 t3.num_perio = t13.num_perio
LEFT JOIN PAMAIS.TCRP_PESSOA t4 ON 
				 t4.ctl_pesso = t1.ctl_pesso_cog
WHERE
				 t1.NUM_RAMO_SEG <> 2
GROUP BY
				 t1.NUM_APOLI,
				 COALESCE(t2.NOM_FANTS || '(' || t4.NOM_FANTS || ')', t2.NOM_FANTS) || CASE
				 WHEN t3.NOM_PERIO IS NOT NULL THEN '(AJ)'
		ELSE ''
	END,
				 YEAR(A.DAT_EMBAR) || '/' || RIGHT('0' || MONTH(A.DAT_EMBAR), 2)
ORDER BY
	NOM_FANTS_CLI,
	NUM_MES_CPT DESC
	
	
/*AVERBA��ES PENDENTES DE PROCESSAMENTO*/
SELECT
	DISTINCT I.CTL_AVERB
	,t1.NUM_APOLI
	,t2.ctl_pesso
	,t2.cod_docum_pri
	,COALESCE(t2.NOM_FANTS || '(' || t4.NOM_FANTS || ')', t2.NOM_FANTS) || CASE
				 WHEN t3.NOM_PERIO IS NOT NULL THEN '(AJ)'
		ELSE ''
	END AS NOM_FANTS_CLI
	,YEAR(A.DAT_EMBAR) || '/' || RIGHT('0' || MONTH(A.DAT_EMBAR), 2) AS NUM_MES_CPT
	
FROM
				 BILHET.TBIL_LOG_AVERBACAO LOG
INNER JOIN DBPROD.TAVERBACAO_INDICE I ON
				 I.CTL_AVERB = LOG.NUM_AVERB_PAM
INNER JOIN DBPROD.AVERBACAO A ON
				 I.CTL_AVERB = A.CTL_AVERB
INNER JOIN bilhet.tbil_proposta t1 ON
				 t1.NUM_PROPT = I.NUM_PROPT
INNER JOIN PAMAIS.tcrp_pessoa t2 ON 
				 t2.ctl_pesso = t1.ctl_pesso_cli
LEFT JOIN bilhet.tbil_proposta_ajustavel t13 ON 
				 t13.seq_numer_prs = t1.seq_numer_prs
LEFT JOIN bilhet.tbil_periodo t3 ON
				 t3.num_perio = t13.num_perio
LEFT JOIN PAMAIS.TCRP_PESSOA t4 ON 
				 t4.ctl_pesso = t1.ctl_pesso_cog
WHERE
				 t1.NUM_RAMO_SEG <> 2
AND t2.ctl_pesso NOT IN (517733,15215) --NOT IN LOGGI E UNIDOCS	



SELECT * FROM dbprod.AVERBACAO_INDICE  
WHERE NUM_AVERB  = 738445270

SELECT * FROM dbprod.AVERBACAO 
WHERE CTL_AVERB  = 853713925

SELECT * FROM DBPROD.AVERBACAO_COMPLEM 
WHERE CTL_AVERB  = 20461328

SELECT * FROM DBPROD.AVERBACAO_OFICIAL 
WHERE CTL_AVERB  = 20461328

SELECT * FROM DBPROD.AVERBACAO_COMPLEM_ATM 
WHERE CTL_AVERB  = 20461328

SELECT * FROM DBPROD.AVERBACAO_CONTA  
WHERE CTL_AVERB  = 20461328

SELECT * FROM DBPROD.AVERBACAO_IMPOR_ATM 
WHERE CTL_AVERB  = 20461328

SELECT *  FROM DBPROD.TAVERBACAO_CONSISTENCIA tc 
--ORDER by CTL_AVERB 
HAVING COUNT(1) > 1


SELECT * FROM DBPROD.AVERBACAO_ERRO 
WHERE COD_USER LIKE '%api%'

SELECT * FROM DBPROD.USUARIO 
WHERE CTL_USER = 15

--PROCESSO DELETE 
SELECT a.NUM_PROPT FROM seg_proposta_seguro a, averbacao_indice b,
             averbacao c
             WHERE a.ctl_clien_pps = b.ctl_pesso
             AND a.num_ramo_seg = b.num_ramo
             AND a.tip_propt = 1
             AND a.sit_tipo_prs = 1
             AND b.ctl_averb = c.ctl_averb
             AND c.dat_embar BETWEEN a.dat_inici_vig AND a.dat_fim_vig
             AND a.NUM_PROPT NOT BETWEEN 55000000 AND 55999999
             AND a.NUM_PROPT NOT BETWEEN 999000000 AND 999999999
             AND b.ctl_averb = :ctlAverb
             AND a.ctl_clien_pps in (123, 234, 234)

             
SELECT count(1)  FROM BILHET.TBIL_LOG_AVERBACAO LOG
--WHERE NUM_AVERB_PAM  = 738452663
ORDER BY NUM_AVERB_PAM  ASC  




SELECT * FROM bilhet.TBIL_SITUA_ETAPA_AVERB tsea 







