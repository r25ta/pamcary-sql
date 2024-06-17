
AND NUM_FATUR_CIA in( 3836000100854)
--AND SEQ_NUMER_PRS IN (501405)
AND SEQ_NUMER_FAT IN (7000218936,7000218881)

7000214718 ok
 nok
7000214677 ok


AND NUM_FATUR_CIA in( 3836000100854)

SELECT * FROM BILHET.TBIL_PROPOSTA tp 
--WHERE SEQ_NUMER_PRS in (502107,502108)

WHERE NUM_APOLI IN (2355001360631)

SEQ_NUMER_prs IN (499076
,499076)

IN (7000213801,7000218473)

SELECT * FROM PAMAIS.V_CRP_PESSOA 
WHERE NOM_PESSO LIKE '%ATLAS DO SUL%'
--WHERE COD_DOCUM_PRI IN ('017311589000141'
)

/*
1059101	CASTLOG LOGISTICA
825347	ARAUJO LOG
793478	CASTLOG TRANSPORTES
785192	M&F TRANSPORTE E LOG
740044	PARALOG
743701	A S PIRES TRANSPORTE
**/

Apolice :5400024729
Fatura nro 174049
Cnpj 41130535000164

SELECT * FROM RAMO 

SELECT p.seq_numer_prs
	  ,p.num_apoli 
	  ,p.num_propt
	  ,p.num_ramo_seg
	  ,r.sig_ramo
	  ,p.num_perio
	  ,f.seq_numer_fat
	  ,f.num_mes_cpt
	  ,f.dat_venci_fat
	  ,f.sit_fatur
	  ,f.sit_envio_fat
FROM BILHET.TBIL_PROPOSTA P
	,DBPROD.RAMO R 
	,bilhet.TBIL_FATURA F 
WHERE r.num_ramo = p.num_ramo_seg
AND p.seq_numer_prs = f.seq_numer_prs
and p.CTL_PESSO_CLI IN (646639)



SELECT * FROM bilhet.TBIL_FATURA tf 
WHERE SEQ_NUMER_FAT IN (7000312061)
AND SIT_FATUR <> 6
503297 1 rctrc
,503298 2 rfdc



/*RECUPERA INFORMA��ES DA APOLICE E DAS FATURAS*/
select p.seq_numer_prs
	  ,p.num_apoli
	  ,f.seq_numer_fat
	  ,f.dat_venci_fat
	  ,f.num_mes_cpt
	  ,f.num_fatur_cia
	  ,p.num_propt
	  ,p.dat_inici_vig
	  ,p.dat_fim_vig
from bilhet.tbil_proposta p 
	,bilhet.tbil_fatura f 
WHERE p.SEQ_NUMER_PRS = f.SEQ_NUMER_PRS 
AND f.NUM_MES_CPT BETWEEN 202310 AND 202312
AND f.SEQ_NUMER_PRS IN (505658)
ORDER BY f.SEQ_NUMER_FAT DESC 


SELECT * FROM BILHET.TBIL_FATURA tf 
WHERE SEQ_NUMER_FAT = 7000320190


SELECT * FROM bilhet.TBIL_PROPOSTA tp 
WHERE SEQ_NUMER_PRS = 507708


SELECT * FROM bilhet.TBIL_FILA_ARQUIVO_DOCUM_WEB

SELECT * FROM bilhet.TBIL_ARQUIVO_DOCUMENTO_WEB tadw 
--ORDER BY DHR_ALTER DESC 
WHERE SEQ_NUMER_FAT = 7000322354
AND STA_DOWN <> 'S'


SELECT * FROM DBPROD.DOWNLOAD_ARQUIVO  
					WHERE NOM_ARQUI LIKE '%540030886%'
					IN ( SELECT NOM_ARQUI 
					FROM BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB)

					SELECT * FROM BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB D WHERE D.SEQ_NUMER_FAT IN (7000322354)
AND D.NUM_ARQUI_RET =2 

SELECT *  FROM DBPROD.TDOWNLOAD_ARQUIVO
WHERE NUM_ARQUI IN ( SELECT NUM_ARQUI FROM DBPROD.DOWNLOAD_ARQUIVO 
					WHERE NOM_ARQUI IN ( SELECT NOM_ARQUI 
					FROM BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB 
					WHERE SEQ_NUMER_FAT IN(
7000322354)
))



/*DELETE DBPROD.TDOWNLOAD_ARQUIVO*/
DELETE FROM DBPROD.TDOWNLOAD_ARQUIVO
WHERE NUM_ARQUI IN ( SELECT NUM_ARQUI FROM DBPROD.DOWNLOAD_ARQUIVO 
					WHERE NOM_ARQUI IN (SELECT NOM_ARQUI 
					FROM BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB 
					WHERE SEQ_NUMER_FAT IN(07000222881
,07000271428
,07000273864
,07000223678
,07000223066
,07000224551
,07000224873
,67999976136)
))


SELECT * 
					FROM BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB 
					WHERE SEQ_NUMER_FAT IN (7000312061)

/*DELETE BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB*/
DELETE FROM BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB 
WHERE SEQ_NUMER_FAT IN (7000280456
,7000280458
,7000280315
,67999976491)

COMMIT 


SELECT * FROM bilhet.TBIL_FATURA tf 
WHERE DHR_FATUR > '2023-12-01'
AND SIT_FATUR NOT IN (1,3,6)
--AND NUM_FATUR_CIA > 0
AND NUM_MES_CPT = '202311'
AND SEQ_NUMER_FAT = 7000313696


SELECT * FROM (
SELECT F.SEQ_NUMER_FAT as fatura,
			        P.NUM_APOLI as apolice,
			        P.NUM_RAMO_SEG as ramo,
			        F.NUM_MES_CPT as competencia,
			        F.NUM_PERIO_FAT as periodo,
			        '' as caminho,  
			        F.SIT_FATUR as situacao,  
			        (SELECT COUNT(D.SEQ_NUMER_FAT) FROM BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB D WHERE D.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT AND D.NUM_ARQUI_RET =2) as aviso, 
			        CASE WHEN (SELECT COUNT(S.SEQ_NUMER_FAT) FROM BILHET.TBIL_VALOR_SOMA_TIPO_TARIFA S WHERE S.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT AND S.NUM_TARIF = 70 AND S.VLR_CALCU > 1 AND F.SIT_FATUR NOT IN(1,3,4,6))>0 THEN  
			         (SELECT COUNT(D.SEQ_NUMER_FAT) FROM BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB D WHERE D.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT AND D.NUM_ARQUI_RET =1)
			        ELSE -1 END AS embarque, 
			        CASE WHEN (SELECT COUNT(S.SEQ_NUMER_FAT) FROM BILHET.TBIL_VALOR_SOMA_TIPO_TARIFA S WHERE S.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT AND S.NUM_TARIF = 27)>0 THEN  
			         (SELECT COUNT(D.SEQ_NUMER_FAT) FROM BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB D WHERE D.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT AND D.NUM_ARQUI_RET =9) 
			        ELSE -1 END AS pamtax, 
			        (SELECT V.CTL_VINCD FROM DBPROD.tDOC_VINCULADO V WHERE V.COD_DOCUM = VP.COD_DOCUM_PRI AND VP.TIP_PESSO = 1) codigoVinculado, 
			        H.NUM_SETOR_PAM AS numeroFilial, 
			        CO.NUM_CORRE_PAM AS codigoCorretor, 
		            PR.CTL_PRODR AS codigoProdutor 
FROM BILHET.TBIL_FATURA F INNER JOIN BILHET.TBIL_PROPOSTA P ON (F.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS) 
 INNER JOIN PAMAIS.V_CRP_PESSOA VP ON (P.CTL_PESSO_CLI = VP.CTL_PESSO AND VP.TIP_PESSO = 1) 
 INNER JOIN PAMAIS.V_CRP_CORRETOR_PARCEIRO CO ON (P.CTL_CORRE = CO.CTL_CORRE) 
 INNER JOIN APLBIL.BIL_HIERQ_PRODR_PROPT PR ON (P.SEQ_NUMER_PRS = PR.SEQ_NUMER_PRS) 
 INNER JOIN APLBIL.V_CRP_HIERARQUIA_COMERCIAL H ON (PR.NUM_HIERQ = H.NUM_HIERQ AND H.TIP_SETOR = 2) 
LEFT JOIN BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB D ON (F.SEQ_NUMER_FAT = D.SEQ_NUMER_FAT) 
			    	WHERE 1=1
			    	AND F.NUM_FATUR_CIA > 0
			    	AND F.SIT_FATUR NOT IN(1,3,6)
/*			    	
			    	AND F.SEQ_NUMER_FAT IN ()
*/
			    	AND F.NUM_MES_CPT = 202311
			    	) A
			    	
			    WHERE AVISO = 0 --PAMTAX=0  --EMBARQUE = 0
--			    OPTIMIZE FOR 10 ROWS WITH UR
			    

SELECT * FROM BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB 
WHERE SEQ_NUMER_FAT IN 
--RELACAO EMBARQUE
(7000312061)



/* GERA��O DO ARQUIVO RETORNO MANUAL FMAP*/

select TAR.NOM_ARQUI_RET
      ,RFC.* 
from bilhet.tbil_RETOR_FATURA_CIA RFC
    ,BILHET.TBIL_TIPO_ARQUI_RETORNO TAR
WHERE  TAR.NUM_ARQUI_RET = RFC.NUM_ARQUI_RET
AND RFC.SEQ_NUMER_FAT in (7000312061)


SELECT * FROM DOWNLOAD_ARQUIVO 
WHERE NOM_ARQUI LIKE '%7000312061%'

DELETE FROM bilhet.TBIL_RETOR_FATURA_CIA 
WHERE SEQ_NUMER_FAT in (7000312061)

COMMIT 


/*incluir no Aviso de Cobrança geração Manual*/
insert into bilhet.TBIL_RETOR_FATURA_CIA values (7000322354,2,'ARQUIVO_MANUAL',NULL,NULL,current timestamp,current timestamp);
insert into bilhet.TBIL_RETOR_FATURA_CIA values (7000225846,2,'ARQUIVO_MANUAL',NULL,NULL,current timestamp,current timestamp);
insert into bilhet.TBIL_RETOR_FATURA_CIA values (7000228839,2,'ARQUIVO_MANUAL',NULL,NULL,current timestamp,current timestamp);
insert into bilhet.TBIL_RETOR_FATURA_CIA values (7000228855,2,'ARQUIVO_MANUAL',NULL,NULL,current timestamp,current timestamp);
insert into bilhet.TBIL_RETOR_FATURA_CIA values (7000228899,2,'ARQUIVO_MANUAL',NULL,NULL,current timestamp,current timestamp);
insert into bilhet.TBIL_RETOR_FATURA_CIA values (7000228948,2,'ARQUIVO_MANUAL',NULL,NULL,current timestamp,current timestamp);
insert into bilhet.TBIL_RETOR_FATURA_CIA values (7000228960,2,'ARQUIVO_MANUAL',NULL,NULL,current timestamp,current timestamp);
insert into bilhet.TBIL_RETOR_FATURA_CIA values (7000229002,2,'ARQUIVO_MANUAL',NULL,NULL,current timestamp,current timestamp);
insert into bilhet.TBIL_RETOR_FATURA_CIA values (7000229024,2,'ARQUIVO_MANUAL',NULL,NULL,current timestamp,current timestamp);
insert into bilhet.TBIL_RETOR_FATURA_CIA values (7000229082,2,'ARQUIVO_MANUAL',NULL,NULL,current timestamp,current timestamp);

commit







SELECT (
	SELECT COUNT(1) FROM bilhet.tBIL_VALOR_SOMA_TIPO_TARIFA V 
		WHERE V.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT 
		AND V.NUM_TARIF = 27) AS PAMTAX
	, F.SEQ_NUMER_FAT
	, P.NUM_RAMO_SEG AS RAMO
	, F.NUM_FATUR_CIA AS FAT_CIA
	, F.SIT_FATUR
	, P.CTL_PEJUR_CIA AS CIA
	, P.CTL_PESSO_CLI AS CLIENTE
	, F.NUM_MES_CPT AS COMPETENCIA
	, P.NUM_APOLI AS APOLICE
	, F.NUM_PERIO_FAT AS PERIODO 
FROM bilhet.tBIL_FATURA F 
	INNER JOIN bilhet.tBIL_PROPOSTA P 
		ON P.SEQ_NUMER_PRS = F.SEQ_NUMER_PRS 
	INNER JOIN bilhet.tBIL_RETOR_FATURA_CIA X 
		ON X.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT 
WHERE X.NOM_RETOR_PWB IS NULL





SELECT 
       AI.NUM_AVERB_PAM AS NUM_AVERB_PAM
     , A.SEQ_NUMER_AVB
     , P.SEQ_NUMER_PRS  
     , A.NUM_AVERB_CLI AS NUM_AVERB_CLI     
     , A.NUM_SEQUE_AVB AS NUM_SEQUE_AVB
     , A.COD_DOCUM_EMB AS MANIFESTO
     , (SELECT COD_IDENT_VEI FROM DBPROD.AVERBACAO_VEICULO V  WHERE V.CTL_AVERB = AI.NUM_AVERB_PAM  FETCH FIRST 1 ROWS ONLY) AS PLACA     
     , TRUNC(A.DHR_EMBAR) AS DHR_EMBAR
     , P.CTL_PEJUR_CIA AS CTL_PEJUR_CIA 
     , CIA.NOM_PESSO AS NOM_PEJUR_CIA
     , P.NUM_APOLI AS NUM_APOLI
     , CLI.NOM_PESSO AS NOM_FANTS_CLI
     , AP.VLR_IS AS TOTAL_EMBARCADO
     , DECODE(AI.VLR_PAMTX, 0, '', 'PX') STATUS_PAMTAX
     , CASE WHEN LO.TIP_LOCAL IN (1, 2) THEN LO.COD_IDENT_PAD ELSE LOR.COD_IDENT_PAD END ORIGEM 
     , CASE WHEN LD.TIP_LOCAL IN (1, 2) THEN LD.COD_IDENT_PAD ELSE LDE.COD_IDENT_PAD END DESTINO
     , (SELECT TP.PCE_TARIF_PEC FROM APLBIL.BIL_RELAC_VISAO_PERCU_PADRA RP 
         INNER JOIN APLBIL.BIL_VIGEN_TARIFA_PERCURSO TP ON (RP.CTL_VIGEN_PEC = TP.CTL_VIGEN_PEC)
         WHERE RP.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS AND RP.SEQ_NUMER_AVB = A.SEQ_NUMER_AVB
         FETCH FIRST 1 ROWS ONLY
        )AS TARIFA_PADRAO
     , (SELECT RP.VLR_TARIF_PEC FROM APLBIL.BIL_RELAC_VISAO_PERCU_PADRA RP 
         INNER JOIN APLBIL.BIL_VIGEN_TARIFA_PERCURSO TP ON (RP.CTL_VIGEN_PEC = TP.CTL_VIGEN_PEC)
         WHERE RP.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS AND RP.SEQ_NUMER_AVB = A.SEQ_NUMER_AVB
         ORDER BY RP.DHR_ALTER
         FETCH FIRST 1 ROWS ONLY
       ) AS PREMIO_TARIFA
     , FAT.NUM_MES_CPT 
     ,(SELECT  CASE WHEN COUNT(ST.SEQ_NUMER_FAT)=0 THEN 'N' ELSE 'S' END TEM_COMERCIAL
           FROM APLBIL.BIL_VALOR_SOMA_TIPO_TARIFA  ST 
           WHERE ST.NUM_TARIF = 16 AND ST.IDT_PREMI = 'C' AND ST.SEQ_NUMER_FAT = FAT.SEQ_NUMER_FAT FETCH FIRST 1 ROWS ONLY)
     , CASE WHEN A.STA_FLUVI =null THEN 'N' ELSE A.STA_FLUVI END TEM_FLUVIAL
     , (SELECT SUM(
                CASE WHEN TP.NUM_TARIF IN(36,37) THEN NVL(VC.VLR_TARIF,0.06)
                WHEN TP.NUM_TARIF IN (33,34) THEN NVL(VC.VLR_TARIF,0.00)
                ELSE  VC.VLR_TARIF END) AS TARIFA_PROPOSTA 
                FROM APLBIL.BIL_RELAC_TAXA_PROPOSTA TP
                INNER JOIN APLBIL.BIL_TIPO_TARIFA_PROPOSTA T ON (T.NUM_TARIF = TP.NUM_TARIF)
                INNER JOIN APLBIL.BIL_VIGENCIA_TAXA_CLIENTE VC ON (TP.NUM_SEQUE_TAR = VC.NUM_SEQUE_TAR)
                WHERE TP.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS AND TP.NUM_TARIF IN (15,16,33,34,36,37)
       ) AS TARIFA_PROPOSTA 
     , (SELECT NVL(MAX(PROPT.VLR_TARIF_PRS),0.00) AS PREMIO_PROPOSTA
            FROM APLBIL.BIL_RELAC_VISAO_PROPT PROPT
            INNER JOIN APLBIL.BIL_RELAC_TAXA_PROPOSTA TP ON (PROPT.SEQ_NUMER_PRS = TP.SEQ_NUMER_PRS)
            WHERE PROPT.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS  AND PROPT.SEQ_NUMER_AVB =A.SEQ_NUMER_AVB                    
      ) AS PREMIO_PROPOSTA
      , CLI.COD_DOCUM_PRI AS CNPJ
      , FAT.DAT_VENCI_FAT AS VENCTO_FATURA
      , CASE WHEN SUBSTR(FAT.NUM_MES_CPT, 5,2) = '01' THEN 'JANEIRO' 
 	     WHEN SUBSTR(FAT.NUM_MES_CPT, 5,2) = '02' THEN 'FEVEREIRO'	
 	     WHEN SUBSTR(FAT.NUM_MES_CPT, 5,2) = '03' THEN 'MAR�O'	
 	     WHEN SUBSTR(FAT.NUM_MES_CPT, 5,2) = '04' THEN 'ABRIL'	
 	     WHEN SUBSTR(FAT.NUM_MES_CPT, 5,2) = '05' THEN 'MAIO'	
 	     WHEN SUBSTR(FAT.NUM_MES_CPT, 5,2) = '06' THEN 'JUNHO'	
 	     WHEN SUBSTR(FAT.NUM_MES_CPT, 5,2) = '07' THEN 'JULHO'	
 	     WHEN SUBSTR(FAT.NUM_MES_CPT, 5,2) = '08' THEN 'AGOSTO'	
 	     WHEN SUBSTR(FAT.NUM_MES_CPT, 5,2) = '09' THEN 'SETEMBRO'	
 	     WHEN SUBSTR(FAT.NUM_MES_CPT, 5,2) = '10' THEN 'OUTUBRO'	
 	     WHEN SUBSTR(FAT.NUM_MES_CPT, 5,2) = '11' THEN 'NOVEMBRO'	
 	     WHEN SUBSTR(FAT.NUM_MES_CPT, 5,2) = '12' THEN 'DEZEMBRO' END
             ||'/'||SUBSTR(FAT.NUM_MES_CPT,1,4) ||' - '||PER.NOM_PERIO AS MES_FAT
       , R.SIG_RAMO
       ,(SELECT NVL(TF.VLR_CALCU,0) FROM APLBIL.BIL_VALOR_SOMA_TIPO_TARIFA TF  WHERE TF.SEQ_NUMER_FAT = FAT.SEQ_NUMER_FAT AND TF.NUM_TARIF = 70 FETCH FIRST 1 ROWS ONLY) QTDE_AVB
       ,(SELECT NVL(ST.VLR_CALCU,0) PREMIO FROM APLBIL.BIL_VALOR_SOMA_TIPO_TARIFA ST WHERE ST.NUM_TARIF = 77 AND ST.SEQ_NUMER_FAT = FAT.SEQ_NUMER_FAT FETCH FIRST 1 ROWS ONLY) AS PREMIO_AVERBACAO
 FROM APLBIL.BIL_FATURA FAT
INNER JOIN APLBIL.BIL_PROPOSTA P ON (P.SEQ_NUMER_PRS = FAT.SEQ_NUMER_PRS)
INNER JOIN APLBIL.BIL_PERIODO PER ON (P.NUM_PERIO = PER.NUM_PERIO)
INNER JOIN APLBIL.BIL_RELAC_AVERB_PROPT AP ON (AP.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS AND AP.SEQ_NUMER_FAT = FAT.SEQ_NUMER_FAT)
INNER JOIN APLBIL.BIL_AVERBACAO A ON (A.SEQ_NUMER_AVB = AP.SEQ_NUMER_AVB)
INNER JOIN APLBIL.BIL_AVERBACAO_INDICE AI ON (AI.NUM_AVERB_PAM = A.NUM_AVERB_PAM)
INNER JOIN PAMAIS.V_CRP_PESSOA CIA ON (P.CTL_PEJUR_CIA = CIA.CTL_PESSO AND CIA.TIP_PESSO = 1)
INNER JOIN PAMAIS.V_CRP_PESSOA CLI ON (P.CTL_PESSO_CLI = CLI.CTL_PESSO AND CLI.TIP_PESSO = 1) 
INNER JOIN APLBIL.BIL_LOCALIDADE LO ON (LO.SEQ_NUMER_LOC = A.SEQ_LOCAL_ORI) 
LEFT JOIN APLBIL.BIL_LOCALIDADE LOR ON  (LO.SEQ_LOCAL_PAI = LOR.SEQ_NUMER_LOC) 
INNER JOIN APLBIL.BIL_LOCALIDADE LD ON (LD.SEQ_NUMER_LOC = A.SEQ_LOCAL_DES) 
LEFT JOIN APLBIL.BIL_LOCALIDADE LDE ON (LD.SEQ_LOCAL_PAI = LDE.SEQ_NUMER_LOC) 
INNER JOIN PAMAIS.V_CRP_RAMO_SEGURO  R ON (P.NUM_RAMO_SEG = R.NUM_RAMO_SEG)    
WHERE FAT.NUM_MES_CPT = 202311
  AND FAT.SEQ_NUMER_FAT =7000312061 
  AND FAT.NUM_PERIO_FAT = nvl(null , FAT.NUM_PERIO_FAT)
  AND P.NUM_APOLI =  nvl(null, P.NUM_APOLI)
  AND P.NUM_RAMO_SEG =  NVL( 66, P.NUM_RAMO_SEG)
  AND AP.SEQ_NUMER_FAT IS NOT NULL
  AND AP.VLR_IS <> 0
ORDER BY ORIGEM,DHR_EMBAR,NUM_AVERB_PAM            
OPTIMIZE FOR 1 ROWS WITH UR


SELECT * FROM RAMO 
WHERE SIG_RAMO LIKE '%RCT%'



SELECT * FROM bilhet.TBIL_VIGENCIA_TAXA_CLIENTE tvtc 
WHERE NUM_SEQUE_TAR = 1503296

SELECT * FROM bilhet.V_BIL_TAXA_PROPOSTA vbtp 
WHERE seq_numer_prs = 501508


SELECT * FROM dbprod.TDOC_VINCULADO tv 