  --V_PLANO_VIAGEM_DIA_ANTERIOR
  select distinct o.ctl_opera_tip 
     , o.des_opera_tip
     , dv.cod_docum
     , fc_vinculado_nom_guerr(o.ctl_vincd_emb) nom_guerr
     , pv.ctl_plvia
     , to_char(pv.dhr_inclu,'dd/mm/yyyy hh24:mi') dhr_inclu
     , fc_placa_veiculo(pv.ctl_plvia) num_placa
     , DECODE(d.ctl_prove_tec, 1, 'AUTOTRAC'
                             , 2, 'CONTROLSAT'
                             , 3, 'POSITRON'
                             , 4, 'OMNILINK'
                             , 5, 'JABURSAT'
                             , 6, 'OMNIDATA-SATELITE'
                             , 7, 'RODOSIS'
                             , 9, 'OUTROS'
                             , 13, 'CONTROL LOC'
                             , 14, 'TRANSPONDER'
                             , 15, 'SEM RASTREAMENTO'
                             , 17, 'SASCAR'
                             , 21, 'CIELO'
                             , 22, 'SIGHRA'
                             , 23, 'TRACKME'
                             , 24, 'CERTASAT'
                             , 25, 'SEGMINAS'
                             , 26, 'STI'
                             , 27, '3TSYSTEMS'
                             , 28, 'LINK-MONITORAMENTO'
                             , 29, 'PROTECTSAT'
                             , 30, 'OMNILOC') AS tecnologia
     , fc_vinculado_nom_guerr(pv.ctl_trnsp) nom_trnsp
     , fc_vinculado_documento(pv.ctl_trnsp,1) cnpj_trnsp
     , tov.des_opera_vie
 from  plano_viagem              pv
     , tipo_operacao             o
     , doc_vinculado             dv
     , relac_veiculo_dispo_plano r
     , dispositivo               d
     , veiculo                   v
     , modelo_veiculo            mv
     , genero_veiculo            gv
     , tipo_veiculo              tp
     , tipo_operacao_viagem      tov
where pv.dhr_inclu between TO_DATE('20140901000001','YYYYMMDDHH24MISS') AND TO_DATE('20140930235959','YYYYMMDDHH24MISS') 
  and pv.ctl_opera_tip = o.ctl_opera_tip
  and dv.ctl_vincd     = o.ctl_vincd_emb
  and pv.ctl_plvia     = r.ctl_plvia(+)
  and r.ctl_dispo_rst  = d.ctl_dispo_rst(+)
  and r.ctl_veicu      = v.ctl_veicu(+)
  and v.ctl_model      = mv.ctl_model(+)
  and mv.ctl_gener     = gv.ctl_gener(+)
  and gv.ctl_veicu_tip = tp.ctl_veicu_tip(+)
  and pv.tip_opera_vie = tov.tip_opera_vie
  and (tp.ctl_veicu_tip is null or tp.ctl_veicu_tip not in (4))
  and ((pv.tip_rastr in (1,2) and (d.ctl_prove_tec is null or d.ctl_prove_tec <> 14)) or (pv.tip_rastr in (3,4)))
  order by pv.ctl_plvia
  
  
  
  --V_PLANO_VIAGEM_CANCELADO_MES
  select p.ctl_plvia,
       to_char(p.dhr_manut, 'dd/mm/yyyy hh24:mi') dhr_manut
  from plano_viagem  p
 where p.dhr_inclu between TO_DATE('20140901000001','YYYYMMDDHH24MISS') AND TO_DATE('20140930235959','YYYYMMDDHH24MISS')
       /* Foi colocado sysdate-1 devido o usuário retirar o relatório diarimente
          e no dia primeiro de cada mês deverá considerar o mês anterior */
   and p.sit_plvia     = 10 --Exclusao plano viagem
 order by p.ctl_plvia
  