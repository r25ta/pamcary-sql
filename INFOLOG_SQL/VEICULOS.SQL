SELECT V.ctl_veicu,
       V.num_placa,
       TV.ctl_veicu_tip,
       NVL(TV.des_veicu_tip, ' ') AS des_veicu_tip,
       NVL(V.des_veicu_cor,' ') AS des_veicu_cor,
       NVL(V.ano_veicu,' ') AS ano_veicu,
       NVL(V.des_frota,' ') AS des_frota,
       NVL(V.cod_chass,' ') AS cod_chass,
       NVL(V.des_praca,' ') AS des_praca,
       NVL(V.num_mct,0) AS num_mct,
       NVL(V.sit_veicu,0) AS sit_veicu,
       NVL(V.qtd_eixo,0) AS qtd_eixo,
       NVL(V.ton_bruto,0) AS ton_bruto,
       NVL(V.num_renav,0) AS num_renav,
       NVL(GV.des_gener,' ') AS des_gener,
       NVL(MV.des_model,' ') AS des_model,
       NVL(MA.des_marca,' ') AS des_marca,
       NVL(UF.sig_unfed,' ') AS sig_unfed,
       NVL(UF.nom_unfed,' ') AS nom_unfed
FROM VEICULO V, GENERO_VEICULO GV, MODELO_VEICULO MV, MARCA_VEICULO MA, PRACA P, UNIDADE_FEDERAL UF, TIPO_VEICULO TV
WHERE /*V.num_placa = 'YVO0002'
AND */MV.ctl_model = V.ctl_model
AND MV.ctl_gener = GV.ctl_gener
AND TV.ctl_veicu_tip = GV.ctl_veicu_tip
AND MA.ctl_marca = MV.ctl_marca
AND P.cod_praca = V.cod_praca
AND UF.cod_unfed = P.cod_unfed
