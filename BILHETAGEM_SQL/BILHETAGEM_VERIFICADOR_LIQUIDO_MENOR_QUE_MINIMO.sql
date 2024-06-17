SELECT F.SEQ_NUMER_FAT NRFATURA , 
       F.SEQ_NUMER_PRS PROPOSTA , 
       F.DAT_VENCI_FAT DTVENCIMENTO , 
       F.NUM_MES_CPT ANOMES , 
       F.SIT_FATUR CODSITUACAO , 
       F.NUM_FATUR_CIA AS ID_FATURA_CLIENTE , 
       S.DES_SITUA_FAT SITUACAO , 
       P.NOM_PESSO_CLI AS CLIENTE ,
       P.SIG_SIMBO_PRS AS SIMBOLO_MOEDA ,
        0 AS TOTAL , 
        ( SELECT NVL(SUM(STT.VLR_CALCU),0) 
            FROM BIL_VALOR_SOMA_TIPO_TARIFA STT 
              INNER JOIN BIL_TIPO_TARIFA_PROPOSTA tipoTarifaProposta 
                    ON tipoTarifaProposta.NUM_TARIF = STT.NUM_TARIF 
                    AND tipoTarifaProposta.NUM_TARIF = 70 
            WHERE STT.SEQ_NUMER_FAT = f.SEQ_NUMER_FAT  ) AS QTDE_VIAGENS , 
        P.SIG_RAMO as RAMO 
FROM BIL_FATURA f INNER JOIN BIL_SITUACAO_FATURA s on (f.sit_fatur = s.sit_fatur)    
      INNER JOIN v_bil_proposta p on (f.seq_numer_prs = p.seq_numer_prs)  
WHERE BILHET.FC_TARIFA_FATURA(F.SEQ_NUMER_FAT, 52 , 'C') > BILHET.FC_TARIFA_FATURA(F.SEQ_NUMER_FAT, 61 , 'C') 
AND F.SEQ_NUMER_FAT in (select seq_numer_fat from bilhet.tbil_valor_soma_tipo_tarifa
where num_tarif = 70)

select * from bilhet.tbil_tarif_percu_proposta
where num_tarif = 70

select * from bilhet.tbil_valor_soma_tipo_tarifa
where num_tarif = 70


select * from 