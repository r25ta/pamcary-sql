select 
to_char(r.dhr_inici,'dd/mm/yyyy hh24:mi:ss') entrada, 
to_char(r.dhr_fim,'dd/mm/yyyy hh24:mi:ss') saida, 
r.sta_envia_msg,
      tav.des_alert_vie tipo_alerta,
      r.tip_alert_vie,
      r.ctl_plvia viagem,
      r.cod_placa_cav,
      r.des_justi,
      fc_vinculado_nom_guerr(ctl_vincd),
to_char(r.dhr_alter,'dd/mm/yyyy hh24:mi:ss') inclusao

from RELAC_ALERTA_MOTOT_PLVIA r,
    tipo_alerta_viagem tav              
where r.ctl_plvia = 9258672
and tav.tip_alert_vie = r.TIP_ALERT_VIE
and r.tip_alert_vie = 19
order by r.DHR_ALTER desc;