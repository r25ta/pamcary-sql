CREATE PROCEDURE BILHET.SP_GERA_PREMIO_EMBARCADOR
    (IN p_dat_fim_vig DATE,
    IN p_seq_numer_prs BIGINT,
    IN p_seq_numer_fat BIGINT,
    IN p_cod_user VARCHAR(50),
    OUT v_out_result SMALLINT,
    OUT v_out_err_message VARCHAR(255))
    
    LANGUAGE SQL
    DYNAMIC RESULT SETS 1
    BEGIN
    
        DECLARE v_step                  INTEGER       DEFAULT 0;
        DECLARE v_err_message           VARCHAR(255)  DEFAULT '';
        DECLARE SQLSTATE                CHAR(5);
        DECLARE v_err_sqlstate          CHAR(5)       DEFAULT '00000';
        DECLARE v_premio_base           DECIMAL(17,4) DEFAULT 0;
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        
        P1:BEGIN
            SET v_err_sqlstate = SQLSTATE;
            SET v_err_message  = 'ERRO PROC: SP_GERA_PREMIO_EMBARCADOR - Passo: ' CONCAT RTRIM(LTRIM(CHAR(v_step))) CONCAT ' - SQLSTATE:' CONCAT v_err_sqlstate;
            SET v_out_result   = -1;
            SET v_out_err_message = v_err_message;

        END P1;
--
        SET v_step = 1;
       
           INSERT INTO bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR (seq_numer_fat, cod_cnpj_embarcador, num_tarif, idt_premi, vlr_calcu, dhr_alter, cod_user)
               SELECT
           p_seq_numer_fat,
           x.cod_cnpj_embarcador,
           x.num_tarif,
           'E',
           x.total,
           CURRENT timestamp,
           p_cod_user
        FROM    (
           SELECT
               e.cod_cnpj_embarcador AS cod_cnpj_embarcador,
               --(SELECT nom_pesso FROM pamais.tcrp_pessoa WHERE cod_docum_pri = e.cod_cnpj_embarcador) AS embarcador
               cc1.num_tarif,
               SUM(aa1.vlr_tarif_prs) total
           FROM        
                bilhet.tbil_relac_visao_propt aa1,
                bilhet.tbil_vigencia_taxa_cliente bb1,
                bilhet.tbil_relac_taxa_proposta cc1,
                bilhet.tbil_relac_averb_propt dd1,
                bilhet.tbil_averbacao avb,
                bilhet.TBIL_RELAC_TAXA_PROPOSTA e
           WHERE        aa1.seq_numer_prs = p_seq_numer_prs
               AND dd1.seq_numer_fat IS NULL
               AND TRUNC(avb.dhr_embar) <= LAST_DAY(p_dat_fim_vig)
               AND cc1.NUM_TARIF = 91
               AND e.SEQ_NUMER_PRS = aa1.SEQ_NUMER_PRS
               AND avb.seq_numer_avb = dd1.seq_numer_avb
               AND cc1.num_seque_tar = bb1.num_seque_tar
               AND aa1.num_seque_vig = bb1.num_seque_vig
               AND aa1.seq_numer_prs = dd1.seq_numer_prs
               AND aa1.seq_numer_avb = dd1.seq_numer_avb
               AND avb.COD_CNPJ_TOMADOR = e.COD_CNPJ_EMBARCADOR
           GROUP BY
               aa1.seq_numer_prs,
               e.COD_CNPJ_EMBARCADOR,
               cc1.num_tarif
        ) x;

    SET v_step = 2;

      --INSERE TARIFA COM TOTAL DE VIAGEM
    INSERT INTO bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR (seq_numer_fat, cod_cnpj_embarcador, num_tarif, idt_premi, vlr_calcu, dhr_alter, cod_user)
    SELECT p_seq_numer_fat, x.cod_cnpj_embarcador, 92, 'E', sum(x.total), CURRENT timestamp, p_cod_user
         FROM (
             SELECT e.cod_cnpj_embarcador AS cod_cnpj_embarcador
             --,(SELECT nom_pesso FROM pamais.tcrp_pessoa WHERE cod_docum_pri = e.cod_cnpj_embarcador) AS embarcador 
                ,COUNT(DISTINCT avb.num_averb_pam) AS total
               FROM bilhet.tbil_relac_visao_percu_padra a
               , bilhet.tbil_vigen_tarifa_percurso b
               , bilhet.tbil_relac_tarifa_percurso c
               , bilhet.tbil_relac_averb_propt d
               , bilhet.tbil_averbacao avb
               , bilhet.TBIL_RELAC_TAXA_PROPOSTA e
              WHERE a.seq_numer_prs = p_seq_numer_prs
                  AND d.seq_numer_fat IS NULL
                  AND TRUNC(avb.dhr_embar) <= LAST_DAY(p_dat_fim_vig) 
                  AND e.seq_numer_prs = a.seq_numer_prs
                  AND e.num_tarif = 91
                  AND avb.seq_numer_avb = d.seq_numer_avb
                  AND a.ctl_vigen_pec = b.ctl_vigen_pec
                  AND b.num_tarif_pec = c.num_tarif_pec
                  AND a.seq_numer_prs = d.seq_numer_prs
                  AND a.seq_numer_avb = d.seq_numer_avb
                  AND e.cod_cnpj_embarcador = avb.cod_cnpj_tomador
                GROUP BY a.seq_numer_prs, e.cod_cnpj_embarcador
         
         ) x
        GROUP BY x.cod_cnpj_embarcador;

    SET v_step = 3;
        
    --INSERE TARIFA COM VALOR TOTAL DE MERCADORIA EMBARCADOR
     INSERT INTO bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR (seq_numer_fat,cod_cnpj_embarcador, num_tarif, idt_premi, vlr_calcu, dhr_alter, cod_user)
        SELECT p_seq_numer_fat, x.cod_cnpj_embarcador, 93, 'E', NVL(SUM(x.vlr_is), 0), CURRENT timestamp, p_cod_user
        FROM ( SELECT DISTINCT d.seq_numer_prs
                ,d.seq_numer_avb
                ,d.vlr_is
                ,a.cod_cnpj_embarcador  AS cod_cnpj_embarcador
                --,(SELECT nom_pesso FROM pamais.tcrp_pessoa WHERE cod_docum_pri = a.cod_cnpj_embarcador) AS embarcador
                FROM bilhet.tbil_relac_averb_propt d
                    ,bilhet.tbil_averbacao avb
                    ,bilhet.tbil_relac_visao_percu_padra c 
                    ,bilhet.TBIL_RELAC_TAXA_PROPOSTA a
                WHERE d.seq_numer_prs = p_seq_numer_prs
                    AND d.seq_numer_fat IS null
                    AND a.seq_numer_prs = d.seq_numer_prs
                    AND a.num_tarif = 91
                    AND a.cod_cnpj_embarcador IS NOT NULL
                    AND a.cod_cnpj_embarcador = avb.cod_cnpj_tomador
                    AND TRUNC(avb.dhr_embar) <= LAST_DAY(p_dat_fim_vig)
                    AND avb.seq_numer_avb = d.seq_numer_avb
                    AND d.seq_numer_prs = c.seq_numer_prs
                    AND d.seq_numer_avb = c.seq_numer_avb
                    AND avb.COD_CNPJ_TOMADOR = a.cod_cnpj_embarcador
            )x 
            GROUP BY x.cod_cnpj_embarcador;


    SET v_step = 4;

        --INSERE TAXA MEDIA EMBARCADOR(ROUND( (v_premio_base_embarcador / v_total_mercadoria) * 100, 4))
        INSERT INTO bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR (seq_numer_fat,cod_cnpj_embarcador, num_tarif, idt_premi, vlr_calcu, dhr_alter, cod_user)
        SELECT p_seq_numer_fat, x.cod_cnpj_embarcador, 94, 'E', ROUND(x.premio_base_embarcador/x.total_mercadoria_embarcador*100,4), CURRENT timestamp, p_cod_user
        FROM ( SELECT DISTINCT a.cod_cnpj_embarcador AS cod_cnpj_embarcador
                --,(SELECT nom_pesso FROM pamais.tcrp_pessoa WHERE cod_docum_pri = a.cod_cnpj_embarcador) AS embarcador
                ,ROUND((SELECT VLR_CALCU FROM bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR
                    WHERE NUM_TARIF = 91
                    AND SEQ_NUMER_FAT = p_seq_numer_fat
                    AND COD_CNPJ_EMBARCADOR = a.cod_cnpj_embarcador),4) AS premio_base_embarcador
                ,ROUND((SELECT VLR_CALCU FROM bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR
                    WHERE NUM_TARIF = 93
                    AND SEQ_NUMER_FAT = p_seq_numer_fat
                    AND COD_CNPJ_EMBARCADOR = a.cod_cnpj_embarcador),4) AS total_mercadoria_embarcador
                FROM bilhet.TBIL_RELAC_TAXA_PROPOSTA a
                , bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR b
                WHERE a.seq_numer_prs = p_seq_numer_prs
                    AND b.seq_numer_fat = p_seq_numer_fat
                    AND a.cod_cnpj_embarcador = b.cod_cnpj_embarcador
                    
            )x 
            GROUP BY x.cod_cnpj_embarcador, x.premio_base_embarcador, x.total_mercadoria_embarcador;

    SET v_step = 5;
        -- SETANDO O STATUS DE FINALIZAÇÃO DA PROCEDURE
        SET v_out_result = 0;
        --
        SET v_out_err_message = '';
        --
END