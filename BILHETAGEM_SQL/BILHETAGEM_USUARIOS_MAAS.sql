

/*USUARIO SISTEMA BILHETAGEM NUM_SISTE = 1021*/
select distinct ua.COD_AUTEN_USU as USU�RIO, pe.COD_dOcUM_pri AS DOCUMENTO, pe.NOM_PESSO as NOME, e.COD_EMAIL_USU 
from maas.TMAAS_SISTEMA s 
	inner join maas.TMAAS_PERFIL p on p.NUM_SISTE = s.NUM_SISTE
	inner join maas.TMAAS_USUARIO_PERFIL up on up.NUM_PERFI = p.NUM_PERFI
	inner join maas.TMAAS_USUARIO_PESSOA u on u.NUM_USUAR = up.NUM_USUAR
	inner join pamais.TCRP_PESSOA pe on pe.COD_DOCUM_PRI = u.COD_DOCUM_PES
	inner join maas.TMAAS_USUARIO_AUTENTICACAO ua on ua.NUM_USUAR = u.NUM_USUAR
	INNER JOIN maas.TMAAS_USUARIO_EMAIL e ON e.NUM_USUAR = u.NUM_USUAR 
where p.NUM_SISTE = 1021 --1047
and up.STA_ATIVO = 'S'
ORDER BY NOME

--HIERARQUIA
select distinct ua.COD_AUTEN_USU as USU�RIO, pe.NOM_PESSO as NOME, p.NOM_PERFI as PERFIL, tp.DES_VISAO as TIPO_VIS�O, case when varchar(vsu.VLR_CHAVE) = '-1' then 'TODOS' else pamais.FC_RECUPERA_NOMHIE(varchar(vsu.VLR_CHAVE)) end as VIS�O
from maas.TMAAS_SISTEMA s 
	inner join maas.TMAAS_PERFIL p on p.NUM_SISTE = s.NUM_SISTE
	inner join maas.TMAAS_USUARIO_PERFIL up on up.NUM_PERFI = p.NUM_PERFI
	inner join maas.TMAAS_USUARIO_PESSOA u on u.NUM_USUAR = up.NUM_USUAR
	inner join pamais.TCRP_PESSOA pe on pe.COD_DOCUM_PRI = u.COD_DOCUM_PES
	inner join maas.TMAAS_USUARIO_AUTENTICACAO ua on ua.NUM_USUAR = u.NUM_USUAR
	left join pamais.TCRP_VISAO_SISTEMA_USUARIO vsu on lower(vsu.COD_USUAR) = lower(ua.COD_AUTEN_USU)
	left join pamais.TCRP_VISAO_SISTEMA vs on vs.CTL_VISAO_SIS = vsu.CTL_VISAO_SIS
	left join pamais.TCRP_TIPO_VISAO tp on tp.TIP_VISAO = vs.TIP_VISAO
where p.NUM_SISTE = 1021
and up.STA_ATIVO = 'S'
and vsu.DHR_FIM_VIG is null
and vs.TIP_VISAO = 2
UNION
--CORRETOR
select distinct ua.COD_AUTEN_USU as USU�RIO, pe.NOM_PESSO as NOME, p.NOM_PERFI as PERFIL, tp.DES_VISAO as TIPO_VIS�O, case when varchar(vsu.VLR_CHAVE) = '-1' then 'TODOS' else varchar(vsu.VLR_CHAVE) end as VIS�O
from maas.TMAAS_SISTEMA s 
	inner join maas.TMAAS_PERFIL p on p.NUM_SISTE = s.NUM_SISTE
	inner join maas.TMAAS_USUARIO_PERFIL up on up.NUM_PERFI = p.NUM_PERFI
	inner join maas.TMAAS_USUARIO_PESSOA u on u.NUM_USUAR = up.NUM_USUAR
	inner join pamais.TCRP_PESSOA pe on pe.COD_DOCUM_PRI = u.COD_DOCUM_PES
	inner join maas.TMAAS_USUARIO_AUTENTICACAO ua on ua.NUM_USUAR = u.NUM_USUAR
	left join pamais.TCRP_VISAO_SISTEMA_USUARIO vsu on lower(vsu.COD_USUAR) = lower(ua.COD_AUTEN_USU)
	left join pamais.TCRP_VISAO_SISTEMA vs on vs.CTL_VISAO_SIS = vsu.CTL_VISAO_SIS
	left join pamais.TCRP_TIPO_VISAO tp on tp.TIP_VISAO = vs.TIP_VISAO
where p.NUM_SISTE = 1021
and up.STA_ATIVO = 'S'
and vsu.DHR_FIM_VIG is null
and vs.TIP_VISAO = 1
UNION
--EMPRESA
select distinct ua.COD_AUTEN_USU as USU�RIO, pe.NOM_PESSO as NOME, p.NOM_PERFI as PERFIL, tp.DES_VISAO as TIPO_VIS�O, case when varchar(vsu.VLR_CHAVE) = '-1' then 'TODOS' else p1.NOM_FANTS end as VIS�O
from maas.TMAAS_SISTEMA s 
	inner join maas.TMAAS_PERFIL p on p.NUM_SISTE = s.NUM_SISTE
	inner join maas.TMAAS_USUARIO_PERFIL up on up.NUM_PERFI = p.NUM_PERFI
	inner join maas.TMAAS_USUARIO_PESSOA u on u.NUM_USUAR = up.NUM_USUAR
	inner join pamais.TCRP_PESSOA pe on pe.COD_DOCUM_PRI = u.COD_DOCUM_PES
	inner join maas.TMAAS_USUARIO_AUTENTICACAO ua on ua.NUM_USUAR = u.NUM_USUAR
	left join pamais.TCRP_VISAO_SISTEMA_USUARIO vsu on lower(vsu.COD_USUAR) = lower(ua.COD_AUTEN_USU)
	left join pamais.TCRP_VISAO_SISTEMA vs on vs.CTL_VISAO_SIS = vsu.CTL_VISAO_SIS
	left join pamais.TCRP_TIPO_VISAO tp on tp.TIP_VISAO = vs.TIP_VISAO
	left join pamais.TCRP_PESSOA p1 on p1.CTL_PESSO = vsu.VLR_CHAVE
where p.NUM_SISTE = 1021
and up.STA_ATIVO = 'S'
and vsu.DHR_FIM_VIG is null
and vs.TIP_VISAO = 3
UNION
--PRODUTOR
select distinct ua.COD_AUTEN_USU as USU�RIO, pe.NOM_PESSO as NOME, p.NOM_PERFI as PERFIL, tp.DES_VISAO as TIPO_VIS�O, case when varchar(vsu.VLR_CHAVE) = '-1' then 'TODOS' else p1.NOM_PESSO end as VIS�O
from maas.TMAAS_SISTEMA s 
	inner join maas.TMAAS_PERFIL p on p.NUM_SISTE = s.NUM_SISTE
	inner join maas.TMAAS_USUARIO_PERFIL up on up.NUM_PERFI = p.NUM_PERFI
	inner join maas.TMAAS_USUARIO_PESSOA u on u.NUM_USUAR = up.NUM_USUAR
	inner join pamais.TCRP_PESSOA pe on pe.COD_DOCUM_PRI = u.COD_DOCUM_PES
	inner join maas.TMAAS_USUARIO_AUTENTICACAO ua on ua.NUM_USUAR = u.NUM_USUAR
	left join pamais.TCRP_VISAO_SISTEMA_USUARIO vsu on lower(vsu.COD_USUAR) = lower(ua.COD_AUTEN_USU)
	left join pamais.TCRP_VISAO_SISTEMA vs on vs.CTL_VISAO_SIS = vsu.CTL_VISAO_SIS
	left join pamais.TCRP_TIPO_VISAO tp on tp.TIP_VISAO = vs.TIP_VISAO
	left join pamais.TCRP_COLABORADOR_PAMCARY cp on cp.NUM_REGIS_PAM = vsu.VLR_CHAVE
	left join pamais.TCRP_PESSOA p1 on p1.CTL_PESSO = cp.CTL_PEFIS_CLB
where p.NUM_SISTE = 1021
and up.STA_ATIVO = 'S'
and vsu.DHR_FIM_VIG is null
and vs.TIP_VISAO = 7
UNION
--NULO
select distinct ua.NUM_USUAR, pe.COD_dOcUM_pri AS DOCUMENTO, ua.COD_AUTEN_USU as USU�RIO, pe.NOM_PESSO as NOME, p.NOM_PERFI as PERFIL, 'SEM VIS�O' as TIPO_VIS�O, 'SEM VIS�O' VIS�O
from maas.TMAAS_SISTEMA s 
	inner join maas.TMAAS_PERFIL p on p.NUM_SISTE = s.NUM_SISTE
	inner join maas.TMAAS_USUARIO_PERFIL up on up.NUM_PERFI = p.NUM_PERFI
	inner join maas.TMAAS_USUARIO_PESSOA u on u.NUM_USUAR = up.NUM_USUAR
	inner join pamais.V_CRP_PESSOA pe on pe.COD_DOCUM_PRI = u.COD_DOCUM_PES
	inner join maas.TMAAS_USUARIO_AUTENTICACAO ua on ua.NUM_USUAR = u.NUM_USUAR
	left join pamais.TCRP_VISAO_SISTEMA_USUARIO vsu on lower(vsu.COD_USUAR) = lower(ua.COD_AUTEN_USU)
	left join pamais.TCRP_VISAO_SISTEMA vs on vs.CTL_VISAO_SIS = vsu.CTL_VISAO_SIS
	left join pamais.TCRP_TIPO_VISAO tp on tp.TIP_VISAO = vs.TIP_VISAO
	left join pamais.TCRP_PESSOA p1 on p1.CTL_PESSO = vsu.VLR_CHAVE
where p.NUM_SISTE = 1021
and up.STA_ATIVO = 'S'
and vsu.DHR_FIM_VIG is null
and vs.TIP_VISAO is NULL

SELECT * FROM PAMAIS.CRP_USUARIO 
WHERE ctl_usuar = 5148
5558

/*PERFIS DO BILHETAGEM*/
SELECT a.num_siste
	  ,a.nom_siste
	  ,a.des_pagin_url
	  ,a.des_local_vtr
	  ,b.num_perfi
	  ,b.nom_perfi
	  ,b.sta_ativo
FROM MAAS.TMAAS_SISTEMA a 
,MAAS.TMAAS_PERFIL b 
WHERE a.num_siste = b.num_siste
AND b.num_siste = 1021


select * from maas.TMAAS_USUARIO_PESSOA tup  
where COD_DOCUM_PES = '13781200191'

select * from maas.TMAAS_USUARIO_PERFIL
where NUM_USUAR = 5558 
13129 -- Jenifer


SELECT * FROM MAAS.TMAAS_PRODUTO_SISTEMA MPS, MAAS.TMAAS_SISTEMA MS 
WHERE MS.NUM_SISTE = MPS.NUM_SISTE  
AND MPS.NUM_PRODT = 1001
AND MPS.NUM_SISTE = 1047

SELECT * FROM MAAS.TMAAS_USUARIO tu 
WHERE tup.

select * from maas.TMAAS_PERFIL tp 
where NUM_PERFI in (49
,84
,90
,94
,108
,159
,215)
