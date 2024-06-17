SELECT op.des_opera_tip as OPERACAO , 
    NVL(dop.cod_docum,' ') as CNPJ_VINCULADO_OPERAÇÃO ,
       pv.ctl_plvia as PLANO_VIAGEM,
       FC_PLACA_VEICULO(pv.ctl_plvia) as PLACA_VEICULO,       

       NVL( ( SELECT dmpv.cod_docum 
              FROM DOC_VINCULADO dmpv, 
                MOTORISTA_PLANO_VIAGEM mpv
              WHERE dmpv.ctl_vincd = mpv.ctl_motot
                AND  mpv.ctl_plvia = pv.ctl_motot ), ' ' ) as CPF_MOTORISTA,

       NVL( ( SELECT FC_VINCULADO_NOM_GUERR(ctl_motot) 
              FROM MOTORISTA_PLANO_VIAGEM
              WHERE ctl_plvia = pv.ctl_motot ), ' ' ) as NOME_MOTORISTA,

       NVL(dtpv.cod_docum,' ') as CNPJ_TRANSPORTADORA,

       FC_VINCULADO_NOM_GUERR(PV.ctl_trnsp) as RAZAO_SOCIAL_TRANSPORTADORA,

       NVL(drpv.cod_docum,' ') as CNPJ_ORIGEM,

       FC_VINCULADO_NOM_GUERR(PV.ctl_remet) as RAZAO_SOCIAL_ORIGEM,

       NVL( (SELECT des_latit FROM ENDERECO_VINCULADO WHERE ctl_vincd = pv.ctl_remet), ' ')  as LATITUDE_ORIGEM,

       NVL( (SELECT des_longi FROM ENDERECO_VINCULADO WHERE ctl_vincd = pv.ctl_remet) ,' ' ) as LONGITUDE_ORIGEM,

       TO_CHAR(pv.dhr_plvia_ini,'DD/MM/YYYY HH24:MI:SS') as PREVISAO_INICIO_VIAGEM,

       NVL(ddpv.cod_docum, ' ') as CNPJ_DESTINO,

       FC_VINCULADO_NOM_GUERR(PV.ctl_desti) as RAZAO_SOCIAL_DESTINO,

       NVL( (SELECT des_latit FROM ENDERECO_VINCULADO WHERE ctl_vincd = pv.ctl_desti) ,' ' ) as LATITUDE_DESTINO,

       NVL( (SELECT des_longi FROM ENDERECO_VINCULADO WHERE ctl_vincd = pv.ctl_desti) ,' ' ) as LONGITUDE_DESTINO

FROM PLANO_VIAGEM pv, 
     TIPO_OPERACAO op,
     DOC_VINCULADO dtpv,
     DOC_VINCULADO drpv,
     DOC_VINCULADO ddpv,
     DOC_VINCULADO dop
WHERE op.ctl_opera_tip = pv.ctl_opera_tip
AND pv.ctl_trnsp = dtpv.ctl_vincd
AND pv.ctl_remet = drpv.ctl_vincd
AND pv.ctl_desti = ddpv.ctl_vincd
AND op.ctl_vincd_emb = dop.ctl_vincd
AND pv.ctl_opera_tip = 744