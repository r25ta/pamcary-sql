select count(*) from(
select ctl_plvia, count(*)
from hist_plano_viagem
group by ctl_plvia
having count(*) > 1)

select count(*) from(
select ctl_plvia, count(*)
from hist_destinatario_plano_viagem
group by ctl_plvia
having count(*) > 1)

select count(*) from(
select ctl_rtmot, count(*)
from hist_roteiro_motorista
group by ctl_rtmot
having count(*) > 1
)

select count(*) from(
select ctl_plvia, ctl_motot, count(*)
from HIST_MOTORISTA_PLANO_VIAGEM
group by ctl_plvia, ctl_motot
having count(*) > 1
)

select count(*) from(
select ctl_plvia, ctl_veicu, count(*)
from HIST_VEICULO_PLANO_VIAGEM
group by ctl_plvia, ctl_veicu
having count(*) > 1
)

select count(*) from(
select ctl_plvia, DHR_ANALI_EVE, count(*)
from HIST_ANALISE_PLANO_VIAGEM
group by ctl_plvia, DHR_ANALI_EVE
having count(*) > 1
)


select count(*) from( select distinct ctl_plvia from temp_hist_plano_viagem)

select * from hist_plano_viagem
delete hist_plano_viagem

select count(*) from temp_hist_dest_plano_viagem

select count(*) from temp_hist_anali_plano_viagem


