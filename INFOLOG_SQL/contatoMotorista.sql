SELECT DISTINCT V.NUM_PLACA,
       FC_VINCULADO_NOME(CTL_MOTOT,1) AS NOME_MOTORISTA,
       CV.tip_comun,
       CV.des_comun_vin,
       TV.DES_VEICU_TIP,
       GV.DES_GENER,
       MV.DES_MARCA,
       MOV.DES_MODEL,
       V.DES_VEICU_COR,
       V.ANO_VEICU,
       V.NUM_RENAV
FROM PLANO_VIAGEM PV, VEICULO_PLANO_VIAGEM VPV, VEICULO V, MARCA_VEICULO MV, MODELO_VEICULO MOV, 
           TIPO_VEICULO TV, GENERO_VEICULO GV, COMUNICACAO_VINCULADO CV
WHERE PV.CTL_PLVIA = VPV.CTL_PLVIA
  AND VPV.CTL_VEICU = V.CTL_VEICU
  AND V.CTL_MODEL = MOV.CTL_MODEL
  AND MOV.CTL_MARCA = MV.CTL_MARCA
  AND MOV.CTL_GENER = GV.CTL_GENER
  AND TV.ctl_veicu_tip = GV.ctl_veicu_tip
  AND PV.CTL_MOTOT = CV.ctl_vincd
  AND PV.TIP_MOTOT IN (2,3)
  AND PV.SIT_PLVIA <> 10



SELECT * FROM modelo_VEICULO


select * from vinculado
where nom_guerr like '%LOBO%'

select * from comunicacao_vinculado
where ctl_vincd = 20007
      
select PV.ctl_plvia,
       CC.tip_comun,
       CC.des_comun
from plano_viagem PV, comunicacao_contato CC
where PV.ctl_motot = CC.ctl_vincd(+)
and PV.sit_plvia <> 10

  
select * from modelo_veiculo
