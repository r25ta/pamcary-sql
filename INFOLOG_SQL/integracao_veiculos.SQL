select num_placa "Placa Veiculo",ctl_veicu"Cod Pamcary",num_veicu_ope "Cod Opentech",
sta_situa_vei "Status", sta_respl_prc"Resp. Proc.",
to_char(dhr_procs_vei,'dd/mm/yyyy hh24:mm:ss') "Data/Hora atualização",cod_user "Usuário cadstro",
to_char(dhr_alter,'dd/mm/yyyy hh24:mm:ss') "Data/Hora   cadastro"
from ref_veiculo
where num_placa in ('KAC2777','CGS1045','KEP3636','GRN5678','LXO3346','BWN3119')

select num_placa "Placa Veiculo",ctl_veicu"Cod Pamcary",num_veicu_ope "Cod Opentech",
sta_situa_vei "Status", sta_respl_prc"Resp. Proc.",
to_char(dhr_procs_vei,'dd/mm/yyyy hh24:mm:ss') "Data/Hora atualização",cod_user "Usuário cadstro",
to_char(dhr_alter,'dd/mm/yyyy hh24:mm:ss') "Data/Hora   cadastro"
from ref_veiculo
where to_char(dhr_alter,'dd/mm/yyyy')='16/11/2006'


select v.num_placa,vp.ctl_plvia,
to_char(vp.dhr_manut,'dd/mm/yyyy hh24:mm:ss') "Data/Hora Plano"
from veiculo_plano_viagem vp, veiculo v
where vp.ctl_veicu=v.ctl_veicu
and v.num_placa in ('KAC2777','CGS1045','KEP3636','GRN5678','LXO3346','BWN3119')
