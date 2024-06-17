
select * from comunicacao_vinculado order by ctl_vincd
select * from tipo_comunicacao
select * from tipo_contato

select v.nom_guerr,  v.nom_vincd,
       dv.cod_docum,
       ev.des_ender,
       ev.des_bairr_end,
       ev.des_numer_end,
       ev.des_compl_end,
       ev.des_latit,
       ev.des_longi,
       ev.num_latit,
       ev.num_longi,
       p.des_praca,
       uf.nom_unfed,
       r.nom_regia,              
       pa.nom_pais,
       cv.des_comun_vin,
       tc.des_tipo_cmu 
from vinculado v, doc_vinculado dv, endereco_vinculado ev, praca p, unidade_federal uf, regiao r, pais pa,
     comunicacao_vinculado cv, tipo_comunicacao tc
where v.ctl_vincd = dv.ctl_vincd
    and v.ctl_vincd = ev.ctl_vincd  
    and p.cod_praca = ev.cod_praca
    and uf.cod_unfed = p.cod_unfed
    and r.num_regia = uf.num_regia
    and pa.cod_pais = uf.cod_pais
    and v.ctl_vincd = cv.ctl_vincd(+)
    and tc.tip_comun(+) = cv.tip_comun
    and v.cod_ativi = 7
order by p.des_praca



select p.des_praca, p.num_latit, p.num_longi, u.sig_unfed from praca p, unidade_federal u
where u.cod_unfed = p.cod_unfed
order by u.sig_unfed desc, des_praca desc
