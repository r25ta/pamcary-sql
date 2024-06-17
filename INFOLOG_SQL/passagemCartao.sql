SELECT CTL_PLVIA, NUM_PCARD, SIT_PLVIA, fc_vinculado_nom_guerr(ctl_remet) AS nom_remet,  TO_CHAR(DHR_INCLU,'DD/MM/YYYY HH24:MI:SS') AS DHR_INCLU, to_char(dhr_plvia_ini,'dd/mm/yyyy hh24:mi:ss'),
FC_DHR_INICIO_VIAGEM(CTL_PLVIA) AS DHR_INICI_REA FROM PLANO_VIAGEM
WHERE CTL_REMET = 35779
AND TO_CHAR(DHR_INCLU,'YYYYMMDD') BETWEEN '20040718' AND '20040722'
ORDER BY dhr_inclu desc

48983 - 016313363000702
56095 - 013558226001045
35779 - 016313363001512
35780

SELECT V.ctl_vincd, V.nom_guerr,
V.nom_vincd, DV.cod_docum
FROM VINCULADO V, DOC_VINCULADO DV
WHERE V.cod_ativi = 8
AND V.ctl_vincd = DV.ctl_vincd
AND DV.cod_docum = '025419227000105'

003469003000167
025419227000105


AND DV.cod_docum = '22677520000176'

select * from conta_rastreamento
where des_conta_rst like '%JPN%'

SELECT * FROM ROTEIRO_MOTORISTA
WHERE CTL_PLVIA = 701161

select * from plano_viagem
where num_pcard in ('0265720030')
order by ctl_plvia desc

select * from monitoramento_cartao
where num_pcard_seq = 43971
order by dhr_regis desc

select * from veiculo_plano_viagem
where num_mct = 766216
order by ctl_plvia desc

select * from plano_viagem
where ctl_plvia = 701196

select * from vinculado
where ctl_vincd = 35779

select * from veiculo
where num_placa = 'BYF2812'

SELECT * FROM ROTEIRO_MOTORISTA
WHERE CTL_PLVIA = 701196

select * from doc_vinculado
where cod_docum = '013545769000137'

select * from vinculado
where ctl_vincd in (47144,177512)


780559 29914  701951
791531 29913  n
735635 29909  n
196644 29910  n
766216 29912  n

016313363001512


select * from monitora_cartao
