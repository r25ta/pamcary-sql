/*
Schema: BILHET
	Procedure: SP_GERA_FATURA_MANUAL_24032016
	PARAMÊTROS: 
		ENTRADA: SEQ_NUMER_PRS (ID TABELA PROPOSTA)
			 CTL_PESSO_DIC (ID SEGURADO DIVISÃO)  OPCIONAL
			 FATURAMENTO ( 1- 1°QUINZENA, 2- 2° QUINZENA, 3- MENSAL)
			 COMPETENCIA (01/MM/YYYY)
		    	 VALOR (VALOR DA FATURA)
			 DIA_VENCTO (DIA DO VENCIMENTO)
			 USUÁRIO (USUÁRIO DE INCLUSÃO)
			 VALOR MERCADORIA
			 QTDE MERCADORIA

		SAÍDA: NÚMERO FATURA
       CÓD RETORNO
                      DESCRIÇÃO ERRO
*/
--EXEMPLO:
call bilhet.SP_GERA_FATURA_MANUAL_24032016(507504,NULL,3,'01/06/2023',199.97,26,'SIGS',0.0,1,?,?,?)

--exemplo cadastro pessoa
CALL PAMAIS.SP_CRP_INSERE_PESSOA('AGENOR TAMAGNO','AGENOR TAMAGNO',1,1,'83566034000175',-1,?,?,?)



select * from bilhet.tbil_fatura
where SEQ_NUMER_PRS = 22001699

p_seq_numer_prs = 22001699
p_num_perio_fat = 3
p_competencia = TO_DATE(2022-11-10)
p_vlr_premio_com = 0.0
p_num_dia_vec = 9
p_cod_user = 8096
p_vlr_merca = 20000.0
p_qtd_merca = 1


call bilhet.SP_GERA_FATURA_MANUAL(
507324,
3,
'01/11/2022',
1.0,
9,
'TESTE',
1.0,
1,
?,
?,
?)


SELECT DATE(TO_DATE('01/11/2022','DD/MM/YYYY') + 1 MONTH + 9 DAYS - 1 DAY) FROM DUAL

SELECT
	seq_numer_fat
FROM
	FINAL TABLE (
	INSERT
		INTO
			bilhet.tbil_fatura (
			dhr_fatur,
			seq_numer_prs,
			dat_venci_fat,
			num_mes_cpt,
			sit_fatur,
			num_perio_fat,
			dhr_alter,
			cod_user,
			sit_envio_fat,
			num_motiv_sit,
			ctl_pesso_dic)
		VALUES (
			CURRENT TIMESTAMP,
			507324,
			'2022-12-09',
			11,
			4,
			3,
			CURRENT TIMESTAMP,
			'TESTE',
			1,
			5,
			NULL )));


SELECT * FROM BILHET.TBIL_FATURA tf 
WHERE SEQ_NUMER_FAT = 22001699


SELECT * FROM bilhet.log_bilhet
WHERE TIPO = 4
AND TXT LIKE '%2022%'

SEQ_NUMER_PRS = 22001699


INSERT
	INTO
	bilhet.log_bilhet (tipo,
	txt,
	DATA,
	seq,
	num_grupo_seq,
	seq_gera_fat)
VALUES (to_char(4),
'parametros - p_competencia: ' || '2022-11-10' || ' p_num_perio_fat:' || '3' || ' p_cod_user:' || 'TESTE' ,
current_timestamp,
NEXT value FOR bilhet.seq,
next value for bilhet.seq,
0);

commit


SELECT seq_numer_fat
                         FROM FINAL TABLE (INSERT INTO bilhet.tbil_fatura (dhr_fatur, seq_numer_prs, dat_venci_fat, num_mes_cpt, sit_fatur, num_perio_fat, dhr_alter, cod_user, sit_envio_fat, num_motiv_sit, ctl_pesso_dic)
                                           VALUES (CURRENT TIMESTAMP, p_seq_numer_prs, v_dat_venci, v_num_mes_cpt, 4, p_num_perio_fat, CURRENT TIMESTAMP, p_cod_user, 1, 5, p_ctl_pesso_dic ))

                                           
SELECT * FROM BILHET.TBIL_PROPOSTA tp 
WHERE NUM_APOLI  = 22001699


ORDER BY SEQ_NUMER_PRS DESC 
WHERE SEQ_NUMER_PRS = 22001699