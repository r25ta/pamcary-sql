select * from impor_plano_viagem
where cod_docum_fis ='1001757170'

select * from impor_plvia_conve

select * from impor_arqui_plano_viagem
where ctl_implv in (74942,78840,78792)


select mpv.ctl_plvia AS PLVIA, 
mpv.num_termn AS TERMN, 
p.des_prove_tec AS PROVEDOR,
to_char(mpv.dhr_event,'DD/MM/YYYY HH24:MI:SS') AS EVENT, 
MPV.DES_EVENT AS DES_EVENT,
MPV.NUM_PLACA AS PLACA,
MPV.TXT_EVENT_TER AS TXT_EVENT,
TP.DES_EVENT_TER AS EVENTO,
TO_CHAR(MPV.DHR_INCLU,'DD/MM/YYYY HH24:MI') AS INCLU
from monitora_plano_viagem mpv, 
provedor_tecnologia p, 
TIPO_EVENTO_TERMINAL TP
where ctl_plvia = 3820876
AND TP.TIP_EVENT_TER = MPV.TIP_EVENT_TER
AND MPV.CTL_PROVE_TEC = p.ctl_prove_tec
order by dhr_event



select * from roteiro_motorista
where ctl_plvia = 3836246



select * from endereco_vinculado