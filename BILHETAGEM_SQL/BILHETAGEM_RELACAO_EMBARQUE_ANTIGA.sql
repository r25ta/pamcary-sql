select num_averb_pam
     , NUM_AVERB_CLI
     , NUM_SEQUE_AVB
     , manifesto
     , PLACA
     , dhr_embar
     , CTL_PEJUR_CIA
     , NOM_PEJUR_CIA
     , num_apoli
     , NOM_FANTS_CLI
     , vlr_embar_tot TOTAL_EMBARCADO
     , Status_Pamtax
     , ORIGEM
     , DESTINO
     , NVL(sum(PCE_TARIF_PEC),0) TARIFA_PADRAO
     , sum(VLR_TARIF_PEC) PREMIO_TARIFA
     , num_mes_cpt
     , NVL(sum(VLR_TARIF_PRS),0) PREMIO_PROPOSTA
     , MAX(VLR_TARIF) TARIFA_PROPOSTA
     , max(COD_DOCUM_CLI) cnpj
     , MAX(VENCTO_FATURA) VENCTO_FATURA
    ,  MAX(MES_FAT ) MES_FAT
    , MAX(SIG_RAMO) SIG_RAMO
    , max(QTDE_AVB) QTDE_AVB
from (
select distinct ai.num_averb_pam
     , avb.NUM_AVERB_CLI
     , avb.NUM_SEQUE_AVB
     , avb.cod_docum_emb manifesto
     , (SELECT COD_IDENT_VEI
          FROM aplbil.v_averbacao_veiculo V
        WHERE V.CTL_AVERB = ai.num_averb_pam
         FETCH FIRST 1 ROWS ONLY) PLACA
     , trunc(avb.dhr_embar) dhr_embar
     , ppt.CTL_PEJUR_CIA
     , ppt.NOM_PEJUR_CIA
     , ppt.num_apoli
     , ppt.NOM_FANTS_CLI
     , rel.vlr_is vlr_embar_tot
     , decode(ai.vlr_pamtx, 0, '', 'PX') Status_Pamtax
     , CASE WHEN a1.tip_local IN (1, 2) THEN a1.cod_ident_pad
           ELSE a11.cod_ident_pad
       END ORIGEM
     , CASE WHEN a2.tip_local IN (1, 2) THEN a2.cod_ident_pad
         ELSE a22.cod_ident_pad
       END DESTINO
     , case when TTP.NUM_TARIF = 37 then
           (SELECT NVL(max(v.VLR_TARIF),0.06)
                        FROM BILHET.TBIL_RELAC_TAXA_PROPOSTA RP
                       INNER JOIN BILHET.TBIL_VIGENCIA_TAXA_CLIENTE V ON (RP.NUM_SEQUE_TAR = V.NUM_SEQUE_TAR)
               WHERE rp.SEQ_NUMER_PRS = ppt.SEQ_NUMER_PRS
                 and rp.NUM_TARIF = 37)
            when TTP.NUM_TARIF = 33 then
           (SELECT NVL(max(v.VLR_TARIF),0.00)
                        FROM BILHET.TBIL_RELAC_TAXA_PROPOSTA RP
                        INNER JOIN BILHET.TBIL_VIGENCIA_TAXA_CLIENTE V ON (RP.NUM_SEQUE_TAR = V.NUM_SEQUE_TAR)
                WHERE rp.SEQ_NUMER_PRS = ppt.SEQ_NUMER_PRS
                 and rp.NUM_TARIF = 33)
        when TTP.NUM_TARIF = 34 then
           (SELECT NVL(max(v.VLR_TARIF),0.00)
                        FROM BILHET.TBIL_RELAC_TAXA_PROPOSTA RP
                        INNER JOIN BILHET.TBIL_VIGENCIA_TAXA_CLIENTE V ON (RP.NUM_SEQUE_TAR = V.NUM_SEQUE_TAR)
                WHERE rp.SEQ_NUMER_PRS = ppt.SEQ_NUMER_PRS
                 and rp.NUM_TARIF = 34)
       ELSE VIG.PCE_TARIF_PEC
       end PCE_TARIF_PEC
     , case when TTP.NUM_TARIF in (53,32,36,37,66) then 0
         ELSE NVL(min(PROPT.VLR_TARIF_PRS),0)
       end VLR_TARIF_PRS
     , case when TTP.NUM_TARIF = 37 then
                (select NVL(vlr_tarif_prs,0)
                   from bilhet.TBIL_RELAC_VISAO_PROPT
                   where seq_numer_avb = avb.SEQ_NUMER_AVB
                   and num_seque_vig in (
                        SELECT t3.NUM_SEQUE_VIG
                        FROM BILHET.TBIL_RELAC_TAXA_PROPOSTA T1
                        INNER JOIN BILHET.TBIL_VIGENCIA_TAXA_CLIENTE T3 ON (T3.NUM_SEQUE_TAR = T1.NUM_SEQUE_TAR)
                        INNER JOIN BILHET.TBIL_TIPO_TARIFA_PROPOSTA T2  ON (T2.NUM_TARIF = T1.NUM_TARIF )
                        where t1.SEQ_NUMER_PRS = ppt.SEQ_NUMER_PRS
                         and t1.NUM_TARIF = 37 )
                   and seq_numer_prs = ppt.SEQ_NUMER_PRS)
            when TTP.NUM_TARIF = 33 then
                (select NVL(vlr_tarif_prs,0)
                   from bilhet.TBIL_RELAC_VISAO_PROPT
                   where seq_numer_avb = avb.SEQ_NUMER_AVB
                   and num_seque_vig in (
                        SELECT t3.NUM_SEQUE_VIG
                        FROM BILHET.TBIL_RELAC_TAXA_PROPOSTA T1
                        INNER JOIN BILHET.TBIL_VIGENCIA_TAXA_CLIENTE T3 ON (T3.NUM_SEQUE_TAR = T1.NUM_SEQUE_TAR)
                        INNER JOIN BILHET.TBIL_TIPO_TARIFA_PROPOSTA T2  ON (T2.NUM_TARIF = T1.NUM_TARIF )
                        where t1.SEQ_NUMER_PRS = ppt.SEQ_NUMER_PRS
                         and t1.NUM_TARIF = 33 )
                   and seq_numer_prs = ppt.SEQ_NUMER_PRS)
            when TTP.NUM_TARIF = 34 then
                (select NVL(vlr_tarif_prs,0)
                   from bilhet.TBIL_RELAC_VISAO_PROPT
                   where seq_numer_avb = avb.SEQ_NUMER_AVB
                   and num_seque_vig in (
                        SELECT t3.NUM_SEQUE_VIG
                        FROM BILHET.TBIL_RELAC_TAXA_PROPOSTA T1
                      INNER JOIN BILHET.TBIL_VIGENCIA_TAXA_CLIENTE T3 ON (T3.NUM_SEQUE_TAR = T1.NUM_SEQUE_TAR)
                      INNER JOIN BILHET.TBIL_TIPO_TARIFA_PROPOSTA T2  ON (T2.NUM_TARIF = T1.NUM_TARIF )
                        where t1.SEQ_NUMER_PRS = ppt.SEQ_NUMER_PRS
                         and t1.NUM_TARIF = 34
                   )
                   and seq_numer_prs = ppt.SEQ_NUMER_PRS)
         ELSE sum(PD.VLR_TARIF_PEC)
       end VLR_TARIF_PEC
     , fat.num_mes_cpt
      , case when t1.PCE_TARIF_PEC is null then NVL(MAX(VT.VLR_TARIF),0)
         else t1.PCE_TARIF_PEC
     end VLR_TARIF
     , ttp.num_tarif
     , max(ppt.COD_DOCUM_CLI) COD_DOCUM_CLI
     , MAX(FAT.DAT_VENCI_FAT) VENCTO_FATURA
     , MAX(CASE WHEN SUBSTR(Fat.NUM_MES_CPT, 5,2) = '01' THEN 'JANEIRO'
             WHEN SUBSTR(Fat.NUM_MES_CPT, 5,2) = '02' THEN 'FEVEREIRO'
             WHEN SUBSTR(Fat.NUM_MES_CPT, 5,2) = '03' THEN 'MARÇO'
             WHEN SUBSTR(Fat.NUM_MES_CPT, 5,2) = '04' THEN 'ABRIL'
             WHEN SUBSTR(Fat.NUM_MES_CPT, 5,2) = '05' THEN 'MAIO'
             WHEN SUBSTR(Fat.NUM_MES_CPT, 5,2) = '06' THEN 'JUNHO'
             WHEN SUBSTR(Fat.NUM_MES_CPT, 5,2) = '07' THEN 'JULHO'
             WHEN SUBSTR(Fat.NUM_MES_CPT, 5,2) = '08' THEN 'AGOSTO'
             WHEN SUBSTR(Fat.NUM_MES_CPT, 5,2) = '09' THEN 'SETEMBRO'
             WHEN SUBSTR(Fat.NUM_MES_CPT, 5,2) = '10' THEN 'OUTUBRO'
             WHEN SUBSTR(Fat.NUM_MES_CPT, 5,2) = '11' THEN 'NOVEMBRO'
             WHEN SUBSTR(Fat.NUM_MES_CPT, 5,2) = '12' THEN 'DEZEMBRO' END ||'/'||SUBSTR(Fat.NUM_MES_CPT,1,4)||' - '||ppt.NOM_PERIO_PRS) MES_FAT
     , MAX(ppt.SIG_RAMO) SIG_RAMO
     , (SELECT NVL(tf.vlr_calcu,0)
           from bilhet.TBIL_VALOR_SOMA_TIPO_TARIFA tf
           WHERE tf.seq_numer_fat = MAX(REL.SEQ_NUMER_FAT)
             and tf.num_tarif = 70
        ) QTDE_AVB
     , TTP.NUM_TARIF
from bilhet.tbil_relac_averb_propt rel
  inner join bilhet.tbil_fatura fat                     on (fat.SEQ_NUMER_PRS = rel.SEQ_NUMER_PRS and fat.SEQ_NUMER_FAT = rel.SEQ_NUMER_FAT)
  inner join bilhet.tbil_averbacao avb                  on (rel.seq_numer_avb = avb.seq_numer_avb)
  INNER JOIN aplbil.bil_localidade A1                   ON A1.SEQ_NUMER_LOC = AVB.SEQ_LOCAL_ORI
  LEFT JOIN aplbil.bil_localidade A11                   ON A1.SEQ_LOCAL_PAI = A11.SEQ_NUMER_LOC
  INNER JOIN aplbil.bil_localidade A2                   ON A2.SEQ_NUMER_LOC = AVB.SEQ_LOCAL_DES
  LEFT JOIN aplbil.bil_localidade A22                   ON A2.SEQ_LOCAL_PAI = A22.SEQ_NUMER_LOC
  inner join bilhet.V_bil_proposta ppt                  on (rel.seq_numer_prs = ppt.seq_numer_prs)
  LEFT JOIN BILHET.TBIL_RELAC_TAXA_PROPOSTA RP          ON (PPT.SEQ_NUMER_PRS = RP.SEQ_NUMER_PRS AND RP.NUM_TARIF = 16)
  LEFT JOIN BILHET.TBIL_VIGENCIA_TAXA_CLIENTE VT        ON (RP.NUM_SEQUE_TAR = VT.NUM_SEQUE_TAR)
  left  join bilhet.tbil_averbacao_indice ai            on (avb.num_averb_pam = ai.num_averb_pam)
  left  join bilhet.tbil_relac_visao_percu_padra pd     on (pd.seq_numer_prs = rel.seq_numer_prs and pd.seq_numer_avb = rel.seq_numer_avb)
  LEFT JOIN aplbil.BIL_VIGEN_TARIFA_PERCURSO VIG        ON VIG.CTL_VIGEN_PEC = PD.CTL_VIGEN_PEC
  LEFT JOIN aplbil.BIL_RELAC_VISAO_PROPT PROPT          ON (REL.SEQ_NUMER_AVB = PROPT.SEQ_NUMER_AVB AND REL.SEQ_NUMER_PRS+0 = PROPT.SEQ_NUMER_PRS AND PROPT.NUM_SEQUE_VIG = VT.NUM_SEQUE_VIG)
 LEFT JOIN aplbil.BIL_RELAC_TARIFA_PERCURSO REL_PEC    ON REL_PEC.NUM_TARIF_PEC = VIG.NUM_TARIF_PEC
  LEFT JOIN aplbil.BIL_TIPO_TARIFA_PROPOSTA TTP         ON TTP.NUM_TARIF = REL_PEC.NUM_TARIF
  LEFT JOIN BILHET.v_bil_relac_visao_percu_propt  t1    on (t1.seq_numer_prs = rel.seq_numer_prs+0  and t1.seq_numer_avb = rel.seq_numer_avb)
where  fat.NUM_MES_CPT  =  202110
  and ppt.num_apoli     = NVL( 3836006621454, ppt.num_apoli)
  and ppt.ctl_pejur_cia = NVL( 17341,ppt.CTL_PEJUR_CIA)
  and ppt.NUM_RAMO_SEG  = NVL( 66,ppt.NUM_RAMO_SEG)
  and fat.NUM_PERIO_FAT = NVL( 3,fat.NUM_PERIO_FAT)
  and rel.seq_numer_fat = 7000223155
group by a1.tip_local, avb.NUM_AVERB_CLI, fat.num_mes_cpt, a2.tip_local, a1.cod_ident_pad, a2.cod_ident_pad, a1.NOM_LOCAL,
a2.NOM_LOCAL, a1.COD_IDENT_PAD, a2.COD_IDENT_PAD, a11.COD_IDENT_PAD, a22.COD_IDENT_PAD, ai.VLR_PAMTX, ppt.NOM_FANTS_CLI,
ppt.NUM_APOLI, ppt.NOM_PEJUR_CIA, ppt.CTL_PEJUR_CIA, avb.DHR_EMBAR, avb.COD_DOCUM_EMB, ai.NUM_AVERB_PAM,
VIG.PCE_TARIF_PEC, ttp.NUM_TARIF, rel.vlr_is, ppt.SEQ_NUMER_PRS, avb.NUM_AVERB_CLI, avb.NUM_SEQUE_AVB, TTP.NUM_TARIF, avb.SEQ_NUMER_AVB, t1.PCE_TARIF_PEC
)
where vlr_embar_tot  <> 0
group by NUM_AVERB_CLI,num_averb_pam, manifesto, PLACA, dhr_embar, CTL_PEJUR_CIA,
         NOM_PEJUR_CIA, num_apoli, NOM_FANTS_CLI, Status_Pamtax, num_mes_cpt,
         DESTINO, ORIGEM, vlr_embar_tot, NUM_SEQUE_AVB
order by 13,6 asc
OPTIMIZE FOR 1 ROWS WITH UR;