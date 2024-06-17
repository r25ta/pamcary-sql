SELECT A.NUM_AVERB_PAM, 
      A.NUM_AVERB_CLI,
      CLIENTE.COD_DOCUM_PRI,
                   CLIENTE.NOM_PESSO,
     SEGURADO.NOM_PESSO,
     P.NUM_APOLI,
     R.SIG_RAMO,
     AP.VLR_IS,
     A.VLR_EMBAR,
     COUNT(1) TOTAL
FROM BILHET.TBIL_AVERBACAO A
                ,BILHET.TBIL_PROPOSTA P
                ,BILHET.TBIL_RELAC_AVERB_PROPT AP
                ,PAMAIS.TCRP_PESSOA CLIENTE
   ,PAMAIS.TCRP_PESSOA SEGURADO
   ,PAMAIS.TCRP_RAMO_SEGURO R
WHERE 1=1
AND P.SEQ_NUMER_PRS = AP.SEQ_NUMER_PRS
AND A.SEQ_NUMER_AVB = AP.SEQ_NUMER_AVB
AND CLIENTE.CTL_PESSO = P.CTL_PESSO_CLI
AND SEGURADO.CTL_PESSO = P.CTL_PEJUR_CIA
AND R.NUM_RAMO_SEG = P.NUM_RAMO_SEG
AND AP.VLR_IS = 60000
AND A.VLR_EMBAR = 60000
AND A.DHR_ALTER BETWEEN '2021-03-01 00:00:00' AND '2021-03-31 24:00:00'
AND  P.NUM_APOLI > 0
--AND A.NUM_AVERB_PAM IN (356507844,361350721,361726005,361726006,361726007,361838564)
GROUP BY A.NUM_AVERB_PAM, 
      A.NUM_AVERB_CLI,
      CLIENTE.COD_DOCUM_PRI,
                   CLIENTE.NOM_PESSO,
     SEGURADO.NOM_PESSO,
     P.NUM_APOLI,
     R.SIG_RAMO,
     AP.VLR_IS,
     A.VLR_EMBAR
order by AP.VLR_IS


