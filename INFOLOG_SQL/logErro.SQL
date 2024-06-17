select * from crp_tipo_processamento

select * from sistemas

select * from crp_controle_processamento

select * from crp_situacao_processamento

select * from crp_mensagem_processamento

select * from crp_mensagem



--sistemas
and cod_sisti = 7
--crp_tipo_processamento
and tip_procs = 1
--crp_situacao_processamento
and sit_resul_prt = 1
--crp_mensagem
and num_mensg_prt = 200

select SQ_CTRPRT_CTLPROCS.nextval from dual

INSERT INTO CRP_CONTROLE_PROCESSAMENTO 
(ctl_procs, tip_procs, nom_objet_pcd, dhr_inici_prt, dhr_fim_prt,sit_resul_prt,cod_user,dhr_alter)
VALUES ( SQ_CTRPRT_CTLPROCS.NEXTVAL,  1,' ', SYSDATE,SYSDATE,1,'COMUNICADOR'SYSDATE)

INSERT INTO CRP_MENSAGEM_PROCESSAMENTO(ctl_procs, num_mensg_prt, cod_mensg, tot_mensg_pcd, cod_user,dhr_alter)
VALUES ( ,200,' ',1,'COMUNICADOR',SYSDATE)
