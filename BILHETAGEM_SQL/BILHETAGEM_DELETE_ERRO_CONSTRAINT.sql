/*VERIFICA CONTAS EM PROCESSAMENTO*/
select 
      c.num_apoli,
      b.seq_numer_prs,
      a.dhr_inici_prt,
      a.dhr_fim_prt,
      a.dhr_alter,
      a.cod_auten_usu,
      a.ctl_contr_taf,
      a.num_taref_val,
      c.*
from gedad.tdad_contr_tarefa_validacao a
, gedad.v_dad_consulta_procs_propt_bilhe b
, bilhet.tbil_proposta c
where a.dhr_fim_prt is null
and b.ctl_contr_taf = a.ctl_contr_taf
and c.seq_numer_prs = b.seq_numer_prs
order by a.dhr_inici_prt

/*LIMPAR FILA DE PROCESSAMENTO*/
DELETE FROM GEDAD.TDAD_CONTR_TAREFA_VALIDACAO
WHERE DHR_FIM_PRT IS NULL
AND CTL_CONTR_TAF IN (
35155098
)

COMMIT 




SELECT * FROM bilhet.TBIL_PROPOSTA tp 
WHERE NUM_APOLI = 54000021474 


/*VERIFICAR SE EXISTE NUM_SEQUE_PRS NA TABELA ERROS DE PROCESSAMENTO*/
SELECT DISTINCT seq_numer_prs FROM gedad.tdad_procs_propt_bilhe
WHERE CTL_CONTR_TAF in (
35233294,
35233237,
35233150

)  -- ESSE C�DIGO VEM DO LOG DA APLICA��O CAMPO V_OUT_RESULT 
ORDER BY SEQ_NUMER_prs  ASC  

	

/* PROCESSO DE EXCLUS�O DE PROPOSTA PERDIDAS NAS TABELAS DE PROCESSAMENTO*/

/*DELETE 1*/
	DELETE
FROM
	bilhet.TBIL_RELAC_VISAO_PERCU_PADRA
WHERE
	(SEQ_NUMER_PRS,
	SEQ_NUMER_AVB) IN (
	SELECT
		trap.SEQ_NUMER_PRS,
		ta.SEQ_NUMER_AVB
	FROM
		bilhet.TBIL_AVERBACAO ta
	INNER JOIN bilhet.TBIL_RELAC_AVERB_PROPT trap ON
		trap.SEQ_NUMER_AVB = ta.SEQ_NUMER_AVB
	INNER JOIN bilhet.TBIL_PROPOSTA tp ON
		tp.SEQ_NUMER_PRS = trap.SEQ_NUMER_PRS
	WHERE
		tp.SEQ_NUMER_PRS IN 
(
506340,
506341,
507328
)
AND trap.NUM_ETAPA_AVB = 1
AND trap.SEQ_NUMER_FAT + 0 IS NULL);

commit

/*DELETE 2*/
--
delete FROM bilhet.TBIL_RELAC_VISAO_PERCU_PROPT	
WHERE
(SEQ_NUMER_PRS,
SEQ_NUMER_AVB) IN (
SELECT
	trap.SEQ_NUMER_PRS,
	ta.SEQ_NUMER_AVB
FROM
	bilhet.TBIL_AVERBACAO ta
INNER JOIN bilhet.TBIL_RELAC_AVERB_PROPT trap ON
	trap.SEQ_NUMER_AVB = ta.SEQ_NUMER_AVB
INNER JOIN bilhet.TBIL_PROPOSTA tp ON
	tp.SEQ_NUMER_PRS = trap.SEQ_NUMER_PRS
WHERE
		tp.SEQ_NUMER_PRS IN 
(
506340,
506341,
507328

)
	AND trap.NUM_ETAPA_AVB = 1
	AND trap.SEQ_NUMER_FAT + 0 IS NULL);
--


/*DELETE 3*/
DELETE
FROM
	BILHET.TBIL_RELAC_VISAO_PROPT
WHERE
	(SEQ_NUMER_PRS,
	SEQ_NUMER_AVB) IN (
	SELECT
		trap.SEQ_NUMER_PRS,
		ta.SEQ_NUMER_AVB
	FROM
		bilhet.TBIL_AVERBACAO ta
	INNER JOIN bilhet.TBIL_RELAC_AVERB_PROPT trap ON
		trap.SEQ_NUMER_AVB = ta.SEQ_NUMER_AVB
	INNER JOIN bilhet.TBIL_PROPOSTA tp ON
		tp.SEQ_NUMER_PRS = trap.SEQ_NUMER_PRS
	WHERE
		tp.SEQ_NUMER_PRS IN 
(
506340,
506341,
507328

)
AND trap.NUM_ETAPA_AVB = 1
		AND trap.SEQ_NUMER_FAT + 0 IS NULL);

COMMIT


/*CONSULTA DEBITO CREDITO*/
SELECT * FROM  bilhet.tbil_vigencia_proposta_credb
    WHERE SEQ_CREDB_PRS IN (
    SELECT b.SEQ_CREDB_PRS FROM bilhet.tbil_proposta_credito_debito a INNER JOIN bilhet.tbil_vigencia_proposta_credb B
    ON b.SEQ_CREDB_PRS = a.SEQ_CREDB_PRS 
    WHERE a.SEQ_NUMER_PRS IN(506273,
506274,
508176
)
--	AND b.DAT_INICI_VIG >= '2024-03-01'
--	AND b.DAT_FIM_VIG <= '2024-03-31'
    )

COMMIT

    
 /*VOLTA DEBITO E CREDITO*/
    UPDATE bilhet.tbil_vigencia_proposta_credb SET 
    SEQ_NUMER_fat = NULL 
    WHERE SEQ_CREDB_PRS IN (
    SELECT b.SEQ_CREDB_PRS FROM bilhet.tbil_proposta_credito_debito a INNER JOIN bilhet.tbil_vigencia_proposta_credb B
    ON b.SEQ_CREDB_PRS = a.SEQ_CREDB_PRS 
    WHERE a.SEQ_NUMER_PRS IN(506273,
506274,
508176
)
	AND b.DAT_INICI_VIG >= '2024-06-01'
	AND b.DAT_FIM_VIG <= '2024-06-30'
    )



/*CANCELA FATURA*/	
SELECT * FROM BILHET.TBIL_FATURA tf 
WHERE SEQ_NUMER_PRS IN (506273,
506274,
508176
)
AND NUM_MES_CPT = 202406
ORDER BY DHR_FATUR DESC  


UPDATE BILHET.TBIL_FATURA SET
SIT_FATUR = 6
,IDT_ENVIO_CBR = 'C'
,NUM_MOTIV_SIT = 6
WHERE SEQ_NUMER_PRS = 506377
AND NUM_MES_CPT = 202402


SELECT * FROM bilhet.TBIL_TIPO_TARIFA_PROPOSTA tttp 



UPDATE bilhet.TBIL_TIPO_TARIFA_PROPOSTA SET 
NOM_APELI_TAR = 'Desconto Comercial[Exc.Tx.Roubo, Tx.Emb e C.Risco]'
WHERE NUM_TARIF = 12

COMMIT



SELECT * FROM bilhet.TBIL_AVERBACAO ta 
WHERE DHR_ALTER >= '2024-04-11'
AND COD_CNPJ_TOMADOR  = '' x'



SELECT * FROM bilhet.TBIL_PROPOSTA tp 
WHERE tp.num_apoli in (3836900028055,3836901107854 )