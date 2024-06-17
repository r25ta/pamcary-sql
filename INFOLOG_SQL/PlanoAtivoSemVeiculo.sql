select pv.ctl_plvia as plano, spv.des_situa as situacao, tp.des_opera_tip as operacao, to_char(pv.dhr_inclu,'dd/mm/yyyy hh24:mi:ss') as inclusão
from plano_viagem pv, situacao_plano_viagem spv, tipo_operacao tp
where pv.ctl_opera_tip = tp.ctl_opera_tip
and spv.sit_plvia = pv.sit_plvia
--where sit_plvia in (0,1)
--and ctl_opera_tip = 290
minus 
select pv.ctl_plvia, spv.des_situa, tp.des_opera_tip,to_char(pv.dhr_inclu,'dd/mm/yyyy hh24:mi:ss') as inclusão
from plano_viagem pv, 
  veiculo_plano_viagem vpv, 
  situacao_plano_viagem spv, 
  tipo_operacao tp
where vpv.ctl_plvia = pv.ctl_plvia
and pv.ctl_opera_tip = tp.ctl_opera_tip
and spv.sit_plvia = pv.sit_plvia
--and pv.sit_plvia in (0,1)
--and pv.ctl_opera_tip = 290

