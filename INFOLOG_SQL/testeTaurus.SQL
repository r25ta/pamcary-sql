select * from plano_viagem
where ctl_plvia = 857335

select * from roteiro_motorista

select num_seque, ctl_ptopd, ctl_parad, to_char(dhr_efeti_rea,'dd/mm/yyyy hh24:mi:ss') as real,
       to_char(dhr_previ_sis,'dd/mm/yyyy hh24:mi:ss') as previ,
       sit_fase_rea from roteiro_motorista
where ctl_plvia = 857336



select * from endereco_vinculado
where ctl_vincd = 194393

latitude = 224331
longitude = 473857



select NUM_TERMN, NUM_LATIT, NUM_LONGI, TIP_EVENT_TER, TO_CHAR(DHR_EVENT,'DD/MM/YYYY HH24:MI:SS') AS EVENT from log_monitora_terminal
where num_termn = 1111111
and tip_event_ter <> 99
order by dhr_event desc
