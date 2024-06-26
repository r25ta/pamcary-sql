
/*USU�RIOS ATIVOS NO SISTEMA PAMCARGA*/
select distinct ua.COD_AUTEN_USU as USU�RIO, pe.COD_dOcUM_pri AS DOCUMENTO, pe.NOM_PESSO as NOME, e.COD_EMAIL_USU,
uea.TIP_DOCUM_EMP, uea.COD_DOCUM_PES, (SELECT nom_pesso FROM pamais.tcrp_pessoa WHERE tip_docum_pri = uea.tip_docum_emp AND cod_docum_pri = uea.cod_docum_emp)
, uea.cod_docum_emp
from maas.TMAAS_SISTEMA s
	inner join maas.TMAAS_PERFIL p on p.NUM_SISTE = s.NUM_SISTE
	inner join maas.TMAAS_USUARIO_PERFIL up on up.NUM_PERFI = p.NUM_PERFI
	inner join maas.TMAAS_USUARIO_PESSOA u on u.NUM_USUAR = up.NUM_USUAR
	inner join pamais.TCRP_PESSOA pe on pe.COD_DOCUM_PRI = u.COD_DOCUM_PES
	inner join maas.TMAAS_USUARIO_AUTENTICACAO ua on ua.NUM_USUAR = u.NUM_USUAR
	INNER JOIN maas.TMAAS_USUARIO_EMAIL e ON e.NUM_USUAR = u.NUM_USUAR
	INNER JOIN maas.tmaas_usuario_empresa_aloca uea ON uea.NUM_USUAR = u.NUM_USUAR 
where p.NUM_SISTE = 1047--1021
and up.STA_ATIVO = 'S'
ORDER BY NOME



--DESATIVAR USU�RIO DO SISTEMA PAMCARGA
UPDATE maas.TMAAS_USUARIO_PERFIL SET 
STA_ATIVO = 'N'
, idt_statu = 'C'
--SELECT * FROM maas.TMAAS_USUARIO_PERFIL
WHERE NUM_PERFI IN (136,137,138,139,141,142,144)
AND STA_ATIVO = 'S'
AND NUM_USUAR IN ( SELECT NUM_USUAR  FROM maas.TMAAS_USUARIO_PESSOA tup  
WHERE COD_DOCUM_PES IN ('13910185754') )

COMMIT 
