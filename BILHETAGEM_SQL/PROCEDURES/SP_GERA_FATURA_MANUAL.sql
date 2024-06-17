CREATE PROCEDURE "BILHET"."SP_GERA_FATURA_MANUAL"
  (IN p_seq_numer_prs BIGINT,
--   IN  p_ctl_pesso_dic   BIGINT,
   IN  p_num_perio_fat   SMALLINT,
   IN  p_competencia     DATE,
   IN  p_vlr_premio_com  DECIMAL(17,4),
   IN  p_num_dia_vec     SMALLINT,
   IN  p_cod_user        VARCHAR(50),
   IN  p_vlr_merca  	 DECIMAL(17,4),
   IN  p_qtd_merca  	 BIGINT,
   OUT p_seq_numer_fat   BIGINT,
   OUT v_out_result      SMALLINT, 
   OUT v_out_err_message VARCHAR(255))
 
LANGUAGE SQL
  NOT DETERMINISTIC
  CALLED ON NULL INPUT
 
MODIFIES SQL DATA
 
INHERIT SPECIAL REGISTERS
/**************************************************************************************************************
 CRIACAO...: 28/10/2014
 AUTOR.....: Rafael Madeira
 PROJETO...: Seguros - Bilhetagem
 DESCRICAO.: Procedure responsável por inserir uma fatura "manualmente", ou seja, quando não existir averbações 
             (por problemas de infra-estrutura, ou quando o cliente não conseguir enviar suas averbações), o 
             sistema permitirá a inclusão de faturas manuais.
 PARAMETROS:
    IN:
      P_SEQ_NUMER_PRS  = Proposta relacionada ao cliente que não conseguiu enviar suas averbações para faturamento
      P_NUM_PERIO_FAT  = Período da fatura. 1: 1a Quinzena / 2: 2a Quinzena / 3: Mensal
      P_COMPETENCIA    = Competência em que se está processando o faturamento. Formato: 01/MM/YYYY, onde o dia é fixo "01"
      P_VLR_PREMIO_COM = Valor do prêmio comercial para as averbações que não foram enviadas pelo cliente
      P_NUM_DIA_VEC    = Dia de vencimento da fatura gerada manualmente, podendo ser diferente do dia de vencimento contido na proposta. 
                         Deverá ser preenchido com "NULL" caso não tenha essa informação.
      P_COD_USER       = Usuário que está realizando o cadastro da fatura manual

    OUT:
      V_OUT_RESULT      = Retorno contendo o resultado do processamento: 0 = Processamento OK / -1 = Identifica erros
      V_OUT_ERR_MESSAGE = Retorno contendo a mensagem de erro ocorrido: '' = Processamento OK / <msg> = Msg de erro
***************************************************************************************************************/
BEGIN
  DECLARE v_dat_inici_vig DATE;
--
  DECLARE v_dat_fim_vig   DATE;
--
  DECLARE v_num_dia_vec   SMALLINT;
--
  DECLARE v_dat_venci     DATE;
--
  DECLARE v_msg           SMALLINT       DEFAULT 0;
--
  DECLARE v_err_msg       VARCHAR(255)   DEFAULT '';
--
  DECLARE v_seq_numer_fat BIGINT;
--
  DECLARE v_num_mes_cpt   INTEGER;
--
  DECLARE v_grupo_seq 	  BIGINT		 DEFAULT -1;
--
  DECLARE v_seq_gera_fat  SMALLINT	     DEFAULT -1;
--
  DECLARE v_step          INTEGER        DEFAULT 0;
--
  DECLARE v_err_sqlstate  CHAR(5)        DEFAULT '00000';
--
  DECLARE v_err_message   VARCHAR(255)   DEFAULT '';
--
  DECLARE p_ctl_pesso_dic BIGINT;
--
  
  DECLARE SQLSTATE        CHAR(5);
--
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
      P1:BEGIN
         SET v_err_sqlstate = SQLSTATE;
--
         SET v_err_message  = 'ERRO PROC: SP_GERA_FATURA_MANUAL - Passo: ' CONCAT RTRIM(LTRIM(CHAR(v_step))) CONCAT ' - SQLSTATE:' CONCAT v_err_sqlstate;
--
         SET v_out_result   = -1;
--
         SET v_out_err_message = v_err_message;
--
      END P1;
--

  SET v_step = 1;
--


  IF p_num_perio_fat = 1 THEN --1a QUINZENA
     SET v_dat_inici_vig = p_competencia;
--
     SET v_dat_fim_vig = p_competencia + 14 days;
--

  ELSEIF p_num_perio_fat = 2 THEN --2a QUINZENA
     SET v_dat_inici_vig = p_competencia + 15 days;
--
     SET v_dat_fim_vig = LAST_DAY(p_competencia);
--

  ELSEIF p_num_perio_fat = 3 THEN --MENSAL
     SET v_dat_inici_vig = p_competencia;
--
     SET v_dat_fim_vig = LAST_DAY(p_competencia);
--
  END IF;
--
  
  SET v_grupo_seq = next value for bilhet.seq;
--
  
  insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'INCLUSAO MANUAL', current_timestamp, next value for bilhet.seq, v_grupo_seq, 0);
--
  
  SET v_step = 2;
--
  SET v_num_mes_cpt = YEAR(p_competencia)||RIGHT('0'||MONTH(p_competencia),2);
--ANO_MES (YYYYMM)
  SET v_num_dia_vec = p_num_dia_vec;
--
  
  IF p_num_dia_vec = NULL THEN
     SET v_num_dia_vec = (SELECT num_dia_vec FROM bilhet.tbil_vencimento_fatura_propt WHERE seq_numer_prs = p_seq_numer_prs AND num_perio_fat = p_num_perio_fat);
--
  END IF;
--

  IF v_num_dia_vec > 30 THEN
    SET v_step = 3;
--
    SET v_dat_venci = (SELECT CASE WHEN 
                              DAY((p_competencia + 1 MONTH + (v_num_dia_vec/30) MONTHS) + (MOD(v_num_dia_vec,30)) DAYS - 1 DAY) = 31 THEN
                              DATE(p_competencia + 1 MONTH + (v_num_dia_vec/30) MONTHS) + (MOD(v_num_dia_vec,30)) DAYS - 2 DAY ELSE
                              DATE(p_competencia + 1 MONTH + (v_num_dia_vec/30) MONTHS) + (MOD(v_num_dia_vec,30)) DAYS - 1 DAY END RESULT
                       FROM dual);
--
  ELSE
    --SET v_dat_venci = DATE(p_competencia + 1 MONTH + v_num_dia_vec DAYS - 1 DAY);
]
    --Essa condição é apenas para o mês de competência Janeiro com vencimento para Fevereiro
	IF RIGHT(v_num_mes_cpt, 2) = '01' AND v_num_dia_vec IN ( 29, 30 ) THEN 
		SET v_dat_venci = LAST_DAY(DATE(p_competencia + 1 MONTH));
--
	ELSE 
		SET v_dat_venci = DATE(p_competencia + 1 MONTH + v_num_dia_vec DAYS - 1 DAY);
--
	END IF;
--
  END IF;
--
  
  SET v_step = 4;
--
  insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step), 'parametros - p_competencia: ' || p_competencia ||' p_num_perio_fat:'|| p_num_perio_fat ||' p_cod_user:'|| p_cod_user , current_timestamp, next value for bilhet.seq, v_grupo_seq, 0);
--
  
  SET v_seq_numer_fat = (SELECT seq_numer_fat
                         FROM FINAL TABLE (INSERT INTO bilhet.tbil_fatura (dhr_fatur, seq_numer_prs, dat_venci_fat, num_mes_cpt, sit_fatur, num_perio_fat, dhr_alter, cod_user, sit_envio_fat, num_motiv_sit, ctl_pesso_dic)
                                           VALUES (CURRENT TIMESTAMP, p_seq_numer_prs, v_dat_venci, v_num_mes_cpt, 4, p_num_perio_fat, CURRENT TIMESTAMP, p_cod_user, 1, 5, p_ctl_pesso_dic )));
--

  insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'v_seq_numer_fat = '||v_seq_numer_fat||' v_dat_venci '||to_char(v_dat_venci,'dd/mm/yyyy'), CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
--
  
  SET v_step = 5;
--
  
  IF v_msg = 0 THEN
	 insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'vai abrir bilhet.sp_gera_premio_base_manual', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
   		--
     CALL bilhet.sp_gera_premio_base_manual(v_seq_numer_fat, p_vlr_premio_com, p_cod_user, v_msg, v_err_msg);
--
     SET v_step = 11;
--
     IF v_msg = 0 THEN
		insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'vai abrir bilhet.sp_gera_premio_minimo', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
   		--
		CALL bilhet.sp_gera_premio_minimo (v_dat_inici_vig, v_dat_fim_vig, p_seq_numer_prs, v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
--
        SET v_step = 12;
--
        IF v_msg = 0 THEN
		   insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'vai abrir bilhet.sp_gera_desconto_comercial', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
   		--
		   CALL bilhet.sp_gera_desconto_comercial (p_competencia, p_seq_numer_prs, v_seq_numer_fat, NULL, p_cod_user, v_msg, v_err_msg);
--
           SET v_step = 13;
--
		   IF v_msg = 0 THEN
			  insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'vai abrir bilhet.sp_gera_premio_comercial', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
   		--
			  CALL bilhet.sp_gera_premio_comercial (v_dat_fim_vig, p_seq_numer_prs, v_seq_numer_fat, NULL, p_cod_user, v_msg, v_err_msg);
--
			   IF v_msg = 0 THEN
				  insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'vai abrir bilhet.sp_gera_credito_debito', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
--
				  CALL bilhet.sp_gera_credito_debito (p_competencia, p_seq_numer_prs, v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
--
				  SET v_step = 14;
--
				  IF v_msg = 0 THEN
					 insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'vai abrir bilhet.sp_gera_juros', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
--
					 CALL bilhet.sp_gera_juros (p_competencia, p_seq_numer_prs, v_seq_numer_fat, NULL, p_cod_user, v_msg, v_err_msg);
                --
					 SET v_step = 15;
--
					 IF v_msg = 0 THEN
						insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'vai abrir bilhet.sp_gera_premio_liquido', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
--
						CALL bilhet.sp_gera_premio_liquido (p_competencia, p_seq_numer_prs, v_seq_numer_fat, NULL, p_cod_user, v_msg, v_err_msg);
--
						SET v_step = 16;
--
						IF v_msg = 0 THEN
						   insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'vai abrir bilhet.sp_gera_taxa_agravacao', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
--
						   CALL bilhet.sp_gera_taxa_agravacao (v_dat_fim_vig, p_seq_numer_prs, v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
--
						   SET v_step = 17;
--
						   IF v_msg = 0 THEN
							  insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'vai abrir bilhet.sp_gera_custo_averbacao', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
--
							  CALL bilhet.sp_gera_custo_averbacao (p_competencia, p_seq_numer_prs, v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
--
							  SET v_step = 18;
--
							  IF v_msg = 0 THEN
								 insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'vai abrir bilhet.sp_gera_iof_premio_total', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
--
								 CALL bilhet.sp_gera_iof_premio_total (p_competencia, p_seq_numer_prs, v_seq_numer_fat, NULL, p_cod_user, v_msg, v_err_msg);
--
								 SET v_step = 19;
--
								 IF v_msg = 0 THEN
									--INSERE TARIFA COM VALOR TOTAL DE MERCADORIA
									insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'INSERE TARIFA COM VALOR TOTAL DE MERCADORIA', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
--
									INSERT INTO bilhet.tbil_valor_soma_tipo_tarifa (seq_numer_fat, num_tarif, idt_premi, vlr_calcu, dhr_alter, cod_user) VALUES ( v_seq_numer_fat, 69, 'A', NVL(p_vlr_merca, 0), CURRENT_TIMESTAMP, p_cod_user);
--
									--INSERE TARIFA COM TOTAL DE VIAGEM
									insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'INSERE TARIFA COM TOTAL DE VIAGEM', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
--
									INSERT INTO bilhet.tbil_valor_soma_tipo_tarifa (seq_numer_fat, num_tarif, idt_premi, vlr_calcu, dhr_alter, cod_user) VALUES ( v_seq_numer_fat, 70, 'A', p_qtd_merca, CURRENT_TIMESTAMP, p_cod_user);
--
									insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'vai abrir bilhet.sp_gera_taxa_media', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
--
									CALL bilhet.sp_gera_taxa_media (v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
--
									SET v_step = 20;
--
									--INSERE DATA DO PROCESSAMENTO
									insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat) values (to_char(v_step),'INSERE DATA DO PROCESSAMENTO', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat);
--
									INSERT INTO bilhet.tbil_movim_fatura (seq_numer_fat, num_tarif, des_movim_fat, cod_user, dhr_alter) VALUES (v_seq_numer_fat, 81, to_char(current_timestamp,'dd/mm/yyyy hh24:mi:ss'), p_cod_user, current_timestamp);
--
								 END IF;
--
							  END IF;
--
							END IF;
--
						END IF;
--
					 END IF;
--
				 END IF;
--
              END IF;
--
           END IF;
--
        END IF;
--
     END IF;
--
  END IF;
--

  SET v_step = 22;
--

--SETANDO O STATUS DE FINALIZAÇÃO DA PROCEDURE
  COMMIT;
--
  SET p_seq_numer_fat   = v_seq_numer_fat;
--
  SET v_out_result      = 0;
--
  SET v_out_err_message = '';
--
END