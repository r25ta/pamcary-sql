/*LISTAR ENTIDADES DE UMA OPERAÇÃO*/
select dv1.cod_docum as CNPJ_OPERACAO,
      FC_VINCULADO_NOME(rv.ctl_vincd,1) AS OPERAÇÃO,
      dv.cod_docum AS CNPJ_ENTIDADE, 
      td.des_tipo_doc AS TIPO_DOCUMENTO,
      FC_VINCULADO_NOME(rv.ctl_vincd_rld,1) AS NOM_GUERRA_ENTIDADE,
      FC_VINCULADO_NOME(rv.ctl_vincd_rld,0) AS RAZAO_SOCIAL,
      rvc.cod_clien_ext AS COD_EXTERNO,
      tr.des_relac AS TIPO_RELACIONAMENTO
from relacionamento_vinculado rv,
      doc_vinculado dv,
      doc_vinculado dv1,
      ref_vinculado_cliente rvc,
      tipo_relacionamento tr,
      tipo_documento td
where 
  dv.ctl_vincd = rv.ctl_vincd_rld
and
  dv1.ctl_vincd = rv.ctl_vincd
and
 rvc.ctl_vincd = rv.ctl_vincd
and 
  rvc.ctl_vincd_rld = rv.ctl_vincd_rld
and
  tr.tip_relac = rv.tip_relac
and
  dv.tip_docum = td.tip_docum
and  
  rv.ctl_vincd = 443654