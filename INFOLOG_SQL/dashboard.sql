
select distinct 
pv.ctl_plvia, 
rm.ctl_ptopd,
fc_vinculado_nom_guerr(ctl_ptopd) as entidade, 
max(DECODE (rm.ctl_parad, 24, rm.dhr_previ_sis, NULL)) PREV_CH,
max(DECODE (rm.ctl_parad, 24, rm.dhr_efeti_rea, NULL)) REAL_CH,

max(DECODE (rm.ctl_parad, 17, rm.dhr_previ_sis, NULL)) PREV_EU,
max(DECODE (rm.ctl_parad, 17, rm.dhr_efeti_rea, NULL)) REAL_EU,

max(DECODE (rm.ctl_parad, 26, rm.dhr_previ_sis, NULL)) PREV_IC,
max(DECODE (rm.ctl_parad, 26, rm.dhr_efeti_rea, NULL)) REAL_IC,

max(DECODE (rm.ctl_parad, 20, rm.dhr_previ_sis, NULL)) PREV_TC,
max(DECODE (rm.ctl_parad, 20, rm.dhr_efeti_rea, NULL)) REAL_TC,

max(DECODE (rm.ctl_parad, 18, rm.dhr_previ_sis, NULL)) PREV_SU,
max(DECODE (rm.ctl_parad, 18, rm.dhr_efeti_rea, NULL)) REAL_SU,

max(DECODE (rm.ctl_parad, 10, rm.dhr_efeti_rea, NULL)) REAL_IV,
max(DECODE (rm.ctl_parad, 10, rm.dhr_previ_sis, NULL)) PREV_IV,

max(DECODE (rm.ctl_parad, 11, rm.dhr_previ_sis, NULL)) PREV_ID,
max(DECODE (rm.ctl_parad, 11, rm.dhr_efeti_rea, NULL)) REAL_ID,

max(DECODE (rm.ctl_parad, 23, rm.dhr_previ_sis, NULL)) PREV_TD,
max(DECODE (rm.ctl_parad, 23, rm.dhr_efeti_rea, NULL)) REAL_TD,

max(DECODE (rm.ctl_parad, 12, rm.dhr_previ_sis, NULL)) PREV_FV,
max(DECODE (rm.ctl_parad, 12, rm.dhr_efeti_rea, NULL)) REAL_FV,

max(DECODE (rm.ctl_parad, 10, rm.dhr_tende_chg, NULL)) TENDE_IV,
max(DECODE (rm.ctl_parad, 12, rm.dhr_tende_chg, NULL)) TENDE_FV

from roteiro_motorista rm, plano_viagem pv
where 
pv.ctl_plvia = rm.ctl_plvia
and pv.ctl_opera_tip = 20
and pv.ctl_plvia = 1361334
group by pv.ctl_plvia, rm.ctl_ptopd


select to_date(sysdate - to_date('22/05/2012 15:00:00','dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss') from dual

SELECT ( ( ( (select dhr_previ_sis 
             from roteiro_motorista 
             where ctl_plvia = 1361334 
             and ctl_ptopd = 287764 
               and ctl_parad = 10) - 
                
                (select dhr_previ_sis 
                from roteiro_motorista 
                where ctl_plvia = 1361334 
                and ctl_ptopd = 287764 
                and ctl_parad = 24 )) *24*60*60)/3600) retorno
from dual

CASE WHEN PREV_IV != '' THEN ((( PREV_IV - PREV_CH )*24*60*60)/3600) ELSE ((( PREV_FV - PREV_CH )*24*60*60)/3600) END