CREATE PROCEDURE "BILHET"."SP_REPROCESSA_FATURA"
  (IN p_seq_numer_fat VARCHAR(10000),
   IN p_qtd_fatura INTEGER,
   IN p_cod_user VARCHAR(50),
   IN p_num_motiv_sit SMALLINT,
OUT v_out_result SMALLINT,
OUT v_out_err_message VARCHAR(255))
 
LANGUAGE SQL
  NOT DETERMINISTIC
  CALLED ON
NULL INPUT
 
MODIFIES SQL DATA
 
INHERIT SPECIAL REGISTERS
BEGIN
   DECLARE v_step INTEGER DEFAULT 0;

--
  DECLARE v_seq_numer_fat BIGINT;
--
  DECLARE v_seq_numer_prs BIGINT;
--
  DECLARE v_err_sqlstate  CHAR(5)      DEFAULT '00000';
--
  DECLARE v_err_message   VARCHAR(255) DEFAULT '';
--
  DECLARE v_linha         INTEGER      DEFAULT 1;
--
  DECLARE v_entrou_cursor SMALLINT     DEFAULT 0;
--
  DECLARE SQLSTATE        CHAR(5);
--
  DECLARE SQLCODE         INTEGER      DEFAULT 0;
--
  DECLARE v_seq_credb_prs BIGINT;
--
  DECLARE v_num_seque_vig BIGINT;
--
  declare v_contador       bigint;
--
  Declare v_laco           bigint;
--
  DECLARE C1 CURSOR WITH HOLD FOR
    SELECT pcd.seq_credb_prs, vig.num_seque_vig 
	  FROM bilhet.tbil_proposta_credito_debito pcd
     INNER JOIN bilhet.tbil_vigencia_proposta_credb vig on pcd.seq_credb_prs = vig.seq_credb_prs
     WHERE vig.seq_numer_fat = v_seq_numer_fat;
--
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
      P1:BEGIN
         SET v_err_sqlstate = SQLSTATE;
--
         SET v_err_message  = 'ERRO PROC: SP_REPROCESSA_FATURA - Passo: ' CONCAT RTRIM(LTRIM(CHAR(v_step))) CONCAT ' - Linha: ' CONCAT v_linha CONCAT ' - SQLSTATE:' CONCAT v_err_sqlstate;
--
         SET v_out_result   = -1;
--
         SET v_out_err_message = v_err_message;
--
      END P1;
--
  set v_contador = 0;
--
  set v_laco     = 0;
 --
  SET v_step 	 = 1;
--
  WHILE v_linha <= p_qtd_fatura DO
       SET v_step = 2;
--
       SET v_seq_numer_fat = pamais.split(v_linha - 1, ',', p_seq_numer_fat);
--
       SET v_step = 3;
--
      --RETIRADO O UPATE EM CIMA DO NÚMERO DE FATURA DA CIA
       UPDATE bilhet.tbil_fatura 
           SET sit_fatur = 6, num_motiv_sit = p_num_motiv_sit, cod_user = p_cod_user, dhr_alter = CURRENT TIMESTAMP, IDT_ENVIO_CBR = 'C'
	   WHERE seq_numer_fat = v_seq_numer_fat;
--
       SET v_step = 4;
--
	   ------- 
		FOR R_CUR as c_cur cursor with hold for
			SELECT a.num_averb_pam, B.SEQ_NUMER_AVB, B.SEQ_NUMER_PRS
			  FROM BILHET.TBIL_AVERBACAO A
			 INNER JOIN BILHET.TBIL_RELAC_AVERB_PROPT B ON A.SEQ_NUMER_AVB = B.SEQ_NUMER_AVB
			 WHERE B.SEQ_NUMER_FAT = v_seq_numer_fat			   
		DO
			SET v_entrou_cursor = 1;
--
			SET v_step = 5;
--
			UPDATE bilhet.tbil_relac_averb_propt SET seq_numer_fat = NULL, num_etapa_avb = 1, dhr_alter = CURRENT TIMESTAMP WHERE SEQ_NUMER_PRS = R_CUR.SEQ_NUMER_PRS AND SEQ_NUMER_AVB = R_CUR.SEQ_NUMER_AVB;
--
			SET v_step = 6;
--
			DELETE FROM bilhet.tbil_relac_visao_percu_padra WHERE seq_numer_prs = r_cur.seq_numer_prs AND seq_numer_avb = r_cur.seq_numer_avb;
--
			SET v_step = 7;
--
			DELETE FROM bilhet.tbil_relac_visao_percu_propt WHERE seq_numer_prs = r_cur.seq_numer_prs AND seq_numer_avb = r_cur.seq_numer_avb;
		--
			SET v_step = 8;
--
			DELETE FROM bilhet.tbil_relac_visao_propt 		WHERE seq_numer_prs = r_cur.seq_numer_prs AND seq_numer_avb = r_cur.seq_numer_avb;
		--
			SET v_step = 9;
--
			UPDATE bilhet.tbil_averbacao_indice SET sit_trans = 3, dhr_alter = CURRENT TIMESTAMP WHERE num_averb_pam = r_cur.num_averb_pam;
--

			set V_CONTADOR = V_CONTADOR + 1;
--
			if  V_CONTADOR >= 100   then
			   set V_CONTADOR  = 0;
--
			   set V_LACO = V_LACO + 1;
--
			   COMMIT;
--
			END IF;
--
		END FOR;
	   --
		
		COMMIT;
--
	   ------- 
		IF v_entrou_cursor = 0 THEN
			SET v_seq_numer_prs = ( SELECT seq_numer_prs FROM bilhet.tbil_fatura WHERE seq_numer_fat = v_seq_numer_fat );
--
			
			FOR C2 as c_cur cursor with hold for
				SELECT DISTINCT X.NUM_AVERB_PAM, A.SEQ_NUMER_PRS, A.SEQ_NUMER_AVB
				  FROM BILHET.TBIL_AVERBACAO X
				 INNER JOIN BILHET.TBIL_RELAC_AVERB_PROPT A ON A.SEQ_NUMER_AVB = X.SEQ_NUMER_AVB
				 INNER JOIN BILHET.TBIL_RELAC_VISAO_PERCU_PADRA B ON A.SEQ_NUMER_PRS = B.SEQ_NUMER_PRS AND A.SEQ_NUMER_AVB = B.SEQ_NUMER_AVB
				 WHERE A.SEQ_NUMER_PRS = v_seq_numer_prs
				   AND A.SEQ_NUMER_FAT IS NULL
			DO
				SET v_step = 10;
--
				UPDATE bilhet.tbil_relac_averb_propt SET num_etapa_avb = 1, dhr_alter = CURRENT TIMESTAMP WHERE seq_numer_prs = c2.seq_numer_prs AND seq_numer_avb = c2.seq_numer_avb;
--
				SET v_step = 11;
--
				DELETE FROM bilhet.tbil_relac_visao_percu_padra WHERE seq_numer_prs = C2.seq_numer_prs AND seq_numer_avb = C2.seq_numer_avb;
--
				SET v_step = 12;
--
				DELETE FROM bilhet.tbil_relac_visao_percu_propt WHERE seq_numer_prs = C2.seq_numer_prs AND seq_numer_avb = C2.seq_numer_avb;
		--
				SET v_step = 13;
--
				DELETE FROM bilhet.tbil_relac_visao_propt 		WHERE seq_numer_prs = C2.seq_numer_prs AND seq_numer_avb = C2.seq_numer_avb;
		--
				SET v_step = 14;
--
				UPDATE bilhet.tbil_averbacao_indice SET sit_trans = 3, dhr_alter = CURRENT TIMESTAMP WHERE num_averb_pam = C2.num_averb_pam;
--

				set V_CONTADOR = V_CONTADOR + 1;
--
				if  V_CONTADOR >= 100   then
				   set V_CONTADOR  = 0;
--
				   set V_LACO = V_LACO + 1;
--
				   COMMIT;
--
				END IF;
--
			END FOR;
	 --
		END IF;
--
		
		COMMIT;
--

		SET v_step = 15;
--
		OPEN C1;
--
		FETCH C1 INTO v_seq_credb_prs, v_num_seque_vig;
--
		WHILE SQLCODE = 0 DO
		   --UPDATE BILHET.TBIL_PROPOSTA_CREDITO_DEBITO PCD SET PCD.STA_ATIVO = 'N' WHERE SEQ_CREDB_PRS = v_lancamento;
--
		   UPDATE bilhet.tbil_vigencia_proposta_credb credb SET seq_numer_fat = NULL WHERE seq_credb_prs = v_seq_credb_prs AND num_seque_vig = v_num_seque_vig;
--

		   FETCH C1 INTO v_seq_credb_prs, v_num_seque_vig;
--
		END WHILE;
--
		CLOSE C1;
--
		
		COMMIT;
--

		SET v_entrou_cursor = 0;
--
		SET v_step = 16;
--
		SET v_linha = v_linha + 1;
--
  END WHILE;
--

  SET v_step = 17;
--

--SETANDO O STATUS DE FINALIZAÇÃO DA PROCEDURE
  SET v_out_result = 0;
--
  SET v_out_err_message = '';
--
  COMMIT;
--
END