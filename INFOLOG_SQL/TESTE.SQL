select * from vinculado where nom_guerr LIKE 'PAMCARY LGR%'
select * from TIPO_OPERACAO where DES_OPERA_TIP LIKE 'INFOLOG%'
SELECT * FROM RELACIONAMENTO_VINCULADO WHERE CTL_VINCD = 108762

SELECT * FROM USUARIO_INTERNET WHERE CTL_VINCD = 108762

select * from DOC_vinculado where CTL_VINCD = 108762
UPDATE DOC_VINCULADO SET cod_DOCUM = '003085759000706' WHERE CTL_VINCD = 108762

PAMCARY LGR/BARUERI/SP = 001000786000100

select * from plano_viagem where ctl_plvia = 678053
update plano_viagem set num_pcard = '0251481024' where ctl_plvia = 678053

select * from roteiro_motorista where ctl_plvia = 678053

select * from veiculo where num_placa = 'CBM7271'
update veiculo set num_placa = 'CQM5738' where ctl_veicu = 82879
update roteiro_motorista set ctl_ptopd = 61649 where ctl_rtmot = 2969557

SELECT fc_vinculado_documento(ctl_remet,1) AS cnpj_remet FROM plano_viagem WHERE ctl_plvia = 678053

select * from TIPO_PARADA where ctl_parad in (13,17,18)

