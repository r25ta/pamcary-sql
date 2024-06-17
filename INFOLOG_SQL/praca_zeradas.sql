select fc_vinculado_nom_guerr(rv.ctl_vincd) operacao,
  fc_vinculado_nom_guerr(rv.ctl_vincd_rld) entidade,
  e.ctl_vincd as cod,
  e.des_latit,
  e.des_longi,
  e.num_latit,
  e.num_longi,
  p.cod_praca,
  p.des_praca as praca,
  uf.sig_unfed as uf,
  ps.nom_pais as pais,
  TO_CHAR(e.dhr_manut,'DD/MM/YYYY HH24:MI:SS') as dhr_manut,
  e.cod_user
from endereco_vinculado e, 
    praca p, 
    unidade_federal uf, 
    pais ps, 
    relacionamento_vinculado rv, tipo_operacao t
where p.cod_praca = e.cod_praca
and uf.cod_unfed = p.cod_unfed
and ps.cod_pais = uf.cod_pais
and rv.CTL_VINCD_RLD = e.ctl_vincd
and t.CTL_VINCD_EMB = rv.CTL_VINCD
and e.num_latit = 0


select 
  pr.cod_praca, 
  pr.des_praca, 
  pr.num_cep, 
  pr.num_ibge, 
  pr.num_ddd, 
  pr.num_latit, 
  pr.num_longi,   
  uf.cod_unfed,
  uf.sig_unfed,
  p.cod_pais,
  p.nom_pais
from 
  praca pr, 
  unidade_federal uf, 
  pais p
where uf.cod_unfed = pr.cod_unfed
and p.cod_pais = uf.cod_pais
and pr.num_latit = 0

select * from relacionamento_vinculado
select * from tipo_operacao
select * from endereco_vinculado
select * from praca
select * from unidade_federal
select * from pais



