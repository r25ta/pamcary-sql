select a.cod_docum_pvd,b.nom_fants , a.idt_regis, count(1)  
from supervisor.tevento_gerenciadora_risco a,
pamais_prd.v_crp_provedor_tecnologia b
where b.cod_docum_pri = a.cod_docum_pvd 
group by a.cod_docum_pvd,b.nom_fants, a.idt_regis



select max(dhr_event) from supervisor.tevento_gerenciadora_risco
where idt_regis = 5
and cod_docum_pvd = '03112879000151'
'03585974000172'
