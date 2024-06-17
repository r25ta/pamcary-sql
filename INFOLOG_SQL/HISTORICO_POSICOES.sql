select cod_placa, num_renav, fc_praca_nom_praca(v.ctl_local), V.* 
from v_crp_veiculo V
where ctl_veicu = 348264



select * from inf_veicu_plano_viagem
where ctl_plvia = 9439552

select * from praca
where cod_praca = 1808

SELECT FC_PRACA_NOM_PRACA(1556) FROM DUAL
select * from plano_viagem
select NVL(num_renav,0) AS renavam from v_crp_veiculo v 
  where EXISTS ( select ctl_veicu from inf_veicu_plano_viagem where ctl_veicu = v.ctl_veicu and ctl_plvia = 9439552 )

SELECT v.ctl_local
                          FROM v_crp_veiculo v, inf_veicu_plano_viagem vpv
                          WHERE v.ctl_veicu = vpv.ctl_veicu 
                          AND v.num_categ_vei <> 3
                          AND ctl_plvia = 9439552 
                          
                          
SELECT pr.cod_unfed
                          FROM praca pr, v_crp_veiculo v, inf_veicu_plano_viagem vpv
                          WHERE v.ctl_veicu = vpv.ctl_veicu 
                          AND pr.cod_praca = v.ctl_local
                          AND v.num_categ_vei <> 3
                          AND ctl_plvia = 9439552                         
9439552            

select * from endereco_vinculado

select * from plano_viagem
select * from praca
SELECT * FROM RECON_TELER_VINCD_PLVIA
ORDER BY DHR_ALTER DESC 
select * from destinatario_plano_viagem
SELECT * FROM INF_MOTORISTA_PLANO_VIAGEM

select * from inf_relac_merca_grpno_plvia

SELECT * FROM V_CRP_VEICULO
WHERE COD_PLACA= 'FGC2572'

select * from tipo_operacao



SELECT doc.cod_docum 
FROM inf_veicu_propr_motot iv, 
     v_crp_veiculo v, 
     inf_veicu_plano_viagem vpv,
     doc_vinculado doc
WHERE v.num_categ_vei <> 3
  AND iv.ctl_veicu = v.ctl_veicu
  AND vpv.ctl_veicu = v.ctl_veicu
  AND iv.ctl_motot = doc.ctl_vincd
  AND vpv.ctl_plvia = 9439552


select * from inf_veicu_propr_motot
order by dhr_alter desc

select * from inf_veicu_propr_vincd
order by dhr_alter desc







Placa
ID
Tecnologia
Data do evento
Latitude
Longitude
Referencia
Tipo de evento (posição  ou macro)
Evento (só quando for macro = CH, FV, ND).

select mpv.ctl_plvia, mpv.num_placa AS PLACA
       ,mpv.num_termn AS ID
       ,(SELECT nom_fants FROM v_crp_provedor_tecnologia WHERE ctl_prove_ten = mpv.ctl_prove_ten ) AS TECNOLOGIA
       ,to_char(mpv.dhr_event,'DD/MM/YYYY HH24:MI:SS') AS DHR_EVENT
       ,mpv.num_latit AS LATITUDE
       ,mpv.num_longi AS LONGITUDE
       ,mpv.des_event AS REFERENCIA

       , CASE tip_event_ter
            WHEN 99 
              THEN 'POSIÇÃO'
              
            ELSE 'MACRO'
            
          END AS TIPO_EVENTO

       ,(SELECT sig_event_ter FROM TIPO_EVENTO_TERMINAL WHERE tip_event_ter = mpv.tip_event_ter) AS EVENTO
from TEXP_monitora_plano_viagem mpv
where ctl_plvia in ( 

9204129
,9204171
,9209815
,9229856
,9236367
,9243097
,9265160
,9281647
,9303461
,9334062
,9331248
,9342486
,9347152
,9344744
,9350151
,9407681
,9511314
)


