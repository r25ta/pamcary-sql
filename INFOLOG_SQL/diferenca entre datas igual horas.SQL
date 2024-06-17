select * from dispositivo

select * from modelo_dispositivo


select * from veiculo_plano_viagem


select * from plano_viagem
where ctl_plvia in (1153952, 1155406, 1156654, 1156845)


select * from usuario_internet
where usr_name like '%UNILEVER%'


select * from posicao_dispositivo


select to_date(round((e2.dhr_event - e1.dhr_event)),'hh24:mi:ss') from plano_controle

left join evento_plano_controle e1 on
e1.ctl_plano_ctl = plano_controle.ctl_plano_ctl and
e1.ctl_parad = 24 and e1.ctl_vincd = plano_controle.ctl_vincd

left join evento_plano_controle e2 on e2.ctl_plano_ctl = plano_controle.ctl_plano_ctl and
e2.ctl_parad = 10 and e1.ctl_vincd = plano_controle.ctl_vincd
where

plano_controle.ctl_plano_ctl = 9227


select * from evento_plano_controle
where ctl_plano_ctl = 9227
and ctl_parad = 24
and ctl_vincd = 51214

