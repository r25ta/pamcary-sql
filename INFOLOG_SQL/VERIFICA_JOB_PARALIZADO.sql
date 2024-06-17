/*VERIFICA JOB PARALIZADO*/
select J.JOB_NAME , B.*
from irlote.BATCH_JOB_EXECUTION B, irlote.BATCH_JOB_INSTANCE j
where b.job_instance_id = j.job_instance_id
--AND J.JOB_NAME = 'JOB_CONSOME_EVENTOS_SIGA' --
AND B.End_Time Is Null
--AND B.STATUS = 'UNKNOWN'
order by B.job_instance_id;


select * from v_crp_provedor_tecnologia

select to_char(a.dhr_event,'dd/mm/yyyy hh24:mi:ss'),
       to_char(a.dhr_inclu,'dd/mm/yyyy hh24:mi:ss'),
       a.idt_regis,
       a.* 
from evento_gerenciadora_risco a
where cod_docum_pvd = '03585974000172'
order by ctl_event desc

select count(1), idt_regis
from evento_gerenciadora_risco a
where cod_docum_pvd = '03585974000172'
group by idt_regis
