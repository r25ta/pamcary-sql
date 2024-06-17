CREATE PROCEDURE BILHET.SP_GERA_PREMIO_BASE
  (IN p_competencia DATE,
   IN p_seq_numer_prs BIGINT,
   IN p_seq_numer_fat BIGINT,
   IN p_seq_numer_fat_filho BIGINT,
   IN p_cod_user VARCHAR(50),
   OUT v_out_result SMALLINT,
OUT v_out_err_message VARCHAR(255))
-- 
LANGUAGE SQL
-- 
DYNAMIC RESULT SETS 1
BEGIN
   DECLARE v_vlr DECIMAL(17,4);
--
  DECLARE v_taxa_roubo     		DECIMAL(17,4);
--
  DECLARE v_taxa_unica    		SMALLINT;
--
  DECLARE v_fluvial_zerado 		SMALLINT;
--
  DECLARE v_ocd_zerado                  SMALLINT;
--
  DECLARE v_ocdi_zerado 		SMALLINT;
--
  DECLARE v_existe_taxa_roubo           SMALLINT;
--
  DECLARE v_ramo          		SMALLINT;
--
  DECLARE v_existe_concentracao_risco   SMALLINT;
--
  DECLARE v_step          		INTEGER      DEFAULT 0;
--
  DECLARE v_err_message   		VARCHAR(255) DEFAULT '';
--
  DECLARE SQLSTATE        		CHAR(5);
--
  DECLARE v_err_sqlstate  		CHAR(5)      DEFAULT '00000';
--
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
      P1:BEGIN
         SET v_err_sqlstate = SQLSTATE;
--
         SET v_err_message  = 'ERRO PROC: SP_GERA_PREMIO_BASE - Passo: ' CONCAT RTRIM(LTRIM(CHAR(v_step))) CONCAT ' - SQLSTATE:' CONCAT v_err_sqlstate;
--
         SET v_out_result   = -1;
--
         SET v_out_err_message = v_err_message;
--
      END P1;
--
  SET v_step = 1;
--
  /* ##############################################################
	 CASO EXISTA OCD/OCDI ZERADO, ATUALIZAR AS TAXAS OCD/OCDI PARA ZERO
     ############################################################## */
  SET v_ocd_zerado = (SELECT count(*)
						    FROM bilhet.tbil_valor_soma_tipo_tarifa a, bilhet.tbil_fatura b
						  WHERE a.seq_numer_fat = p_seq_numer_fat
							AND b.sit_fatur = 1
							AND a.idt_premi = 'C'
							AND a.num_tarif = 33 --OCD
							AND a.vlr_calcu = 0  --Somente se o valor ficar ZERADO
							AND b.seq_numer_fat = a.seq_numer_fat);
--
  IF v_ocd_zerado > 0 THEN
     DELETE FROM bilhet.tbil_valor_soma_tipo_tarifa
     WHERE seq_numer_fat = p_seq_numer_fat
      AND idt_premi = 'C'
      AND num_tarif =33;
--
  END IF;
--
  SET v_ocdi_zerado = (SELECT count(*)
						    FROM bilhet.tbil_valor_soma_tipo_tarifa a, bilhet.tbil_fatura b
						  WHERE a.seq_numer_fat = p_seq_numer_fat
							AND b.sit_fatur = 1
							AND a.idt_premi = 'C'
							AND a.num_tarif = 34 --OCDI
							AND a.vlr_calcu = 0  --Somente se o valor ficar ZERADO
							AND b.seq_numer_fat = a.seq_numer_fat);
--
  IF v_ocdi_zerado > 0 THEN
     DELETE FROM bilhet.tbil_valor_soma_tipo_tarifa
     WHERE seq_numer_fat = p_seq_numer_fat
      AND idt_premi = 'C'
      AND num_tarif =34;
--
  END IF;
--
  /* ##############################################################
	 CASO EXISTA FLUVIAL ZERADO, ATUALIZAR AS TAXAS FLUVIAIS PARA ZERO
	 ############################################################## */
  SET v_step = 2;
--
  SET v_fluvial_zerado = (SELECT count(*)
						    FROM bilhet.tbil_valor_soma_tipo_tarifa a, bilhet.tbil_fatura b
						  WHERE a.seq_numer_fat = p_seq_numer_fat
							AND b.sit_fatur = 1
							AND a.idt_premi = 'C'
							AND a.num_tarif = 37 --Fluvial
							AND a.vlr_calcu = 0  --Somente se o valor ficar ZERADO
							AND b.seq_numer_fat = a.seq_numer_fat);
--
  IF v_fluvial_zerado > 0 THEN
     SET v_step = 3;
--
     UPDATE bilhet.tbil_valor_soma_tipo_tarifa SET vlr_calcu = 0
     WHERE seq_numer_fat = p_seq_numer_fat
      AND idt_premi = 'C'
      AND num_tarif IN (66, 36);
-- 66 - Fluvial (AM - RR), 36 - Fluvial (PU)  
  END IF;
--
  /* ##############################################################
	 CASO EXISTA TAXA UNICA, DELETAR TODAS AS TAXAS GERADAS, COM EXCEO DAS TAXAS INCLUSAS NO "NOT IN"
	 ############################################################## */
  SET v_taxa_unica = (SELECT COUNT(1)
                      FROM bilhet.tbil_valor_soma_tipo_tarifa a, bilhet.tbil_fatura b
                      WHERE a.seq_numer_fat = p_seq_numer_fat
                        AND b.sit_fatur = 1
                        AND a.idt_premi = 'C'
                        AND a.num_tarif = 16 --TAXA COMERCIAL
                        AND b.seq_numer_fat = a.seq_numer_fat);
--
  SET v_existe_taxa_roubo = COALESCE(bilhet.fc_tarifa_propt2 (p_seq_numer_prs, 80, p_competencia), 0);
--EXISTE FLAG PARA GERAR FATURA DE CONCENTRAO DE RISCO EM FATURA ISOLADA?
  IF v_taxa_unica > 0 AND v_existe_taxa_roubo > 0 AND nvl(p_seq_numer_fat_filho,0) > 0 THEN
     SET v_step = 2;
--
	 --transferir taxa 15 para fatura filho
     UPDATE bilhet.tbil_valor_soma_tipo_tarifa SET seq_numer_fat = p_seq_numer_fat_filho
     WHERE seq_numer_fat = p_seq_numer_fat
      AND idt_premi = 'C'
      AND num_tarif IN ( 15);
--TAXA RCFDC
--RONALDO 30-06-2023 ADD TAXA LIMPEZA PISTA -> 90	 e TAXA EMBARCADOR -> 91  
     DELETE FROM bilhet.tbil_valor_soma_tipo_tarifa
     WHERE seq_numer_fat = p_seq_numer_fat
      AND idt_premi = 'C'
      AND num_tarif NOT IN (14, 16, 27, 53, 90, 91);
--AVARIA, TAXA ÃNICA, PAMTAX, CONCENTRAO DE RISCO
  ELSEIF v_taxa_unica > 0  THEN 
     SET v_step = 2;
--RONALDO 30-06-2023 ADD TAXA LIMPEZA PISTA -> 90 e TAXA EMBARCADOR -> 91
     DELETE FROM bilhet.tbil_valor_soma_tipo_tarifa
     WHERE seq_numer_fat = p_seq_numer_fat
      AND idt_premi = 'C'
      AND num_tarif NOT IN (14, 15, 16, 27, 53, 90, 91);
--AVARIA, TAXA RCFDC, TAXA NICA, PAMTAX, CONCENTRAO DE RISCO
	ELSEIF v_existe_taxa_roubo > 0 AND nvl(p_seq_numer_fat_filho,0) > 0 THEN
     SET v_step = 2;
--
	 --transferir taxa 15 para fatura filho
     update bilhet.tbil_valor_soma_tipo_tarifa set seq_numer_fat = p_seq_numer_fat_filho
     WHERE seq_numer_fat = p_seq_numer_fat
      AND idt_premi = 'C'
      AND num_tarif IN ( 15);
--TAXA RCFDC
  END IF;
--
  /* ##############################################################
	 CASO NO EXISTA CONCENTRAO DE RISCO, DELETAR TAXA GERADA
	 ############################################################## */
  SET v_step = 3;
--
  SET v_existe_concentracao_risco = COALESCE(bilhet.fc_tarifa_propt2 (p_seq_numer_prs, 53, p_competencia), 0);
--EXISTE CONCENTRAO DE RISCO?
  IF v_existe_concentracao_risco = 0 THEN --1 = SIM ou 0 = no
      DELETE FROM bilhet.tbil_valor_soma_tipo_tarifa
       WHERE seq_numer_fat = p_seq_numer_fat
         AND idt_premi = 'C'
         AND num_tarif = 53;        
--
  END IF;
--
  /* ##############################################################
	 SOMATRIA DO PREMIO BASE PARA COMPARAO, COM EXCEO DAS TAXAS INCLUSAS NO "NOT IN"
	 ############################################################## */
  SET v_step = 6;
--
  SET v_vlr = COALESCE((SELECT SUM(a.vlr_calcu)
                        FROM bilhet.tbil_valor_soma_tipo_tarifa a, bilhet.tbil_fatura b
                        WHERE a.seq_numer_fat = p_seq_numer_fat
                          AND b.sit_fatur = 1
                          AND a.idt_premi = 'C'
                          AND b.seq_numer_fat = a.seq_numer_fat
                          AND a.num_tarif not in (14, 27)), 0);
 --AVARIA, PAMTAX
  IF v_vlr > 0 THEN
     SET v_step = 7;
--
     INSERT INTO bilhet.tbil_valor_soma_tipo_tarifa (seq_numer_fat, num_tarif, idt_premi, vlr_calcu, dhr_alter, cod_user)
     VALUES (p_seq_numer_fat, 77, 'C', ROUND(v_vlr, 4), CURRENT TIMESTAMP, p_cod_user);
--
	   IF v_existe_taxa_roubo > 0 AND nvl(p_seq_numer_fat_filho,0) > 0 THEN
--	   
		 SET v_taxa_roubo = COALESCE(bilhet.fc_tarifa_fatura (p_seq_numer_fat_filho, 15, 'C'), 0);
--taxa ROUBO
	   INSERT INTO bilhet.tbil_valor_soma_tipo_tarifa (seq_numer_fat, num_tarif, idt_premi, vlr_calcu, dhr_alter, cod_user)
		 VALUES (p_seq_numer_fat_filho, 77, 'C', ROUND(v_taxa_roubo, 4), CURRENT TIMESTAMP, p_cod_user);
--
	   END IF;
--
  END IF;
--
  SET v_step = 8;
--
-- SETANDO O STATUS DE FINALIZAO DA PROCEDURE
  SET v_out_result = 0;
--
  SET v_out_err_message = '';
--
END