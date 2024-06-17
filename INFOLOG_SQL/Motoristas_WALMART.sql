select pv.ctl_plvia AS viagem,
       mot.cod_docum_mot AS CPF,
       mot.nom_motorista AS MOTORISTA,
       vmot.nom_tipo_vic AS PERFIL,
       dv.cod_docum AS CNPJ,
       fc_vinculado_nom_guerr(pv.CTL_TRNSP) AS TRANSPORTADORA,
       fc_vinculado_nom_guerr(pv.ctl_remet) AS ORIGEM,
       to_char(dhr_inclu,'DD/MM/YYYY HH24:MI:SS') AS INCLUSÃO,
       to_char(dhr_atvie_pln,'DD/MM/YYYY HH24:MI:SS') AS ATIVACAO
FROM plano_viagem pv,
     v_crp_motorista mot,
     inf_motorista_plano_viagem mp,
     doc_vinculado dv,
     v_crp_tipo_vinculo_motorista vmot
     
WHERE pv.ctl_plvia = mp.ctl_plvia
AND mp.ctl_motot = mot.ctl_motot
AND pv.ctl_trnsp = dv.CTL_VINCD
AND vmot.tip_vincu_mot = mp.tip_vincu_mot
AND pv.DHR_INCLU between to_date('20180801000001','YYYYMMDDHH24MISS') and to_date('20180831235959','YYYYMMDDHH24MISS')
AND pv.sit_plvia <> 10
and pv.ctl_opera_tip = 237






SELECT * FROM PAMAIS_PRD.
select * from tipo_operacao

select * from inf_motorista_plano_viagem
where TIP_VINCU_MOT IS NULL
ctl_plvia = 8412462

select * from v_crp_tipo_vinculo_motorista
select fc_vinculado_nom_guerr(398286) from dual

SELECT * FROM VINCULADO
WHERE NOM_GUERR LIKE '%CONCEPCION%'


select * from PAMAIS_PRD.tcrp_tipo_vincu_motoT_IDIOMA

SELECT * FROM DOC_VINCULADO
WHERE CTL_VINCD = 1053814


select * from v_crp_motorista

select * from doc_vinculado
where ctl_vincd = 398286

select * from plano_viagem


NOME DO MOTORISTA
CPF
TRANSPORTADORA
perfil (Frota/AGREGADO/autônomo )
NUMERO DO PLANO
Origem
data/hora de inclusão
ativação do plano
(período 01/01/2018 até o presente momento) 



select * from usuario_internet 
where usr_name like '%JAME%'


SELECT * FROM VINCULADO
WHERE NOM_GUERR LIKE '%JAMEF%'


SELECT COD_DOCUM, FC_VINCULADO_NOM_GUERR(CTL_VINCD) FROM DOC_VINCULADO
WHERE CTL_VINCD IN (341140,683782,994175,1060859,1167141)
