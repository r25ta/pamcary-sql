/*AGRUPAMENTO POR TECNOLOGIA*/
select p.des_prove_tec as des_prove_tec, count(1) as total 
from hist_log_monitora_terminal h, 
     provedor_tecnologia p
where h.dhr_alter between to_date('20101001000000','yyyymmddhh24miss') 
    and to_date('20101031235959','yyyymmddhh24miss')
    and p.ctl_prove_tec = h.ctl_prove_tec
group by p.des_prove_tec

/*AGRUPAMENTO DE VIAGENS POR OPERAÇÃO*/
select t.des_opera_tip, count(1) as total
from plano_viagem p, tipo_operacao t
where p.dhr_inclu between to_date('20101001000000','yyyymmddhh24miss') 
    and to_date('20101031235959','yyyymmddhh24miss')
    and t.ctl_opera_tip = p.ctl_opera_tip
    and p.sit_plvia <> 10
    and p.ctl_opera_tip <> 51
group by t.des_opera_tip

/*AGRUPAMENTO DE VIAGENS POR TIPO DE MONITORAMENTO*/
select t.des_tipo_rst, count(1) as total
from plano_viagem p, tipo_rastreamento t
where p.dhr_inclu between to_date('20101001000000','yyyymmddhh24miss') 
    and to_date('20101031235959','yyyymmddhh24miss')
    and t.tip_rastr = p.tip_rastr
    and p.sit_plvia <> 10
    and p.ctl_opera_tip <> 51
group by t.des_tipo_rst

/*AGRUPAMENTO DE VIAGENS POR TIPO DE MOTORISTA E OPERACAO*/
select t.des_opera_tip, m.des_motot_tip, count(1) as total
from plano_viagem p, tipo_operacao t, tipo_motorista m
where p.dhr_inclu between to_date('20101001000000','yyyymmddhh24miss') 
    and to_date('20101031235959','yyyymmddhh24miss')
    and t.ctl_opera_tip = p.ctl_opera_tip
    and m.tip_motot = p.tip_motot
    and p.sit_plvia <> 10
    and p.ctl_opera_tip <> 51
group by t.des_opera_tip, m.des_motot_tip