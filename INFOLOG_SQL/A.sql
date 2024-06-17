select to_char(dhr_posic_ult, 'dd/mm/yyyy hh24:mi') as dhr_posic_ult1,
fc_vinculado_nom_guerr(p.ctl_motot) as nome_motot,
to_char(dhr_plvia_TER, 'dd/mm/yyyy hh24:mi:ss') as dhr_prv_TER,
nvl(to_char(fc_dhr_inicio_viagem(p.ctl_plvia), 'dd/mm/yyyy hh24:mi:ss'), '0') as dhr_rea_ini,
p.*, tp.ctl_vincd_emb from plano_viagem p, tipo_operacao tp
where sit_plvia in ( 0, 1 )
and p.ctl_opera_tip = 51
and p.ctl_opera_tip = tp.ctl_opera_tip
order by p.ctl_opera_tip, ctl_remet, ctl_trnsp, ctl_plvia


select ctl_plvia, ctl_rtmot, ctl_ptopd, num_seque, sit_fase_rea
from roteiro_motorista
where ctl_plvia = 792180
and ctl_parad = 12 
order by num_seque


select ctl_vincd_emb from tipo_operacao where ctl_opera_tip = 51

select to_char(dhr_toler, 'hh24:mi:ss') AS dhr_toler
from perfil_tolerancia_alerta 
where ctl_vincd = 108762
and tip_alert_vie = 4


select * from  usuario_internet
where usr_name like '%BELEM%'
