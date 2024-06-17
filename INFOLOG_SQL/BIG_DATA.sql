select distinct nom_trnsp  from evento_gerenciadora_risco
where nom_trnsp is not null


select * from monitora_plano_viagem


select * from tipo_area_risco
select tar.des_area_ris as DESCRICAO, 
        ar.des_refer as REFERENCIA, 
        ar.num_latit_ref as LATITUDE, 
        ar.num_longi_ref as LONGITUDE
        
from refer_local_area_risco ar, 
      tipo_area_risco tar
where ar.tip_area_ris = tar.tip_area_ris



select * from inf_rota
SELECT * FROM ENDERECO_VINCULADO
SELECT * FROM PRACA
SELECT * FROM UNIDADE_FEDERAL

select t.des_opera_tip AS CLIENTE,
        rt.nom_rota AS ROTA, 
       FC_VINCULADO_NOM_GUERR(rt.ctl_vincd_ori) as ORIGEM,
      
        (SELECT DES_PRACA 
          FROM PRACA 
          WHERE COD_PRACA IN(SELECT COD_PRACA 
                              FROM ENDERECO_VINCULADO 
                              WHERE CTL_VINCD = rt.ctl_vincd_ori) ) AS PRACA_ORIGEM,
          
        (SELECT SIG_UNFED 
          FROM UNIDADE_FEDERAL 
          WHERE COD_UNFED IN (SELECT COD_UNFED 
                                FROM PRACA 
                                WHERE COD_PRACA IN (SELECT COD_PRACA 
                                                    FROM ENDERECO_VINCULADO 
                                                    WHERE CTL_VINCD = rt.ctl_vincd_ori) ) ) AS UF_ORIGEM,
          
       FC_VINCULADO_NOM_GUERR(rt.ctl_vincd_des) as DESTINO, 
        
        (SELECT DES_PRACA 
          FROM PRACA 
          WHERE COD_PRACA IN(SELECT COD_PRACA 
                              FROM ENDERECO_VINCULADO 
                              WHERE CTL_VINCD = rt.ctl_vincd_des) ) AS PRACA_DESTINO,

        (SELECT SIG_UNFED 
          FROM UNIDADE_FEDERAL 
          WHERE COD_UNFED IN (SELECT COD_UNFED 
                                FROM PRACA 
                                WHERE COD_PRACA IN (SELECT COD_PRACA 
                                                    FROM ENDERECO_VINCULADO 
                                                    WHERE CTL_VINCD = rt.ctl_vincd_des) ) ) AS UF_DESTINO,
       
       rt.qtd_metro_dti AS KM_TOTAL,       
       rr.num_ordem_ref AS ORDEM, 
       rr.des_refer AS REFERENCIA, 
       rr.num_latit AS NUM_LATIT, 
       rr.num_longi AS NUM_LONGI
from inf_rota_referencia rr, 
     inf_rota rt,
     tipo_operacao t
where rt.ctl_rota_gri = rr.ctl_rota_gri
and t.ctl_opera_tip = rt.ctl_opera_tip
and rt.sta_ativo = 'S'
order by rr.ctl_rota_gri, rr.num_ordem_ref


select * from  vinculado

select distinct fc_vinculado_nom_guerr(ctl_vincd_rld) transportadoras_infolog 
from relacionamento_vinculado r, vinculado v
where tip_relac = 2
and v.ctl_vincd = r.ctl_vincd_rld
and cod_ativi = 8
