SELECT A.NUM_AVERB AS averbacaoId,
	(SELECT NOM_FANTS FROM CRP_PESSOA WHERE CTL_PESSO = A.CTL_PESSO) AS nomeSegurado,
    (SELECT NOM_PESSO FROM CRP_PESSOA WHERE CTL_PESSO = A.CTL_PESSO) AS razaoSocial,
    (SELECT COD_DOCUM_PRI FROM CRP_PESSOA WHERE CTL_PESSO = A.CTL_PESSO) AS CNPJ,
    (SELECT SIG_RAMO FROM CRP_RAMO_SEGURO WHERE NUM_RAMO_SEG = A.NUM_RAMO) AS ramo,
	(CASE
            WHEN (a.sit_averb in (0)) THEN 'azul'
            ELSE CASE
                     WHEN (a.sit_averb =12) THEN 'cinza'
                     ELSE CASE
                              WHEN (a.sit_averb = 4
                                    AND a.sit_trans in (1,
                                                        9)) THEN 'verde'
                              ELSE CASE
                                       WHEN (a.sit_averb = 10
                                             AND a.sit_trans in (1,
                                                                 9)) THEN 'verde2'
                                       ELSE CASE
                                                WHEN (a.sit_averb = 4
                                                      AND a.sit_trans in (0,
                                                                          3)) THEN 'laranja'
                                                ELSE CASE
                                                         WHEN (a.sit_averb = 9) THEN 'vermelho'
                                                         ELSE CASE
                                                                  WHEN (a.sit_averb = 3) THEN 'preto'
                                                                  ELSE CASE
                                                                           WHEN (a.sit_averb = 5) THEN 'amarelo'
                                                                           ELSE 'rosa'
                                                                       END
                                                              END
                                                     END
                                            END
                                   END
                          END
                 END
        END) AS status,
	(CASE
            WHEN (a.sit_averb in (0)) THEN 'Consistir'
            ELSE CASE
                     WHEN (a.sit_averb =12) THEN 'Consistindo'
                     ELSE CASE
                              WHEN (a.sit_averb = 4
                                    AND a.sit_trans in (1,
                                                        9)) THEN 'Processado'
                              ELSE CASE
                                       WHEN (a.sit_averb = 10
                                             AND a.sit_trans in (1,
                                                                 9)) THEN 'Desbloqueada'
                                       ELSE CASE
                                                WHEN (a.sit_averb = 4
                                                      AND a.sit_trans in (0,
                                                                          3)) THEN 'A Faturar'
                                                ELSE CASE
                                                         WHEN (a.sit_averb = 9) THEN 'Bloqueada'
                                                         ELSE CASE
                                                                  WHEN (a.sit_averb = 3) THEN 'Cancelado'
                                                                  ELSE CASE
                                                                           WHEN (a.sit_averb = 5) THEN 'Com Erro'
                                                                           ELSE 'N/A'
                                                                       END
                                                              END
                                                     END
                                            END
                                   END
                          END
                 END
        END) AS descStatus,
    A.SIT_AVERB AS statusNum,
    x.IDT_DIVIS_RCT AS negocios,
    A.NUM_PROPT AS proposta,
    x.NUM_APOLI AS apolice,
    A.DAT_EMBAR AS dataEmbarque,
    A.DHR_AVERB AS dataAverbacao,
    A.DHR_ENTRA AS dataEntrada,
    (SELECT DES_PRACA FROM PRACA WHERE NUM_PRACA = A.NUM_PRACA_EMI ) AS praca,
    Float(A.VLR_EMBAR) AS valor,
    A.COD_MANIF AS duv,
    (SELECT COD_SERIE_NF FROM AVERBACAO_COMPLEM_ATM WHERE CTL_AVERB = A.CTL_AVERB ) AS serie,
    S1.DES_SITUA_AVB AS situacaoAverbacao,
    (SELECT DES_MTSIT_AVB FROM MTSIT_AVERBACAO WHERE TIP_MTSIT_AVB = A.TIP_MTSIT_AVB) AS motivoCancelamento,
    A.COD_USER AS usuario,
    A.DHR_ALTER AS dataAlteracao,
    A.CTL_AVERB AS ctlAverbacao,
    (SELECT DAT_EMISS_DUV FROM AVERBACAO_COMPLEM WHERE CTL_AVERB = A.CTL_AVERB) AS dataEmissaoCte,
	AIA.COD_AVERB_OFC AS averbacaoATM,
    AIA.COD_DANFE AS danfe,
    AIA.COD_CNPJ_TOM AS cnpjTomador,
    AIA.COD_CNPJ_EMI AS cnpjEmissor
FROM V_AVERBACAO_VEICULO_NEW A
	,SEG_PROPOSTA_SEGURO x
	,SITUACAO_AVERBACAO S1
	LEFT JOIN RELAC_AVERBACAO_ATM RAA ON RAA.CTL_AVERB = A.CTL_AVERB
	LEFT OUTER JOIN averbacao_impor_atm AIA ON AIA.ctl_ATM= RAA.ctl_ATM
WHERE x.NUM_PROPT = A.NUM_PROPT
	AND x.NUM_VERSA_PRS = 1
	AND X.TIP_PROPT = 1
	AND S1.SIT_AVERB = A.SIT_AVERB
	AND A.CTL_AVERB IN (785667521, 783729601, 783729101, 783729038)
--	AND A.CTL_PESSO = 26494
  	AND A.DAT_EMBAR BETWEEN '2023-11-01' AND '2023-11-08'
OPTIMIZE FOR 1 ROWS WITH UR  	


SELECT * FROM SITUACAO_AVERBACAO 

SELECT * FROM PAMAIS.TCRP_PESSOA tp 
WHERE NOM_FANTS LIKE '%CH ROB%'

SELECT * FROM SITUA_IMPOR_ATM 
SELECT * FROM TSITUA_IMPOR_AVERBGO

SELECT * FROM RELAC_SITUA_AVERB_ATM 
SELECT * FROM RELAC_AVERBACAO_ATM 
SELECT * FROM AVERBACAO_IMPOR_ATM
SELECT * FROM V_AVERBACAO_VEICULO_NEW 
WHERE num_averb IN (785667521, 783729601, 783729101, 783729038)


/* AVERBAÇÕES A PARTIR DE MEIA NOITE*/
SELECT rsaa.SIT_IMPOR_ATM, sia.DES_IMPOR_ATM, COUNT(aia.CTL_ATM) AS almost  
FROM AVERBACAO_IMPOR_ATM aia
INNER JOIN RELAC_SITUA_AVERB_ATM rsaa ON rsaa.CTL_ATM = aia.CTL_ATM 
INNER JOIN SITUA_IMPOR_ATM sia  ON rsaa.SIT_IMPOR_ATM = sia.SIT_IMPOR_ATM
WHERE aia.dhr_alter >= (DATE (current timestamp) || ' 00:00:00')--(CURRENT timestamp - 24 hours)
AND aia.DHR_ALTER < CURRENT TIMEstamp
GROUP BY rsaa.SIT_IMPOR_ATM, sia.DES_IMPOR_ATM
OPTIMIZE FOR 1 ROWS WITH UR

/* AVERBAÇÕES D -1*/
SELECT rsaa.SIT_IMPOR_ATM, sia.DES_IMPOR_ATM, COUNT(aia.CTL_ATM) AS almost  
FROM AVERBACAO_IMPOR_ATM aia
INNER JOIN RELAC_SITUA_AVERB_ATM rsaa ON rsaa.CTL_ATM = aia.CTL_ATM 
INNER JOIN SITUA_IMPOR_ATM sia  ON rsaa.SIT_IMPOR_ATM = sia.SIT_IMPOR_ATM
WHERE aia.dhr_alter >= (DATE (current timestamp) || ' 00:00:00')--(CURRENT timestamp - 24 hours)
AND aia.DHR_ALTER < (DATE (current timestamp) )--|| ' 23:59:59')
GROUP BY rsaa.SIT_IMPOR_ATM, sia.DES_IMPOR_ATM
OPTIMIZE FOR 1 ROWS WITH UR


SELECT
	rsaa.SIT_IMPOR_ATM AS sitImporAtm,
	sia.DES_IMPOR_ATM AS desImporAtm,
	COUNT(aia.CTL_ATM) AS almost
FROM
	AVERBACAO_IMPOR_ATM aia
INNER JOIN RELAC_SITUA_AVERB_ATM rsaa ON
	rsaa.CTL_ATM = aia.CTL_ATM
INNER JOIN SITUA_IMPOR_ATM sia ON
	rsaa.SIT_IMPOR_ATM = sia.SIT_IMPOR_ATM
WHERE
	aia.dhr_alter >= (DATE (CURRENT timestamp) || ' 00:00:00')
	AND aia.DHR_ALTER < CURRENT timestamp
GROUP BY
	rsaa.SIT_IMPOR_ATM,
	sia.DES_IMPOR_ATM OPTIMIZE FOR 1 ROWS WITH UR


SELECT YEAR (current timestamp) FROM sysibm.sysdummy1;
SELECT MONTH (current timestamp) FROM sysibm.sysdummy1;
SELECT DATE (current timestamp)  || ' 00:00:00', now FROM sysibm.sysdummy1;
SELECT TIME (current timestamp) FROM sysibm.sysdummy1;
SELECT DAY (current timestamp) FROM sysibm.sysdummy1;
SELECT HOUR (current timestamp) FROM sysibm.sysdummy1;
SELECT MINUTE (current timestamp) FROM sysibm.sysdummy1;
SELECT SECOND (current timestamp) FROM sysibm.sysdummy1;
SELECT MICROSECOND (current timestamp) FROM sysibm.sysdummy1;



SELECT aia.COD_CNPJ_SEG,rsaa.SIT_IMPOR_ATM, sia.DES_IMPOR_ATM  
FROM AVERBACAO_IMPOR_ATM aia
INNER JOIN RELAC_SITUA_AVERB_ATM rsaa ON rsaa.CTL_ATM = aia.CTL_ATM 
INNER JOIN SITUA_IMPOR_ATM sia  ON rsaa.SIT_IMPOR_ATM = sia.SIT_IMPOR_ATM
WHERE rsaa.dhr_alter >= (CURRENT timestamp - 24 hours)
AND rsaa.DHR_ALTER < CURRENT TIMEstamp
AND RSAA.SIT_IMPOR_ATM  <> 0
GROUP BY aia.COD_CNPJ_SEG, rsaa.SIT_IMPOR_ATM, sia.DES_IMPOR_ATM
ORDER BY aia.COD_CNPJ_SEG 
GROUP BY rsaa.SIT_IMPOR_ATM, sia.DES_IMPOR_ATM





>= '2023-01-23 00:00:00'
AND DHR_ALTER < '2023-01-23 11:00:00'
AND COD_CNPJ_SEG IS NULL 



SELECT count(1) FROM RELAC_AVERBACAO_ATM 
WHERE dhr_alter >= '2023-01-23 00:00:00'
AND DHR_ALTER < '2023-01-23 11:00:00'
AND CTL_ATM NOT IN (SELECT CTL_ATM FROM AVERBACAO_IMPOR_ATM)



SELECT * FROM bilhet.TBIL_FATURA tf 
WHERE SEQ_NUMER_FAT IN (7000279934,7000272650)

SIT_FATUR =3
ORDER BY DHR_ALTER  DESC 

AND NUM_MES_CPT = 202305 
and dhr_alter >= '2023-06-01 00:00:00'
AND DHR_ALTER < '2023-06-26 11:00:00'

SELECT * FROM bilhet.TBIL_PROPOSTA tp 
WHERE SEQ_NUMER_PRS = 505778
SELECT * FROM bilhet.TBIL_SITUACAO_ENVIO_FATURA tsef 


7000291980

SELECT * FROM bilhet.TBIL_SITUACAO_FATURA tsf 

SELECT * FROM bilhet.TBIL_MOTIVO_SITUACAO tms 

SELECT *  FROM bilhet.TBIL_CONTROLE_ENVIO_COBRANCA tcec 
WHERE IDT_ENVIO_CBR = 'I'
ORDER BY SEQ_NUMER_FAT DESC 


SELECT * FROM BILHET.TBIL_ACERTO_PREMIO tap 
SELECT * FROM bilhet.TBIL_VIGENCIA_TAXA_CLIENTE tvt
SELECT * FROM bilhet.TBIL_TIPO_TARIFA_PROPOSTA tttp
SELECT * FROM BILHET.tbil_valor_soma_tipo_tarifa

SELECT * FROM BILHET.TBIL_RELAC_TAXA_PROPOSTA
WHERE SEQ_NUMER_PRS = 502132

SELECT * FROM bilhet.TBIL_VIGENCIA_TAXA_CLIENTE tvt
WHERE NUM_SEQUE_TAR IN (SELECT NUM_SEQUE_TAR  FROM BILHET.TBIL_RELAC_TAXA_PROPOSTA
WHERE SEQ_NUMER_PRS = 502132 )


COMMIT

SELECT * FROM BILHET.V_BIL_TAXA_PROPOSTA vbtp 
WHERE SEQ_NUMER_PRS = 502132



/*INCLUSÃO DA TAXA LIMPEZA DE PISTA*/
INSERT INTO bilhet.TBIL_TIPO_TARIFA_PROPOSTA values(90,'071.002.PCE_COBER_LIMP_PST','Taxa Limpeza Pista','P','Prémio Limpeza Pista',0.01,CURRENT timestamp)

/* INCLUSÃO DA NOVA TAXA PARA O SEGURADO*/
INSERT INTO BILHET.TBIL_RELAC_TAXA_PROPOSTA (NUM_TARIF,SEQ_NUMER_PRS,DHR_ALTER) VALUES(90,502132,CURRENT timestamp)

INSERT INTO bilhet.TBIL_VIGENCIA_TAXA_CLIENTE (NUM_SEQUE_TAR, DAT_INICI_VIG, DAT_FIM_VIG, VLR_TARIF, DHR_ALTER,COD_USER)
VALUES(1536722,'2022-04-01','2023-06-30',0.01,CURRENT TIMESTAMP,'RONALDO')

COMMIT


SELECT * FROM bilhet.TBIL_VIGENCIA_TAXA_CLIENTE tvt


select *
from syscat.sequences
WHERE seqschema IN ('BILHET','APLBIL')

SELECT * FROM BILHET.V_BIL_MOEDA




--INSERT INTO bilhet.TBIL_TIPO_TARIFA_PROPOSTA values(90,'071.002.PCE_COBER_LIMP_PST','Taxa Limpeza Pista','P','Prémio Limpeza Pista',0.01,CURRENT timestamp)
COMMIT

SELECT * FROM bilhet.TBIL_PROPOSTA tp 
WHERE NUM_APOLI = 3836901049254
WHERE NUM_PROPT = 23003415

SELECT * FROM bilhet.TBIL_FATURA tf 
WHERE SEQ_NUMER_FAT = 67999978702

SELECT
   vlr_calcu
FROM    bilhet.tbil_valor_soma_tipo_tarifa
WHERE   1=1
AND seq_numer_fat = 67999978721
   AND num_tarif = 90
   AND idt_premi = 'C'
   
   
   
   
   SELECT
    T1.SEQ_NUMER_PRS ,
    T1.NUM_SEQUE_TAR ,
    T1.NUM_TARIF ,
    T2.NOM_TARIF,
    T2.NOM_APELI_TAR,
    T3.NUM_SEQUE_VIG ,
    T3.DAT_INICI_VIG ,
    T3.DAT_FIM_VIG ,
    T3.VLR_TARIF
FROM
    BILHET.TBIL_RELAC_TAXA_PROPOSTA T1
INNER JOIN BILHET.TBIL_VIGENCIA_TAXA_CLIENTE T3 ON
    ( T3.NUM_SEQUE_TAR = T1.NUM_SEQUE_TAR )
INNER JOIN BILHET.TBIL_TIPO_TARIFA_PROPOSTA T2 ON
    ( T2.NUM_TARIF = T1.NUM_TARIF )
 WHERE t1.NUM_TARIF = 90
 
 
 
 --APOLICE
 3836901049554
 3836901049254
 
 SELECT * FROM bilhet.log_bilhet
 WHERE SEQ_NUMER_FAT = 67999978697
 
 SELECT * FROM BILHET.TBIL_RELAC_AVERB_PROPT trap 
 SELECT * FROM BILHET.TBIL_AVERBACAO ta 
 SELECT bilhet.fc_tarifa_fatura(67999978697, 90, 'C') FROM DUAL
 
 
 SELECT * FROM BILHET.TBIL_FATURA tf 
 ORDER BY DHR_ALTER DESC 
 
 SELECT
   *
FROM    bilhet.tbil_valor_soma_tipo_tarifa
WHERE    seq_numer_fat = 67999978706
   AND num_tarif = 90
   AND idt_premi = 'C'
   
   

SELECT *  FROM BILHET.V_BIL_LOCALIDADE