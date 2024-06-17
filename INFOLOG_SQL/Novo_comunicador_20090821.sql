select to_char(dhr_event,'dd/mm/yyyy hh24:mi:ss'), to_char(dhr_alter,'dd/mm/yyyy hh24:mi:ss'),
num_termn, ctl_prove_tec, m.* from monitora_terminal m
where tip_event_ter = 99
and ctl_prove_tec <> 1
order by m.ctl_prove_tec 

and ctl_prove_tec = 2
 
select ctl_prove_tec, count(num_termn)
from monitora_terminal
where tip_event_ter = 99
and to_char(dhr_alter,'yyyymmddhh24mi') between '200908201600' and '200908201800'
group by ctl_prove_tec, count(num_termn)



select * from provedor_tecnologia


select * from evento_gerenciadora_risco
where idt_tipo_eve = 'P'
and cod_docum_pvd= '00263093000147'



/*CONSULTA POSIÇÕES
PERIODO 20/08/2009 08:00 ATE 27/08/2009 08:00
PERIODO 12/08/2009 08:00 ATE 19/08/2009 08:00
*/
SELECT P.ctl_prove_tec, P.des_prove_tec AS tecnologia , COUNT(H.num_seque_ter) AS total  
FROM HIST_LOG_MONITORA_TERMINAL H, PROVEDOR_TECNOLOGIA P
WHERE H.dhr_alter BETWEEN TO_DATE('200908181200','yyyymmddhh24mi') 
  AND TO_DATE('200908191200','yyyymmddhh24mi')
  AND H.cod_user = 'COMUNICADOR'
  AND P.ctl_prove_tec = H.ctl_prove_tec
  AND H.tip_event_ter = 99
  GROUP BY P.ctl_prove_tec, P.des_prove_tec
  HAVING COUNT(H.num_seque_ter) > 0
  order by total


/*CONSULTA MENSAGENS
PERIODO 20/08/2009 08:00 ATE 27/08/2009 08:00
PERIODO 12/08/2009 08:00 ATE 19/08/2009 08:00
*/
SELECT P.ctl_prove_tec, P.des_prove_tec AS tecnologia , COUNT(H.num_seque_ter) AS total  
FROM HIST_LOG_MONITORA_TERMINAL H, PROVEDOR_TECNOLOGIA P
WHERE H.dhr_alter BETWEEN TO_DATE('200908181200','yyyymmddhh24mi') 
  AND TO_DATE('200908191200','yyyymmddhh24mi')
  AND H.cod_user = 'COMUNICADOR'
  AND P.ctl_prove_tec = H.ctl_prove_tec
  AND H.tip_event_ter <> 99
  GROUP BY P.ctl_prove_tec, P.des_prove_tec
  HAVING COUNT(H.num_seque_ter) > 0
  order by total


select distinct num_placa_trd from hist_log_monitora_terminal
where ctl_prove_tec = 6
order by dhr_alter desc
18/08 à 19/08 - 12:00 
1676584

20/08 à 21/08 - 12:00
437978 

select (437978 /1676584) from dual


select * from relac_veiculo_dispositivo
where ctl_dispo_rst in (
29038,
29043,
29021,
41202,
84700,
29015,
4901,
2698,
21621,
43141
)
and sta_ativo='S'

select p.ctl_plvia, d.ctl_dispo_rst, d.cod_dispo_rst, to_char(p.dhr_posic_ult,'dd/mm/yyyy hh24:mi:ss'), 
to_char(dhr_inclu,'dd/mm/yyyy hh24:mi:ss') 
from relac_veiculo_dispo_plano r, plano_viagem p, dispositivo d
where  p.ctl_plvia = r.ctl_plvia
and p.sit_plvia in (0,1)
and d.ctl_dispo_rst = r.ctl_dispo_rst
and d.ctl_prove_tec = 2
order by p.dhr_posic_ult, p.dhr_inclu desc

SELECT tp.des_parad, tp.ctl_parad,tip_prazo_cli, num_seque 
FROM tipo_parada tp, relac_prazo_evento rp 
WHERE rp.tip_prazo_cli in (1,3) 
AND tp.ctl_parad = rp.ctl_parad 
ORDER BY rp.num_seque 
 

select * from veiculo
where num_placa in ('CVN8180','MZW0634','MZW0644','MZW0654')