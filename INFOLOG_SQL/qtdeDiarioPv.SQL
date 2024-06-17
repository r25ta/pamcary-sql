
/* Quantidade de Viagens por Macro 51*/
select to_char(dhr_event,'yyyymm') as ano_mes_ref,
       to_char(dhr_event,'dd') as dia_ref,
       count(*) as num_macro
from mct_macro mm
where mm.ctl_trnsp in (12684,37471)
and mm.num_macro = 51
and to_char(dhr_event,'yyyymm') between '200302' and '200305'
group by to_char(dhr_event,'yyyymm'), to_char(dhr_event,'dd')


/* Quantidade de Viagens por PV */
select to_char(dhr_inclu,'yyyymm') as ano_mes_ref,
       to_char(dhr_inclu,'dd') as dia_ref, fc_vinculado_nom_guerr(pv.ctl_trnsp) as Trnsp, 
       count(*) as Qtd_viage, pv.ctl_empre_equ
from plano_viagem pv
where pv.ctl_opera_tip in (3,13)
and pv.sit_plvia <> 10
and pv.ctl_empre_equ in (1,2)
and to_char(dhr_inclu,'yyyymm') between '200302' and '200305'
group by to_char(dhr_inclu,'yyyymm'), to_char(dhr_inclu,'dd'), pv.ctl_trnsp, pv.ctl_empre_equ


