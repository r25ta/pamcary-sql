select distinct vpv.ctl_veicu, v.num_placa, D.COD_DISPO_RST, P.DES_PROVE_TEC --, to_char(vpv.dhr_manut,'dd/mm/yyyy hh24:mi:ss')  
from veiculo_plano_viagem vpv, veiculo v, RELAC_VEICULO_DISPO_PLANO R, DISPOSITIVO D, 
PROVEDOR_TECNOLOGIA P, RELAC_VEICULO_DISPOSITIVO RV
where vpv.dhr_manut > to_date('20150509235959','yyyymmddhh24miss')
and vpv.ctl_veicu = v.ctl_veicu
AND VPV.CTL_VEICU = R.CTL_VEICU
AND R.CTL_DISPO_RST = D.CTL_DISPO_RST
AND D.CTL_PROVE_TEC = P.CTL_PROVE_TEC
AND RV.CTL_VEICU = VPV.CTL_VEICU
AND RV.STA_ATIVO = 'S'
order by vpv.dhr_manut




SELECT * FROM RELAC_VEICULO_DISPO_PLANO
SELECT * FROM RELAC_VEICULO_DISPOSITIVO
SELECT * FROM PROVEDOR_TECNOLOGIA

select to_char(dhr_event,'dd/mm/yyyy hh24:mi:ss'), m.* 
from monitora_plano_viagem m
where num_termn = 416172
order by ctl_monit_plv desc


select num_termn, to_char(dhr_event,'dd/mm/yyyy hh24:mi:ss') evento, 
to_char(dhr_inclu_cga,'dd/mm/yyyy hh24:mi:ss') krona,
to_char(dhr_alter,'dd/mm/yyyy hh24:mi:ss') infolog,

Trunc(mod((dhr_inclu_cga - dhr_event) *24, 60)) || ':' || 
Trunc(mod((dhr_inclu_cga - dhr_event) *24*60, 60)) || ':' ||   
Trunc(mod((dhr_inclu_cga - dhr_event) *24*60*60, 60)) dif_evento_krona,

Trunc(mod((dhr_alter - dhr_inclu_cga) *24, 60)) || ':' || 
Trunc(mod((dhr_alter - dhr_inclu_cga) *24*60, 60)) || ':' ||   
Trunc(mod((dhr_alter - dhr_inclu_cga) *24*60*60, 60))  dif_krona_infolog,

Trunc(mod((dhr_alter - dhr_event) *24, 60)) || ':' || 
Trunc(mod((dhr_alter - dhr_event) *24*60, 60)) || ':' ||   
Trunc(mod((dhr_alter - dhr_event) *24*60*60, 60))  dif_evento_infolog


from monitora_terminal
where ctl_prove_tec = 17
order by dhr_event desc
--and num_termn = 416172


Select t1.diferenca,
       Trunc(mod(t1.diferenca*24, 60)) || ':' || Trunc(mod(t1.diferenca*24*60, 60)) || ':' ||   Trunc(mod(t1.diferenca*24*60*60, 60)) dif_evento_krona
from      
(select t0.dhr_inclu_cga - t0.dhr_event diferenca
from monitora_terminal t0
where ctl_prove_tec = 17
) t1
