SELECT DISTINCT( RV.ctl_ptopd ), FC_VINCULADO_NOM_GUERR(RV.ctl_ptopd), DV.cod_docum, V.nom_vincd,
       P.des_praca, P.num_cep, P.num_ddd, UF.nom_unfed, UF.sig_unfed, PA.nom_pais, EV.des_latit, EV.des_longi 
FROM ROTA R, ROTEIRO_VIAGEM RV, VINCULADO V, DOC_VINCULADO DV, ENDERECO_VINCULADO EV, PRACA P, UNIDADE_FEDERAL UF, PAIS PA
WHERE RV.ctl_rota = R.ctl_rota
AND V.ctl_vincd = RV.ctl_ptopd
AND DV.ctl_vincd = V.ctl_vincd
AND EV.ctl_vincd = V.ctl_vincd
AND P.cod_praca = EV.cod_praca
AND UF.cod_unfed = P.cod_unfed
AND PA.cod_pais = UF.cod_pais
AND R.ctl_opera_tip = 3
ORDER BY RV.ctl_ptopd




select a.des_ativi,
       v.nom_guerr AS NOME_FANTASIA,
       v.nom_vincd AS RAZAO_SOCIAL,
       NVL(dv.cod_docum,'000000000000000') AS CNPJ,
       ev.des_ender AS ENDERECO,
       ev.des_bairr_end AS BAIRRO,
       ev.des_numer_end AS NUMERO,
       p.num_cep AS CEP,
       p.num_ddd AS DDD,
       p.des_praca AS PRACA,
       u.sig_unfed AS UF, 
       r.nom_regia AS REGIAO,
       s.nom_pais AS PAIS,
       NVL(ev.des_latit,'000000') AS LATITUDE,
       NVL(ev.des_longi,'000000') AS LONGITUDE     
from vinculado v, doc_vinculado dv, endereco_vinculado ev, praca p, unidade_federal u, regiao r, pais s, atividade a
where dv.ctl_vincd = v.ctl_vincd
and v.ctl_vincd = ev.ctl_vincd
and ev.cod_praca=p.cod_praca
and u.cod_unfed = p.cod_unfed
and r.num_regia = u.num_regia
and a.cod_ativi = v.cod_ativi
and v.cod_ativi = 7
and s.cod_pais = u.cod_pais
ORDER BY des_ativi, des_praca
