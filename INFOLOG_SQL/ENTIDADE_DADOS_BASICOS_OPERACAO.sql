/*
QUERY PARA RETORNAR OS DADOS BASICOS DAS ENTIDADES CADASTRADAS NA OPERAÇÃO
*/    
select
        --tr.des_relac,
       --fc_vinculado_nom_guerr(rv.ctl_vincd) as operacao, 
       distinct fc_vinculado_nom_guerr(rv.ctl_vincd_rld) as entidade,
       fc_vinculado_documento(rv.ctl_vincd_rld,1) as cnpj,
       fc_vinculado_documento(rv.ctl_vincd_rld,2) as cpf,
       (select cod_clien_ext from ref_vinculado_cliente where ctl_vincd = rv.ctl_vincd and ctl_vincd_rld=rv.ctl_vincd_rld) as cod_externo,
       fc_vinculado_endereco_pais(rv.ctl_vincd_rld,1) as pais,
       fc_vinculado_endereco_siglauf(rv.ctl_vincd_rld,1) as uf,
       fc_vinculado_endereco_praca(rv.ctl_vincd_rld,1) as cidade,
       (select des_bairr_end from endereco_vinculado where ctl_vincd = rv.ctl_vincd_rld) as bairro,
       (select des_ender from endereco_vinculado where ctl_vincd = rv.ctl_vincd_rld) as des_ender,       
       (select des_numer_end from endereco_vinculado where ctl_vincd = rv.ctl_vincd_rld) as numero,
       (select cod_cep_end from endereco_vinculado where ctl_vincd = rv.ctl_vincd_rld) as cep,
       (select num_latit from endereco_vinculado where ctl_vincd = rv.ctl_vincd_rld) as latit,
       (select num_longi from endereco_vinculado where ctl_vincd = rv.ctl_vincd_rld) as longi

from 
    relacionamento_vinculado rv
    --, tipo_relacionamento tr
where rv.ctl_vincd = 50720
and rv.tip_relac <> 4
--and tr.tip_relac = rv.tip_relac
order by entidade
