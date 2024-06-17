/*AVERBAÇÃO POR APOLICE RAMO 1*/
select averbacao0_.SEQ_NUMER_AVB as SEQ_NUME1_4_0_, 
proposta1_.SEQ_NUMER_PRS as SEQ_NUME1_3_1_, 
fatura5_.SEQ_NUMER_FAT as SEQ_NUME1_2_2_, 
vencimento6_.SEQ_NUMER_PRS as SEQ_NUME1_13_3_, 
averbacaoi2_.NUM_AVERB_PAM as NUM_AVER1_1_4_, 
localidade3_.SEQ_NUMER_LOC as SEQ_NUME1_16_5_, 
localidade4_.SEQ_NUMER_LOC as SEQ_NUME1_16_6_, 
averbacao0_.NUM_ETAPA_AVB as NUM_ETAP2_4_0_, 
averbacao0_.SEQ_NUMER_PRS as SEQ_NUME4_4_0_, 
averbacao0_.VLR_IS as VLR_IS3_4_0_, 
averbacao0_1_.DHR_EMBAR as DHR_EMBA1_0_0_, 
averbacao0_1_.SEQ_LOCAL_DES as SEQ_LOC10_0_0_, 
averbacao0_1_.STA_AVARI as STA_AVAR2_0_0_, 
averbacao0_1_.IDT_TARIF as IDT_TARI3_0_0_, 
averbacao0_1_.STA_FLUVI as STA_FLUV4_0_0_, 
averbacao0_1_.NUM_AVERB_PAM as NUM_AVE11_0_0_, 
averbacao0_1_.SEQ_LOCAL_INT as SEQ_LOC12_0_0_, 
averbacao0_1_.SEQ_LOCAL_ORI as SEQ_LOC13_0_0_, 
averbacao0_1_.STA_PERNA_DES as STA_PERN5_0_0_, 
averbacao0_1_.STA_PERNA_ORI as STA_PERN6_0_0_, 
averbacao0_1_.IDT_CARGA_DSC as IDT_CARG7_0_0_, 
averbacao0_1_.TIP_ISENC_SEG as TIP_ISEN8_0_0_, 
averbacao0_1_.IDT_VEICU as IDT_VEIC9_0_0_, 
proposta1_.CTL_PEJUR_CIA as CTL_PEJU2_3_1_, 
proposta1_.NUM_COBER_BAS as NUM_COBE3_3_1_, 
proposta1_.CTL_PESSO_CLI as CTL_PESS4_3_1_, 
proposta1_.DAT_FIM_VIG as DAT_FIM_5_3_1_, 
proposta1_.NUM_APOLI as NUM_APOL6_3_1_, proposta1_.NUM_PERIO 
as NUM_PERI7_3_1_, proposta1_.NUM_RAMO_SEG as 
NUM_RAMO8_3_1_, proposta1_.NUM_ETAPA_PRS as 
NUM_ETAP9_3_1_, proposta1_.TIP_AVERB as TIP_AVE10_3_1_, 
proposta1_.TIP_NEGOC as TIP_NEG11_3_1_, 
fatura5_.DHR_FATUR as DHR_FATU2_2_2_, 
fatura5_.DAT_VENCI_FAT as DAT_VENC3_2_2_, 
fatura5_.NUM_MES_CPT as NUM_MES_4_2_2_, 
fatura5_.SIT_FATUR as SIT_FATU5_2_2_, 
fatura5_.SEQ_NUMER_PRS as SEQ_NUME6_2_2_, 
fatura5_.SEQ_NUMER_PRS as SEQ_NUME6_3_0__, 
fatura5_.SEQ_NUMER_FAT as SEQ_NUME1_2_0__, 
vencimento6_.NUM_DIA_VEC as NUM_DIA_2_13_3_, 
vencimento6_.NUM_PERIO_FAT as NUM_PERI3_13_3_, 
averbacaoi2_.SIT_TRANS as SIT_TRAN2_1_4_, 
averbacaoi2_.VLR_EMBAR_TOT as VLR_EMBA3_1_4_, 
averbacaoi2_.VLR_PAMTX as VLR_PAMT4_1_4_, 
localidade3_.COD_IDENT_PAD as COD_IDEN2_16_5_, 
localidade3_.SEQ_LOCAL_PAI as SEQ_LOCA6_16_5_, 
localidade3_.STA_NINFO as STA_NINF3_16_5_, 
localidade3_.STA_URSUB as STA_URSU4_16_5_, 
localidade3_.TIP_LOCAL as TIP_LOCA5_16_5_, 
localidade4_.COD_IDENT_PAD as COD_IDEN2_16_6_, 
localidade4_.SEQ_LOCAL_PAI as SEQ_LOCA6_16_6_, 
localidade4_.STA_NINFO as STA_NINF3_16_6_, 
localidade4_.STA_URSUB as STA_URSU4_16_6_, 
localidade4_.TIP_LOCAL as TIP_LOCA5_16_6_ 
from 
  BILHET.TBIL_RELAC_AVERB_PROPT averbacao0_ 
  left outer join BILHET.TBIL_AVERBACAO averbacao0_1_ 
  on averbacao0_.SEQ_NUMER_AVB=averbacao0_1_.SEQ_NUMER_AVB 
  inner join BILHET.TBIL_PROPOSTA proposta1_ 
  on averbacao0_.SEQ_NUMER_PRS=proposta1_.SEQ_NUMER_PRS 
  left outer join BILHET.TBIL_FATURA fatura5_ on 
  proposta1_.SEQ_NUMER_PRS=fatura5_.SEQ_NUMER_PRS 
  left outer join BILHET.TBIL_VENCIMENTO_FATURA_PROPT 
  vencimento6_ 
  on fatura5_.SEQ_NUMER_PRS=vencimento6_.SEQ_NUMER_PRS 
  inner join BILHET.TBIL_AVERBACAO_INDICE averbacaoi2_ 
  on averbacao0_1_.NUM_AVERB_PAM=averbacaoi2_.NUM_AVERB_PAM 
  left outer join BILHET.V_BIL_LOCALIDADE localidade3_ 
  on averbacao0_1_.SEQ_LOCAL_ORI=localidade3_.SEQ_NUMER_LOC 
  left outer join BILHET.V_BIL_LOCALIDADE localidade4_ 
  on averbacao0_1_.SEQ_LOCAL_DES=localidade4_.SEQ_NUMER_LOC 
where averbacao0_1_.DHR_EMBAR <= '2020-04-01'
  and proposta1_.NUM_APOLI     =  5400020382 
  and averbacao0_.NUM_ETAPA_AVB= 4 -- 1 NÃO PROCESSADA e 4 FATURADAS
  and proposta1_.NUM_APOLI     > 0 
  and proposta1_.NUM_PERIO     = 3 -- 1 SEMANAL, 2 QUINZENAL, 3 MENSAL, 4 DIARIO e 5 MENSAL
  and proposta1_.NUM_RAMO_SEG  = 1;
  
  
  SELECT * FROM BILHET.TBIL_PROPOSTA
  WHERE NUM_APOLI = 5500009033
  
  SELECT * FROM BILHET.TBIL_RELAC_AVERB_PROPT
  WHERE SEQ_NUMER_PRS = 496582
  
  SELECT * FROM BILHET.TBIL_AVERBACAO
  WHERE SEQ_NUMER_AVB = 667255832


/*AVERBAÇÃO POR PERIODO */
SELECT DISTINCT a.seq_numer_avb AS sequencial_averbacao,
                num_averb_cli AS averbacao, moeda.sig_simbo_moe,
                dhr_embar AS dh_embarque, dhr_averb AS dh_averbacao,
                cod_docum_emb AS documento,
                SUBSTR (CASE
                           WHEN a1.tip_local IN (1, 2)
                              THEN a1.cod_ident_pad
                           ELSE a11.cod_ident_pad || '-' || a1.nom_local
                        END,  1,  2  ) origem,
                SUBSTR (CASE
                           WHEN a2.tip_local IN (1, 2)
                              THEN a2.cod_ident_pad
                           ELSE a22.cod_ident_pad || '-' || a2.nom_local
                        END,  1,  2 ) destino,
                vlr_embar AS valor_embarque, vlr_is AS valor_is,
                sta_fluvi AS fluvial, sta_perna_ori AS fluvial_pu,
                sta_perna_des AS fluvial_amrr, idt_carga_dsc AS ocddcdi,
                sta_avari AS avaria, idt_veicu AS veiculo_proprio,
                CASE  WHEN relac.num_etapa_avb = 1
                      THEN 0
                ELSE relac.seq_numer_fat
                END faturado
           FROM bil_averbacao a INNER JOIN v_bil_moeda moeda
                ON moeda.num_moeda = a.num_moeda_avb
                INNER JOIN bil_localidade a1
                ON a1.seq_numer_loc = a.seq_local_ori
                LEFT JOIN bil_localidade a11
                ON a1.seq_local_pai = a11.seq_numer_loc
                INNER JOIN bil_localidade a2
                ON a2.seq_numer_loc = a.seq_local_des
                LEFT JOIN bil_localidade a22
                ON a2.seq_local_pai = a22.seq_numer_loc
                INNER JOIN bil_relac_averb_propt relac
                ON relac.seq_numer_avb = a.seq_numer_avb
                INNER JOIN bil_proposta p
                ON p.seq_numer_prs = relac.seq_numer_prs
                INNER JOIN v_bil_moeda m ON m.num_moeda = p.num_moeda_prs
          WHERE p.seq_numer_prs = 496582
          AND TRUNC (a.dhr_embar) BETWEEN   TO_DATE ('2020-04' , 'yyyy-MM')
          AND                     LAST_DAY (TO_DATE ( '2020-04', 'yyyy-MM'));

