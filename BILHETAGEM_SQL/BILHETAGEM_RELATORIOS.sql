select * from dbprod.tdownload_arquivo
where nom_arqui = 'avi202112-MENSAL_07000230784_rctrc_1005400010251.pdf'

avi202112-MENSAL_07000230784_rctrc_1005400010251.pdf
avi202111-MENSAL_07000226916_rcfdc_1005500005288.pdf
'avi202112-MENSAL_07000230012_rcfdc_1005500005288.pdf'
avi202112-MENSAL_07000230230_rctamb_3836900253254.pdf
avi202112-MENSAL_07000230229_rctamb_3836900163254.pdf
emb202112-MENSAL_07000229311_tramb_3836002378921.pdf
avi202112-MENSAL_07000229311_tramb_3836002378921.pdf
emb202112-MENSAL_07000229949_rctrc_3836900165354.pdf
avi202112-MENSAL_07000229949_rctrc_3836900165354.pdf
emb202112-MENSAL_07000230228_rctamb_3836900162354.pdf
avi202112-MENSAL_07000230228_rctamb_3836900162354.pdf
emb202112-MENSAL_07000230237_rctamb_3836900165554.pdf
avi202112-MENSAL_07000230237_rctamb_3836900165554.pdf
emb202112-MENSAL_07000230242_rctamb_3836900221554.pdf
avi202112-MENSAL_07000230242_rctamb_3836900221554.pdf
emb202112-MENSAL_07000230241_rctamb_3836900217054.pdf
avi202112-MENSAL_07000230241_rctamb_3836900217054.pdf
emb202112-MENSAL_07000229749_rctrc_3836900175854.pdf
avi202112-MENSAL_07000229749_rctrc_3836900175854.pdf
emb202112-MENSAL_07000229831_rcfdc_3836002113855.pdf
avi202112-MENSAL_07000229831_rcfdc_3836002113855.pdf
emb202112-MENSAL_07000229961_rctrc_3836900253654.pdf




INSERT INTO DBPROD.TDOWNLOAD_ARQUIVO(NUM_ARQUI, NUM_CATEG_ARQ, NOM_ARQUI, CTL_VINCD, COD_USER, DHR_ALTER, STA_EMAIL_SED, STA_EMAIL_FIL, STA_EMAIL_PAR, NUM_FILIA, CTL_CORRE, NUM_ASCOM)VALUES((SELECT MAX(NUM_ARQUI) + 1 FROM DBPROD.TDOWNLOAD_ARQUIVO),1,'emb202112-MENSAL_07000230012_rcfdc_1005500005288.pdf',(SELECT DISTINCT V.CTL_VINCD from DBPROD.TDOC_VINCULADO V INNER JOIN BILHET.V_BIL_PROPOSTA P ON P.COD_DOCUM_CLI = V.COD_DOCUM INNER JOIN BILHET.TBIL_FATURA F ON F.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS WHERE F.SEQ_NUMER_FAT = 7000230012 AND V.DHR_ALTER = (SELECT MAX(DHR_ALTER) FROM DBPROD.TDOC_VINCULADO DOCV WHERE DOCV.COD_DOCUM = V.COD_DOCUM) ),'Bilhetagem', CURRENT TIMESTAMP,'S','S','S', (SELECT DISTINCT P.FILIAL_ADM as NUM_FILIA    FROM BILHET.V_BIL_PROPOSTA P INNER JOIN BILHET.TBIL_FATURA F ON F.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS WHERE F.SEQ_NUMER_FAT = 7000230012),(SELECT DISTINCT P.NUM_CORRE_PAM as CTL_CORRE FROM BILHET.V_BIL_PROPOSTA P INNER JOIN BILHET.TBIL_FATURA F ON F.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS WHERE F.SEQ_NUMER_FAT = 7000230012),(SELECT DISTINCT P.CTL_PRODR as NUM_ASCOM     FROM BILHET.V_BIL_PROPOSTA P INNER JOIN BILHET.TBIL_FATURA F ON F.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS WHERE F.SEQ_NUMER_FAT = 7000230012))

select * from plano_viagem
where ctl_opera_tip = 20


SELECT * FROM PAMAIS.V_CRP_PRODUTO_SISTEMA

SELECT * FROM PAMAIS.v_crp_pessoa_produto
WHERE NOM_PESSO_USU LIKE '%CLEVERSON%'

COD_DOCUM_USU = '37337413823'

CTL_PESSO_USU = 15493



select CTL_PESSO_USU
        , CTL_PESSO
        , COD_DOCUM_PRI
        , NUM_PRODT
        , COD_DOCUM_USU
        , NOM_PESSO_USU  
 from pamais.v_crp_pessoa_produto_usuario  
 where  COD_DOCUM_USU = 


select * from pamais.


select * from tevento_gerenciadora_risco


SELECT * FROM PAMAIS.V_CRP_USUARIO
WHERE NOM_USUAR LIKE '%CLEVERSON%'















select distinct b.ctl_usuar,b.nom_usuar,e.cod_docum_emp,b.COD_USUAR ")
				.append("from MAAS.TMAAS_USUARIO_PESSOA A ")
				.append("inner join CRP_USUARIO B on b.cod_docum_usu = a.cod_docum_pes ")
				.append("inner join MAAS.TMAAS_USUARIO_PERFIL c on c.num_usuar = a.num_usuar ")
				.append("inner join MAAS.TMAAS_USUARIO_EMPRESA_ALOCA e on e.num_usuar = a.num_usuar ")
				.append("inner join CRP_PESSOA G on g.cod_docum_pri= e.cod_docum_emp ")
				.append("left join CRP_FILIAL_PAMCARY f on f.ctl_filia_pam = g.ctl_pesso ")
				.append("inner join MAAS.TMAAS_PERFIL d on c.num_perfi = d.num_perfi and d.num_siste in 


"select b.nom_pesso,b.cod_docum_pri, a.*,C.CTL_FILIA_PAM from V_CRP_PARAM_CLIENTE_SISTEMA a ")
				.append("INNER JOIN CRP_PESSOA B ON (A.CTL_PESSO = B.CTL_PESSO) ")
				.append("LEFT JOIN CRP_FILIAL_PAMCARY C ON (A.CTL_PESSO= C.CTL_FILIA_PAM) ")
				.append("where a.num_siste='1016' ")
				.append("and a.sta_princ='S' and a.ctl_pesso = b.ctl_pesso and a.sta_ativo='S' ");
		if (!"".equals(cnpj)) {
			sql.append("and b.cod_docum_pri in (")
					.append("SELECT PES.COD_DOCUM_PRI FROM CRP_PESSOA PES ")
					.append("INNER JOIN V_CRP_PARAM_CLIENTE_SISTEMA C ON C.CTL_PESSO = PES.CTL_PESSO AND C.NUM_SISTE=1016 ")
					.append("WHERE NUM_PARAM_CLI IN ")
					.append("(SELECT NUM_PARAM_PAI FROM CRP_PESSOA PES ")
					.append("INNER JOIN V_CRP_PARAM_CLIENTE_SISTEMA C ON C.CTL_PESSO = PES.CTL_PESSO  AND C.NUM_SISTE=1016 ")
					.append("WHERE PES.COD_DOCUM_PRI='").append(cnpj)
					.append("'))");






select b.nom_pesso,b.cod_docum_pri, a.*,C.CTL_FILIA_PAM 
from pamais.V_CRP_PARAM_CLIENTE_SISTEMA a 
INNER JOIN pamais.CRP_PESSOA B ON (A.CTL_PESSO = B.CTL_PESSO) 
LEFT JOIN pamais.CRP_FILIAL_PAMCARY C ON (A.CTL_PESSO= C.CTL_FILIA_PAM) 
where a.num_siste='1016' 
        and a.sta_princ='S' 
        and a.ctl_pesso = b.ctl_pesso 
        and a.sta_ativo='S' 
	and b.cod_docum_pri in (
				SELECT PES.COD_DOCUM_PRI FROM pamais.CRP_PESSOA PES 
				INNER JOIN pamais.V_CRP_PARAM_CLIENTE_SISTEMA C 
				    ON C.CTL_PESSO = PES.CTL_PESSO 
				    AND C.NUM_SISTE=1016 
				WHERE NUM_PARAM_CLI IN 
				    (SELECT NUM_PARAM_PAI FROM pamais.CRP_PESSOA PES  
				            INNER JOIN pamais.V_CRP_PARAM_CLIENTE_SISTEMA C 
				            ON C.CTL_PESSO = PES.CTL_PESSO  
				            AND C.NUM_SISTE=1016 
				WHERE PES.nom_pesso LIKE '%A%'))
				
select b.nom_pesso,b.cod_docum_pri, a.*,C.CTL_FILIA_PAM 
from pamais.V_CRP_PARAM_CLIENTE_SISTEMA a 
INNER JOIN pamais.CRP_PESSOA B ON (A.CTL_PESSO = B.CTL_PESSO) 
LEFT JOIN pamais.CRP_FILIAL_PAMCARY C ON (A.CTL_PESSO= C.CTL_FILIA_PAM) 
				where a.num_siste='1047' 
				and a.sta_princ='S' and a.ctl_pesso = b.ctl_pesso and a.sta_ativo='S' 
				and b.cod_docum_pri in (
				SELECT PES.COD_DOCUM_PRI FROM pamais.CRP_PESSOA PES 
				INNER JOIN pamais.V_CRP_PARAM_CLIENTE_SISTEMA C ON C.CTL_PESSO = PES.CTL_PESSO AND C.NUM_SISTE=1016 
				WHERE NUM_PARAM_CLI IN 
				(SELECT NUM_PARAM_PAI FROM pamais.CRP_PESSOA PES 
				INNER JOIN pamais.V_CRP_PARAM_CLIENTE_SISTEMA C ON C.CTL_PESSO = PES.CTL_PESSO  AND C.NUM_SISTE=1016 
				WHERE PES.nom_pesso LIKE '%A%'))



select a.CTL_PESSO_USU
, a.CTL_PESSO
, a.COD_DOCUM_PRI
, a.NUM_PRODT
, a.COD_DOCUM_USU
, a.NOM_PESSO_USU  
from pamais.v_crp_pessoa_produto_usuario a
,pamais.tcrp_produto_sistema b
where a.num_prodt = b.num_prodt
and a.num_prodt = 1002
and b.num_siste = 1047

select * from pamais.V_CRP_PARAM_CLIENTE_SISTEMA bselect * from pamais.v_crp_pessoa_produto_usuario a

select * from pamais.tcrp_produto_sistema
where num_siste = 1047

SELECT * FROM PAMAIS.TCRP_RELAC_ITEM_CATEG_PRODT
WHERE NUM_PRODT = 1002

select * from maas.tmaas_produto_sistema
where num_siste = 1047

select * from maas.tmaas_tipo_servico_sistema
where 

select * from  pamais.crp_pessoa
where cod_docum_pri = '00275841000101'

--order by cod_usuar 
where cod_usuar like '%%'

