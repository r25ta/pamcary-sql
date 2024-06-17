select t.ctl_opera_tip as cod_operacao
      ,t.des_opera_tip as nome_operacao
      ,fc_vinculado_nom_guerr(t.ctl_vincd_emb) as nome_guerra
      ,dv.cod_docum as cnpj
      ,t.sta_ativo
from tipo_operacao t, doc_vinculado dv
where t.ctl_vincd_emb = dv.ctl_vincd
