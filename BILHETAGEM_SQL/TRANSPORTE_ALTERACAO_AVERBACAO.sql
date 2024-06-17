SELECT DISTINCT TIP_DOCUM_TRA  FROM AVERBACAO 
WHERE CTL_AVERB = 682910115

SELECT TIP_DOCUM_TRA, DES_DOCUM_TRA  FROM TIPO_DOCUM_TRANSP


SELECT * FROM TTIPO_DOCUMENTO 

SELECT * FROM AVERBACAO_MOTOT 
WHERE CTL_AVERB = 682910115


SELECT * FROM APLTRANS.TPRACA 

SELECT * FROM TITEM_DESTINO 
WHERE CTL_AVERB = 682910115

SELECT * FROM AVERBACAO_VEICULO 

select tab.tabschema as schema_name,
    tab.tabname as table_name,
    tab.create_time,
    tab.alter_time
from syscat.tables tab
where tab.type = 'T'
    and tab.TABNAME LIKE '%AVERBACAO%'
order by tab.tabschema, tab.tabname 


UPDATE AVERBACAO SET  
COD_MANIF = ?
,DAT_EMBAR = ?
,HOR_EMBAR =?
,VLR_EMBAR =?
,NUM_LOCAL_ORI =? 
,COD_CEP=? 
,DHR_ENTRA --dt recebimento
,DHR_AVERB --dt entrada
WHERE CTL_AVERB =?

UPDATE ITEM_DESTINO SET 
num_seque_ite=?
,num_local=?
,cod_manif=?
,num_conhe=?
,num_ntfis=?
,num_praca=?
,num_esper_mer=?
,tip_trnsp=?
,vlr_merca=?
,qtd_merca=?
,des_espei=?
,qtd_peso=?
,tip_isenc_seg=?
,qtd_volum=?
,cod_user=?
,dhr_alter=?
,num_seque_mer=?
,dat_emiss_doc=?
,sta_carga_dga=?
,sta_icame=?
,sta_rfluv=?
,sta_autlo=?
,tip_frete=?
,num_praca_ori=?
,tip_embal=?
,num_praca_emi=?
,pce_tarif_cbr=?
,sta_trech=?
WHERE CTL_AVERB = ?
AND num_seque_ite = ?


SELECT * FROM ITEM_DESTINO 


--SELECT PARA RESGATAR OS MOTORISTAS DA BASE CORPORATIVA
SELECT CTL_MOTOT
, TIP_DOCUM
, COD_DOCUM_MOT
, NOM_MOTOT 
FROM MOTORISTA_MOVTO
WHERE COD_DOCUM_MOT =?
AND TIP_DOCUM = 2

--INSERT CASO MOTORISTA PESQUISADO N�O EXISTA NA TABELA.
INSERT INTO MOTORISTA_MOVTO (CTL_MOTOT, TIP_DOCUM, COD_DOCUM_MOT, NOM_MOTOT, COD_USER, DHR_ALTER)
VALUES(SEQUENCE,2,?,?,?,CURRENT TIMESTAMP)


--RETORNAR TODOS OS TIPOS DE DOCUMENTO
SELECT tip_docum, des_tipo_doc, num_pais
FROM TTIPO_DOCUMENTO

--RETORNA OS DOCUMENTOS POR PAIS
SELECT tip_docum, des_tipo_doc, num_pais
FROM TTIPO_DOCUMENTO
WHERE NUM_PAIS = ?

--RETORNA O DOCUMENTO PELO C�DIGO
SELECT tip_docum, des_tipo_doc, num_pais
FROM TTIPO_DOCUMENTO
WHERE TIP_DOCUM = ?


--RETORNA OS DOCUMENTOS PELA DESCRI��O DO DOCUMENTO
SELECT tip_docum, des_tipo_doc, num_pais
FROM TTIPO_DOCUMENTO
WHERE DES_TIPO_DOC LIKE UCASE(?)


DELETE FROM AVERBACAO_VEICULO
WHERE CTL_AVERB = ?
AND UPPER(COD_IDENT_VEI) = UPPER(?)
AND NUM_SEQUE_VEI =? 

INSERT INTO AVERBACAO_VEICULO (CTL_AVERB, NUM_SEQUE_VEI, COD_IDENT_VEI, TIP_VEICU, COD_USER, DHR_ALTER)
VALUES(?, UPPER(?), 3, ?,CURRENT TIMESTAMP)




SELECT * FROM AVERBACAO_VEICULO 
WHERE 

DELETE from AVERBACAO_MOTOT
WHERE CTL_AVERB = ?
AND CTL_MOTOT = ?

INSERT AVERBACAO_MOTOT (CTL_AVERB, CTL_MOTOT, COD_USER, DHR_ALTER)
CTL_AVERB
CTL_MOTOT
COD_USER
DHR_ALTER
TIP_MOTOT
TIP_CATEG_MSG
WHERE CTL_AVERB =


SELECT * FROM AVERBACAO_INDICE 

SELECT * FROM MOTORISTA_MOVTO
WHERE CTL_AVERB =

SELECT * FROM ITEM_DESTINO

WHERE CTL_AVERB = 682907028


SELECT * FROM base_merca

SELECT * FROM TTIPO_CLASS_MERCA

SELECT NUM_MERCA_PAM , NUM_SEQUE_MER , count(*) FROM SINONIMO_MERCA  
GROUP BY NUM_MERCA_PAM , Num_seque_mer

SELECT * FROM SINONIMO_MERCA  
WHERE DES_MERCA_PAM LIKE ''

SELECT * FROM MERC_ESPECIFICA 

SELECT DISTINCT NUM_MOEDA  FROM AVERBACAO

WHERE NUM_MERCA_PAM = 1946
AND NUM_SEQUE_MER = 1





SELECT * FROM AVERBACAO 
WHERE CTL_AVERB =682917210
ORDER BY NUM_SEQUE_ITE 

-- TAXA ADICIONAL num_fator_agr = 16
--VALOR SEGURADO num_fator_agr = 17 
--PREMIO PAMTAX Num_fator_agr = 20 
select a.NUM_FATOR_AGR,b.NOM_FATOR_AGR,a.vlr_fator_agr from resultado_agrava  a,fator_agrava b
where a.NUM_FATOR_AGR = b.NUM_FATOR_AGR
and a.num_fator_agr in (16,17, 20)
AND a.CTL_AVERB = 589444195
ORDER BY a.num_fator_agr ASC 


select a.ctl_averb, a.NUM_FATOR_AGR , b.NOM_FATOR_AGR, a.VLR_FATOR_AGR from resultado_agrava  a,fator_agrava b
	where a.NUM_FATOR_AGR = b.NUM_FATOR_AGR

/* VALOR SEGURADO
 * select b.NOM_FATOR_AGR,a.vlr_fator_agr from resultado_agrava  a,fator_agrava b
	where a.CTL_AVERB = <Id Averbacao>
		and a.NUM_FATOR_AGR = b.NUM_FATOR_AGR
		and a.num_fator_agr in (20)

SELECT 
VLR_FATOR_AGR --valor segurado
FROM RESULTADO_AGRAVA
WHERE CTL_AVERB = <id AVERBACAO> 
AND  NUM_FATOR_AGR = 20

*/

/*
 * TAXA ADICIONAL
 * 
 * "select b.NOM_FATOR_AGR,a.vlr_fator_agr from resultado_agrava  a,fator_agrava b
where a.CTL_AVERB = <Id Averbacao>
and a.NUM_FATOR_AGR = b.NUM_FATOR_AGR
and a.num_fator_agr in (16)"

SELECT 
VLR_FATOR_AGR --valor segurado
FROM RESULTADO_AGRAVA
WHERE CTL_AVERB = <id AVERBACAO> 
AND  NUM_FATOR_AGR = 16


 */

sELECT * FROM APLTRANS.TMERC_ESPECIFICA

SELECT * FROM MERCADORIA 

SELECT * FROM HIST_AVERBACAO 



SELECT * FROM TFATOR_AGRAVA 
SELECT * FROM SITUACAO_AVERBACAO  
ORDER BY CTL_AVERB DESC 
''



SELECT A.NUM_APOLI
,b.ctl_pesso
,b.NOM_FANTS || ' ' || b.COD_DOCUM_PRI
,c.num_ramo_seg
,c.SIG_RAMO
,a.num_propt
,d.DES_SITUA_TIP
,e.NOM_CIA_PAM
,CASE WHEN e.IDT_DIVIS_RCT='PC' THEN
	'Pamcary'
	ELSE
	'Pamcorp'
END
FROM SEG_PROPOSTA_SEGURO A
,CRP_PESSOA B
,APLTRANS.V_CRP_RAMO_SEGURO c
,sEG_SITUACAO_TIPO_PROPOSTA d
,v_CRP_CIA_SEGURADORA_PAMCARY e
WHERE A.CTL_CLIEN_PPS = B.CTL_PESSO
AND a.num_ramo_seg = c.NUM_RAMO_SEG
AND a.SIT_TIPO_PRS = d.SIT_TIPO_PRS
AND a.TIP_PROPT = d.TIP_PROPT
AND a.NUM_CIA_PAM = e.NUM_CIA_PAM
AND A.TIP_PROPT = 1
AND A.NUM_APOLI = 3836000106501
AND a.NUM_PROPT = 17001954

SELECT * FROM SEG_PROPOSTA_SEGURO 
WHERE  NUM_APOLI = 3836000106501


SELECT * FROM V_CRP_MOEDA 

SELECT * FROM AVERBACAO 


SELECT
        COALESCE (SUM (A.VLR_EMBAR),
        0)
FROM
        V_AVERBACAO_VEICULO_NEW A ,
        SEG_PROPOSTA_SEGURO x ,
        SITUACAO_AVERBACAO S1
LEFT JOIN RELAC_AVERBACAO_ATM RAA ON
        RAA.CTL_AVERB = A.CTL_AVERB
LEFT OUTER JOIN averbacao_impor_atm AIA ON
        AIA.ctl_ATM = RAA.ctl_ATM
WHERE
        x.NUM_PROPT = A.NUM_PROPT
        AND x.NUM_VERSA_PRS = 1
        AND X.TIP_PROPT = 1
        AND S1.SIT_AVERB = A.SIT_AVERB
        AND A.DHR_AVERB BETWEEN '2023-09-19 00:00:00' AND '2023-09-19 23:59:59'
OPTIMIZE FOR 1 ROWS WITH UR





SELECT
	VA.NUM_AVERB AS averbacao,
	VA.NUM_SEQUE_HIS AS seq,
	CHAR(VA.DAT_EMBAR, LOCAL) AS dataEmbarque,
	CHAR(DATE(VA.DHR_ENTRA), LOCAL) || ' ' || CHAR(TIME(VA.DHR_ENTRA), LOCAL) AS dataHoraEntrada,
	CHAR(DATE(VA.DHR_ALTER), LOCAL) || ' ' || CHAR(TIME(VA.DHR_ALTER), LOCAL) AS dataHoraAlteracao,
	CHAR(DATE(VA.DHR_AVERB), LOCAL) || ' ' || CHAR(TIME(VA.DHR_AVERB), LOCAL) AS dataHoraAverbacao,
	TM.SIG_simbo_MOE AS moeda,
	FLOAT(ROUND(VA.VLR_EMBAR, 2)) AS valorEmbarque,
	TA.DES_TIPO_AVB AS tipoAverbacao,
	RA.SIG_RAMO AS ramo,
	SA.DES_SITUA_AVB AS situacaoAverbacao,
	VA.COD_USER AS usuario,
	CHAR(DATE(VA.DHR_ALTER), LOCAL) || ' ' || CHAR(TIME(VA.DHR_ALTER), LOCAL) AS dataHoraAtualizacao
FROM
	V_AVERBACAO_888 VA,
	crp_moeda TM,
	TIPO_AVERBACAO TA,
	crp_RAMO_seguro RA,
	SITUACAO_AVERBACAO SA
WHERE
	CTL_AVERB = 753050071
	AND VA.NUM_MOEDA = TM.NUM_MOEDA
	AND VA.TIP_AVERB = TA.TIP_AVERB
	AND VA.NUM_RAMO = RA.NUM_RAMO_seg
	AND VA.SIT_AVERB = SA.SIT_AVERB
UNION
SELECT
	B.NUM_AVERB AS averbacao,
	A.NUM_SEQUE_HIS AS seq,
	CHAR(A.DAT_EMBAR, LOCAL) AS dataEmbarque,
	CHAR(DATE(A.DHR_ENTRA), LOCAL) || ' ' || CHAR(TIME(A.DHR_ENTRA), LOCAL) AS dataHoraEntrada,
	CHAR(DATE(A.DHR_ALTER), LOCAL) || ' ' || CHAR(TIME(A.DHR_ALTER), LOCAL) AS dataHoraAlteracao,
	CHAR(DATE(A.DHR_AVERB), LOCAL) || ' ' || CHAR(TIME(A.DHR_AVERB), LOCAL) AS dataHoraAverbacao,
	TM.SIG_simbo_moe AS moeda,
	FLOAT(ROUND(A.VLR_EMBAR, 2)) AS valorEmbarque,
	TA.DES_TIPO_AVB AS tipoAverbacao,
	RA.SIG_RAMO AS ramo,
	SA.DES_SITUA_AVB AS situacaoAverbacao,
	A.COD_USER AS usuario,
	CHAR(DATE(A.DHR_ALTER), LOCAL) || ' ' || CHAR(TIME(A.DHR_ALTER), LOCAL) AS dataHoraAtualizacao
FROM
	HIST_AVERBACAO A,
	AVERBACAO_INDICE B,
	crp_moeda TM,
	TIPO_AVERBACAO TA,
	crp_RAMO_seguro RA,
	SITUACAO_AVERBACAO SA
WHERE
	A.CTL_AVERB = 753050071
	AND A.CTL_AVERB = B.CTL_AVERB
	AND A.NUM_MOEDA = TM.NUM_MOEDA
	AND B.TIP_AVERB = TA.TIP_AVERB
	AND B.NUM_RAMO = RA.NUM_RAMO_seg
	AND B.SIT_AVERB = SA.SIT_AVERB
ORDER BY
	SEQ DESC
	
	
	
	
	SELECT * FROM averbacao a, ITEM_DESTINO i 
	WHERE a.CTL_AVERB = i.CTL_AVERB
	AND a.CTL_AVERB = 597453217 
	
	SELECT * FROM AVERBACAO_INDICE 
	WHERE CTL_AVERB = 597453217 
	
	
	SELECT * FROM AVERBACAO_MOTOT 
	WHERE CTL_AVERB = 597453216 
	
	
	SELECT * FROM MOTORISTA_MOVTO 
	WHERE COD_DOCUM_MOT = '000000000920641'

	
	
	SELECT * FROM AVERBACAO_VEICULO 
	WHERE CTL_AVERB = 597453217 
	
	SELECT * FROM v_crp_pessoa WHERE CTL_PESSO = 97 6686 
	cod_docum_pri = '33183864000145'
	
	CTL_PESSO = 6686
	SELECT * FROM VINCULADO WHERE ctl_vincd =  500250--2866
	SELECT * FROM DOC_VINCULADO WHERE cod_docum='32717811000285'	
	SELECT * FROM PRACA WHERE NUM_PRACA = 130
	
	
	
	SELECT DISTINCT d.CTL_VINCD,v.NOM_GUERR  FROM DOC_VINCULADO D, VINCULADO V
	WHERE V.CTL_VINCD = D.CTL_VINCD
	AND D.COD_DOCUM = '32717811000285'
	
	COD_CEP - NOK
	NUM_LOCAL_ORI -OK (26)
	NUM_PRACA_ORI -NOK
	NUM_PRACA_DES -NOK
	NUM_MERCA -NOK
	NUM_MOEDA -OK
	SIT_MOTOT -NOK
	DAT_EMBAR -OK (2023-10-09)
	HOR_EMBAR -NOK
	DHR_AVERB -NOK
	DHR_ENTRA -OK
	DHR_LIBER -NOK
	VLR_EMBAR -OK
	TIP_DOCUM_TRA -OK
	COD_MANIF -OK (25535)
	STA_RCF 
	STA_RFLUV
	NUM_SEQUE_HIS -OK
	COD_USER -OK
	DHR_ALTER -OK
	SIT_ESCOL
	SIT_MONIT
	TIP_MOTOT -NOK
	CTL_PESSO_GOG
	
	
	
	SELECT * FROM PAMAIS.V_CRP_PESSOA
	WHERE COD_DOCUM_PRI = '11908771000106'
	CTL_PESSO = 210972

 
	
	SELECT * FROM VINCULADO 
	WHERE CTL_VINCD = 500250--511630
	
	SELECT DISTINCT CTL_VINCD FROM DOC_VINCULADO D, VINCULADO V 
	WHERE V.CTL_VINCD = D.CTL_VINCD  
	AND D.COD_DOCUM = '11908771000106'
	CTL_VINCD = 500250--511630
	
	
	
	
	SELECT * FROM AVERBACAO_INDICE 
	WHERE CTL_AVERB = 597453172--597453211
	
	CTL_AVERB -OK
	TIP_AVERB -OK
	NUM_AVERB -OK
	NUM_PROPT -OK
	CTL_VINCD_SED -OK
	NUM_RAMO -OK
	SIT_AVERB -OK
	SIT_TRANS -OK
	CTL_PESSO -NOK
	NUM_VERSA_PRS -NOK
	
	SELECT * FROM AVERBACAO_MOTOT
	WHERE CTL_AVERB = 597453198
	
	CTL_AVERB -NOK
	CTL_MOTOT -NOK
	COD_USER - NOK
	DHR_ALTER -NOK

	SELECT * FROM AVERBACAO_VEICULO 
	WHERE CTL_AVERB = 597453198--597453172--597453211
	
	CTL_AVERB -NOK
	NUM_SEQUE_VEI -NOK
	COD_IDENT_VEI -NOK
	TIP_VEICU -NOK
	COD_USER -NOK
	DHR_ALTER -NOK
	
	
	SELECT *  FROM ITEM_DESTINO 
	WHERE CTL_AVERB = 597453172--597453211
	
	CTL_AVERB -OK
	NUM_LOCAL -OK
	NUM_SEQUE_ITE -OK
	COD_MANIF -NOK (1901582)
	NUM_CONHE 
	NUM_NTFIS
	NUM_PRACA
	NUM_ESPEI_MER
	TIP_TRNSP
	VLR_MERCA
	QTD_MERCA
	DES_ESPEI
	QTD_PESO
	TIP_ISENC_SEG
	QTD_VOLUM
	COD_USER
	DHR_ALTER
	NUM_SEQUE_MER
	DAT_EMISS_DOC
	HOR_EMISS_DOC
	STA_CARGA_DGA
	STA_ICAME
	STA_RFLUV
	STA_AUTLO
	TIP_FRETE
	NUM_PRACA_ORI
	TIP_EMBAL
	NUM_PRACA_EMI
	PCE_TARIF_CBR
	STA_TRECH
	
	
	
	SELECT * FROM PRACA 
	WHERE NUM_PRACA = 846
	
	SELECT * FROM UNIDADE_FEDERAL 
	WHERE NUM_UNFED = 26
	
	
	
	SELECT * FROM apltrans.taverbacao
	ORDER BY DHR_ALTER DESC
	LIMIT 1
	
	SELECT * FROM AVERBACAO_INDICE 
	
		SELECT * FROM SITUACAO_AVERBACAO
		SELECT * FROM AVERBACAO_CONSISTENCIA 
		
		SELECT * FROM TRANSMISSAO 
		
		
		SELECT * FROM APLTRANS.TSINONIMO_MERCA 
		WHERE NUM_MERCA_PAM  = 17645 
		SELECT * FROM APLTRANS.TMERC_ESPECIFICA 
		SELECT * FROM APLTRANS.TITEM_DESTINO 
		

/**ALTERAR EM AMBIENTE DE PRODU��O**/
ALTER TABLE TRANSPORTE.TITEM_DESTINO ALTER COLUMN DES_ESPEI
 SET DATA TYPE  CHARACTER(100) ;
CALL SYSPROC.ADMIN_CMD('REORG TABLE TRANSPORTE.TITEM_DESTINO');





SELECT * FROM AVERBACAO 
WHERE CTL_AVERB = 597453277

SELECT * FROM AVERBACAO_INDICE  
WHERE CTL_AVERB = 597453277


SELECT * FROM AVERBACAO_MOTOT 
WHERE CTL_AVERB = 597453277

SELECT * FROM ITEM_DESTINO  
WHERE CTL_AVERB = 597453277

SELECT * FROM TRESULTADO_AGRAVA 
WHERE CTL_AVERB = 597453277

SELECT * FROM TSEG_PROPOSTA_SEGURO  
WHERE NUM_APOLI = 123

SELECT * FROM AVERBACAO_VEICULO 
WHERE CTL_AVERB = 597453277


SELECT * FROM CRP_PESSOA 
WHERE CTL_PESSO = 35303

SELECT * FROM VINCULADO 
WHERE CTL_VINCD = 878702

SELECT * FROM PRACA 
WHERE NUM_PRACA = 1556



		


SELECT * FROM AVERBACAO_INDICE 
WHERE CTL_AVERB = 678579016


SELECT * FROM APLTRANS.AVERBACAO 
WHERE CTL_AVERB = 678579016

SELECT * FROM apltrans.AVERBACAO_VEICULO 
WHERE CTL_AVERB = 678579016
	

SELECT * FROM apltrans.AVERBACAO_MOTOT 
WHERE CTL_AVERB = 678579016
	

SELECT * FROM apltrans.tunidade_federal
	
SELECT * FROM APLTRANS.TIPO_EMBALAGEM

SELECT * FROM SYSCAT."REFERENCES" r 
WHERE CONSTNAME LIKE '%AVB_VEICULO_FK%'

SELECT * FROM APLTRANS.TIPO_VEICULO 



Select * from seg_proposta_seguro a
, averbacao_indice b, averbacao c, SEG_proposta_limite d
Where a.ctl_vincd_sed = b.ctl_pesso
And a.num_ramo_seg = b.num_ramo_seg
And a.tip_propt = 1 -- (propostas de seguro)
And a.sit_tipo_prs = 1 -- (apolice vigente)
And a.ctl_averb = c.ctl_averb
AND A.NUM_PROPT = D.NUM_PROPT
AND A.NUM_VERSA_PRS = D.NUM_VERSA_PRS
And c.dat_embar between a.dat_inici_vig and a.dat_fim_vig
AND a.NUM_PROPT NOT BETWEEN 55000000 aND 55999999
AND a.NUM_PROPT NOT BETWEEN 999000000 AND 999999999
And a.ctl_averb = 573027701




Select *  from aplseg.seg_proposta_seguro a ,averbacao_indice b,averbacao c
Where a.ctl_clien_pps  = b.ctl_pesso
And a.num_ramo_seg = b.num_ramo
And a.tip_propt = 1 --(propostas de seguro)
And a.sit_tipo_prs = 1-- (apolice vigente)
And b.ctl_averb = c.ctl_averb
And c.dat_embar between  a.dat_inici_vig and a.dat_fim_vig
AND a.NUM_PROPT NOT BETWEEN 55000000 aND 55999999
AND a.NUM_PROPT NOT BETWEEN 999000000 AND 999999999
And b.ctl_averb =570622739


SELECT * FROM AVERBACAO_CONSISTENCIA
SELECT * FROM apltrans.transmissao

SELECT * FROM TPRACA 

SELECT * FROM averbacao_consistencia
SELECT * FROM transmissao

