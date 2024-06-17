/*CONSULTA AS CONTAS EMPROCESSAMENTO*/
select 
	  a.ctl_contr_taf,
      c.num_apoli,
      b.seq_numer_prs,
      a.dhr_inici_prt,
      a.dhr_fim_prt,
      a.dhr_alter,
      a.cod_auten_usu,
      a.num_taref_val,
      c.*
from gedad.tdad_contr_tarefa_validacao a
, gedad.v_dad_consulta_procs_propt_bilhe b
, bilhet.tbil_proposta c
where a.dhr_fim_prt is null
and b.ctl_contr_taf = a.ctl_contr_taf
and c.seq_numer_prs = b.seq_numer_prs
order by a.dhr_inici_prt

/*DELETA UMA CONTA PRESSA NA FILA DE PROCESSAMENTO.*/
DELETE FROM GEDAD.TDAD_CONTR_TAREFA_VALIDACAO
WHERE DHR_FIM_PRT IS NULL
AND CTL_CONTR_TAF IN (
25890957
)

COMMIT 

