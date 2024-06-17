SELECT * FROM vinculado
WHERE CTL_VINCD = 351723

SELECT * FROM doc_vinculado
WHERE CTL_VINCD = 108762

SELECT * FROM atividade

SELECT * FROM endereco_vinculado
WHERE CTL_VINCD = 108762

SELECT * FROM unidade_federal
SELECT * FROM praca

SELECT * FROM tipo_operacao
WHERE CTL_VINCD_EMB = 351723

SELECT * FROM USUARIO_INTERNET
WHERE usr_name like 'RONALDO.ACCORD'

CTL_VINCD = 108762

SELECT * FROM senha_usuario_internet


select 


SELECT * FROM FUNCOES_SISTEMA
WHERE COD_SISTI = 3

SELECT * FROM RELAC_PERFIL_USUARIO
WHERE CTL_USER = 24405

SELECT * FROM relacionamento_vinculado
WHERE ctl_vincd = 351723

SELECT * FROM log_senha_demo
PR_PARAMETRIZACAO_INFOLOG

SELECT * FROM REF_VINCULADO_CLIENTE
WHERE CTL_VINCD = 108762


SELECT distinct fc_vinculado_nome(rv.ctl_vincd_rld,1) AS nom_guerr, rv.ctl_vincd_rld,
  NVL(dv.cod_docum,'0') AS cnpj, dv.tip_docum,
  fc_vinculado_endereco_praca(rv.ctl_vincd_rld,1) AS praca,
  fc_vinculado_endereco_siglauf(rv.ctl_vincd_rld,1) AS uf,
  fc_vinculado_endereco_pais(rv.ctl_vincd_rld,1) AS pais, 
  NVL(rvc.cod_clien_ext,' ') AS cod_clien_ext
FROM relacionamento_vinculado rv, 
  doc_vinculado dv, 
  ref_vinculado_cliente rvc
WHERE rv.ctl_vincd = 108762
     AND rv.ctl_vincd_rld = dv.ctl_vincd
     AND rv.ctl_vincd_rld = rvc.ctl_vincd_rld(+)
     AND rv.ctl_vincd = rvc.ctl_vincd(+)
	   AND rv.tip_relac <> 4