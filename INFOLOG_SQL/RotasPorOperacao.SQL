select r.ctl_rota AS CODIGO_ROTA, r.des_rota AS NOME_ROTA,
       fc_vinculado_nom_guerr(rv.ctl_ptopd) AS POSTO_ABASTECIMENTO,
       ev.des_ender AS ENDERECO, ev.des_latit AS LATITUDE,
       ev.des_longi AS LONGITUDE,
       p.des_praca AS PRACA,
       uf.nom_unfed AS UF,
       uf.sig_unfed AS SIG_UF 
from rota r, roteiro_viagem rv, endereco_vinculado ev, praca p, unidade_federal uf
where ctl_opera_tip = 22
and rv.ctl_rota = r.ctl_rota
and ev.ctl_vincd = rv.ctl_ptopd
and p.cod_praca = ev.cod_praca 
and uf.cod_unfed = p.cod_unfed
order by r.ctl_rota 
