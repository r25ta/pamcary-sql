SELECT ctl_posic_dio,cod_dispo_rst,tip_rastr_dio,num_lote,NVL(des_mensg_eve,' ') AS des_mensg_eve,
NVL(des_corpo_mac, ' ') AS des_corpo_mac, TO_CHAR(dhr_receb_frn,'DD/MM/YYYY HH24:MI:SS') AS dhr_receb_frn,
TO_CHAR(dhr_envio_frn,'DD/MM/YYYY HH24:MI:SS') AS dhr_envio_frn,TO_CHAR(dhr_event,'DD/MM/YYYY HH24:MI:SS') AS dhr_event,
TO_CHAR(dhr_inclu_ter,'DD/MM/YYYY HH24:MI:SS') AS dhr_inclu_ter,num_carga_frn, NVL(num_latit_eve,'000000') AS num_latit_eve,
NVL(num_longi_eve,'000000') AS num_longi_eve, cod_event_ori, NVL(num_base_col,'0') AS num_base_col, tip_rastr_col,
NVL(ctl_parad,'0') AS ctl_parad
FROM posicao_dispositivo
order by num_lote desc
