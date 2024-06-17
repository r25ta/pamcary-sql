SELECT * FROM PROVEDOR_TECNOLOGIA


UPDATE PROVEDOR_TECNOLOGIA SET
COD_DOCUM = '05046417000109',
DES_PROVE_TEC ='CONTROLLOC'
WHERE CTL_PROVE_TEC = 13


SELECT * FROM SUB_SERVICO_SISTEMA
ORDER BY CTL_SERVI


insert into sub_servico_sistema (ctl_servi_sub,ctl_servi,des_servi_sub,dhr_ultim_pro,dhr_toler,cod_user,dhr_alter,des_respo)
                          values(sq_ctl_servi_sub.nextval,81,'Aplicacao Client Transponder',sysdate,to_date('20060424010001','yyyymmddhh24miss'),'RESTAURAJAVA',SYSDATE,'PAMSIST')


select * from usuario_internet
where usr_name like 'PAMCARY%'

SELECT * FROM VEICULO
WHERE NUM_MCT = '1111111'


UPDATE VEICULO SET 
NUM_MCT = NULL
WHERE CTL_VEICU = 86841

select fc_vinculado_nom_guerr(ctl_ptopd), TO_CHAR(DHR_EFETI_REA,'DD/MM/YYYY HH24:MI:SS'),
    to_char(dhr_previ_sis,'DD/MM/YYYY HH24:MI:SS'), r.* from roteiro_motorista r
where ctl_plvia = 857656
order by num_seque

SELECT * FROM PLANO_VIAGEM
where ctl_plvia = 857656

SELECT * FROM DESTINATARIO_PLANO_VIAGEM
where ctl_plvia = 857656

select * from endereco_vinculado
where ctl_vincd = 78510

149593 - valinhos - 225756 , 465945
78510 - perus    - 233045, 464250

SELECT PEO.ctl_vincd, PEO.ctl_desti, PEO.ctl_remet,  TPC.tip_prazo_cli, TPC.des_prazo_cli, TPT.tip_prazo_tmp, TPT.des_prazo_tmp, PEO.num_prazo, PEO.qtd_klm  FROM PRAZO_ENTREGA_ORIGEM PEO, TIPO_PRAZO_CLIENTE TPC, TIPO_PRAZO_TEMPO TPT  WHERE PEO.ctl_vincd =50720 AND PEO.ctl_desti =149593 AND PEO.ctl_remet =78510 AND TPC.tip_prazo_cli = 4 AND TPC.tip_prazo_cli = PEO.tip_prazo_cli  AND TPT.tip_prazo_tmp = PEO.tip_prazo_tmp 


SELECT * FROM PLANO_VIAGEM
where sit_plvia = 0


