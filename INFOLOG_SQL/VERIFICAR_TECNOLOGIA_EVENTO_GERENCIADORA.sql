select a.cod_docum_pvd,
       b.ctl_prove_ten,
       b.nom_fants,
       a.idt_regis,
       to_char(a.dhr_event,'dd/mm/yyyy hh24:mi:ss') as evento,
       to_char(a.dhr_inclu,'dd/mm/yyyy hh24:mi:ss') as inclu,
       to_char(a.dhr_alter,'dd/mm/yyyy hh24:mi:ss') as alterar
from evento_gerenciadora_risco a,
     v_crp_provedor_tecnologia b
where b.cod_docum_pri = a.cod_docum_pvd
and a.cod_docum_pvd = '05520402000211'
order by evento; 


