SELECT PR.cod_praca, PR.num_ddd, PR.des_praca,
       UF.sig_unfed, UF.nom_unfed, P.nom_pais, R.nom_regia, PR.num_latit, PR.num_longi
FROM PRACA PR, UNIDADE_FEDERAL UF, PAIS P, REGIAO R
WHERE UF.cod_unfed = PR.cod_unfed
AND R.num_regia = UF.num_regia
AND P.cod_pais = UF.cod_pais        
order by sig_unfed, des_praca asc


select cod_praca, num_cep, num_ddd, des_praca, num_latit, num_longi from praca
order by des_praca asc

select cod_unfed, sig_unfed, nom_unfed from unidade_federal
order by sig_unfed asc

select num_regia, nom_regia from regiao
order by nom_regia asc

select cod_pais, nom_pais from pais
order by nom_pais asc

