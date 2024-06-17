select * from plano_viagem
where sit_plvia NOT IN (0,1,4,8,11)
and ctl_user = 1
and ctl_empre_equ IN (1,2)
and to_char(dhr_inclu,'yyyymmdd') > '20021031'
order by dhr_inclu desc



update plano_viagem set
ctl_user = 2
where sit_plvia NOT IN (0,1,4,8,11)
and ctl_user = 1
and ctl_empre_equ = 2
and to_char(dhr_inclu,'yyyymmdd') < '20021031'

