
/*FREQUENCIA DE VIAGENS PARA EXPORTAÇÃO*/
select dhr_alter, ctl_opera_tip, count(1) from supervisor.tinf_plano_viagem_externo 
where dhr_alter between'2024-03-01 00:00:00' and now()
group by dhr_alter, ctl_opera_tip  
having count(1) > 1
