CREATE PROCEDURE BILHET.SP_GERA_PREMIO_EMBARCADOR
    (IN p_dat_fim_vig DATE,
    IN p_seq_numer_prs BIGINT,
    IN p_seq_numer_fat BIGINT,
    IN p_cod_user VARCHAR(50),
    OUT v_out_result SMALLINT,
    OUT v_out_err_message VARCHAR(255))
--    
    LANGUAGE SQL
    DYNAMIC RESULT SETS 1
    BEGIN
-- 
        DECLARE v_step                  INTEGER       DEFAULT 0;
        DECLARE v_err_message           VARCHAR(255)  DEFAULT '';
        DECLARE SQLSTATE                CHAR(5);
        DECLARE v_err_sqlstate          CHAR(5)       DEFAULT '00000';
        DECLARE v_premio_base           DECIMAL(17,4) DEFAULT 0;
        DECLARE V_COUNT_TX_EMB          INTEGER       DEFAULT 0;
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
--        
        P1:BEGIN
            SET v_err_sqlstate = SQLSTATE;
            SET v_err_message  = 'ERRO PROC: SP_GERA_PREMIO_EMBARCADOR - Passo: ' || RTRIM(LTRIM(CHAR(v_step))) || ' - SQLSTATE:' CONCAT v_err_sqlstate;
            SET v_out_result   = -1;
            SET v_out_err_message = v_err_message;
        END P1;
--
        SET v_step = 1;
        --
        SET V_COUNT_TX_EMB = (
            SELECT	COUNT(1)		
            FROM BILHET.TBIL_PROPOSTA P
            INNER JOIN BILHET.TBIL_RELAC_TAXA_PROPOSTA A ON
                A.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS
            INNER JOIN BILHET.TBIL_VIGENCIA_TAXA_CLIENTE B ON
                A.NUM_SEQUE_TAR = B.NUM_SEQUE_TAR
            WHERE P.SEQ_NUMER_PRS = p_seq_numer_prs
            AND A.NUM_TARIF = 91
            AND P.NUM_APOLI > 0
            AND P.NUM_RAMO_SEG = 1
            AND LAST_DAY(p_dat_fim_vig) BETWEEN B.DAT_INICI_VIG AND B.DAT_FIM_VIG 
        )
        --EXECUTA AS ROTINAS SE O SEGURADO TIVER TX EMBARCADOR VIGENTE
        IF V_COUNT_TX_EMB > 0 THEN
--  
            SET v_step = 2;
                WITH EmbarcadorInfo AS (
                    SELECT
                        cod_docum_pri AS cod_cnpj_embarcador,
                        nom_pesso
                    FROM pamais.tcrp_pessoa
                ),
                BaseData AS (
                    SELECT
                        e.cod_cnpj_embarcador,
                        cc1.num_tarif,
                        SUM(aa1.vlr_tarif_prs) AS total,
                        COALESCE(bb1.sta_agrega_filial, 'N') AS sta_agrega_filial,
                        avb.COD_CNPJ_TOMADOR
                    FROM
                        bilhet.tbil_relac_visao_propt aa1
                        JOIN bilhet.tbil_vigencia_taxa_cliente bb1 ON aa1.num_seque_vig = bb1.num_seque_vig
                        JOIN bilhet.tbil_relac_taxa_proposta cc1 ON cc1.num_seque_tar = bb1.num_seque_tar
                        JOIN bilhet.tbil_relac_averb_propt dd1 ON aa1.seq_numer_prs = dd1.seq_numer_prs
                                                                AND aa1.seq_numer_avb = dd1.seq_numer_avb
                        JOIN bilhet.tbil_averbacao avb ON avb.seq_numer_avb = dd1.seq_numer_avb
                        JOIN bilhet.TBIL_RELAC_TAXA_PROPOSTA e ON e.SEQ_NUMER_PRS = aa1.SEQ_NUMER_PRS
                    WHERE
                        aa1.seq_numer_prs = p_seq_numer_prs
                        AND dd1.seq_numer_fat IS NULL
                        AND TRUNC(avb.dhr_embar) <= LAST_DAY(p_dat_fim_vig)
                        AND cc1.NUM_TARIF = 91
                    GROUP BY
                        e.cod_cnpj_embarcador,
                        cc1.num_tarif,
                        bb1.sta_agrega_filial,
                        avb.COD_CNPJ_TOMADOR
                )
                INSERT INTO bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR (
                    seq_numer_fat,
                    cod_cnpj_embarcador,
                    nom_embarcador,
                    num_tarif,
                    idt_premi,
                    vlr_calcu,
                    dhr_alter,
                    cod_user
                )
                SELECT
                    p_seq_numer_fat,
                    x.cod_cnpj_embarcador,
                    ei.nom_pesso AS nom_embarcador,
                    x.num_tarif,
                    'E',
                    x.total,
                    CURRENT_TIMESTAMP,
                    p_cod_user
                FROM
                    BaseData x
                    JOIN EmbarcadorInfo ei ON ei.cod_cnpj_embarcador = x.cod_cnpj_embarcador
                WHERE
                    (x.sta_agrega_filial = 'N' AND x.cod_cnpj_embarcador = x.cod_cnpj_embarcador)
                    OR (x.sta_agrega_filial = 'S' AND SUBSTR(x.COD_CNPJ_TOMADOR, 1, 8) = SUBSTR(x.cod_cnpj_embarcador, 1, 8));
--
        SET v_step = 3;
      --INSERE TARIFA COM TOTAL DE VIAGEM
            WITH BaseData AS (
                SELECT
                    e.cod_cnpj_embarcador,
                    COUNT(DISTINCT avb.num_averb_pam) AS total
                FROM
                    bilhet.tbil_relac_visao_percu_padra a
                    JOIN bilhet.tbil_vigen_tarifa_percurso b ON a.ctl_vigen_pec = b.ctl_vigen_pec
                    JOIN bilhet.tbil_relac_tarifa_percurso c ON b.num_tarif_pec = c.num_tarif_pec
                    JOIN bilhet.tbil_relac_averb_propt d ON a.seq_numer_prs = d.seq_numer_prs
                                                        AND a.seq_numer_avb = d.seq_numer_avb
                    JOIN bilhet.tbil_averbacao avb ON avb.seq_numer_avb = d.seq_numer_avb
                    JOIN bilhet.TBIL_RELAC_TAXA_PROPOSTA e ON e.SEQ_NUMER_PRS = a.SEQ_NUMER_PRS
                WHERE
                    a.seq_numer_prs = p_seq_numer_prs
                    AND d.seq_numer_fat IS NULL
                    AND TRUNC(avb.dhr_embar) <= LAST_DAY(p_dat_fim_vig)
                    AND e.num_tarif = 91
                    AND e.cod_cnpj_embarcador = avb.cod_cnpj_tomador
                GROUP BY
                    e.cod_cnpj_embarcador
            )
            INSERT INTO bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR (
                seq_numer_fat,
                cod_cnpj_embarcador,
                num_tarif,
                idt_premi,
                vlr_calcu,
                dhr_alter,
                cod_user
            )
            SELECT
                p_seq_numer_fat,
                cod_cnpj_embarcador,
                92 AS num_tarif,
                'E' AS idt_premi,
                SUM(total) AS vlr_calcu,
                CURRENT_TIMESTAMP AS dhr_alter,
                p_cod_user
            FROM
                BaseData
            GROUP BY
                cod_cnpj_embarcador;
--
        SET v_step = 4;
        --INSERE TARIFA COM VALOR TOTAL DE MERCADORIA EMBARCADOR
            WITH BaseData AS (
                SELECT
                    d.seq_numer_prs,
                    d.seq_numer_avb,
                    d.vlr_is,
                    a.cod_cnpj_embarcador
                FROM
                    bilhet.tbil_relac_averb_propt d
                    JOIN bilhet.tbil_averbacao avb ON avb.seq_numer_avb = d.seq_numer_avb
                    JOIN bilhet.tbil_relac_visao_percu_padra c ON d.seq_numer_prs = c.seq_numer_prs
                    JOIN bilhet.TBIL_RELAC_TAXA_PROPOSTA a ON a.seq_numer_prs = d.seq_numer_prs
                WHERE
                    d.seq_numer_prs = p_seq_numer_prs
                    AND d.seq_numer_fat IS NULL
                    AND a.num_tarif = 91
                    AND a.cod_cnpj_embarcador IS NOT NULL
                    AND a.cod_cnpj_embarcador = avb.cod_cnpj_tomador
                    AND TRUNC(avb.dhr_embar) <= LAST_DAY(p_dat_fim_vig)
                    AND avb.seq_numer_avb = d.seq_numer_avb
                    AND d.seq_numer_prs = c.seq_numer_prs
                    AND d.seq_numer_avb = c.seq_numer_avb
            )
            INSERT INTO bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR (
                seq_numer_fat,
                cod_cnpj_embarcador,
                num_tarif,
                idt_premi,
                vlr_calcu,
                dhr_alter,
                cod_user
            )
            SELECT
                p_seq_numer_fat,
                cod_cnpj_embarcador,
                93 AS num_tarif,
                'E' AS idt_premi,
                COALESCE(SUM(vlr_is), 0) AS vlr_calcu,
                CURRENT_TIMESTAMP AS dhr_alter,
                p_cod_user
            FROM
                BaseData
            GROUP BY
                cod_cnpj_embarcador;
--
        SET v_step = 5;
            --INSERE TAXA MEDIA EMBARCADOR(ROUND( (v_premio_base_embarcador / v_total_mercadoria) * 100, 4))
            WITH PremioBase AS (
                SELECT
                    cod_cnpj_embarcador,
                    ROUND(VLR_CALCU, 4) AS premio_base_embarcador
                FROM
                    bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR
                WHERE
                    NUM_TARIF = 91
                    AND SEQ_NUMER_FAT = p_seq_numer_fat
            ),
            TotalMercadoria AS (
                SELECT
                    cod_cnpj_embarcador,
                    ROUND(VLR_CALCU, 4) AS total_mercadoria_embarcador
                FROM
                    bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR
                WHERE
                    NUM_TARIF = 93
                    AND SEQ_NUMER_FAT = p_seq_numer_fat
            ),
            BaseData AS (
                SELECT DISTINCT
                    a.cod_cnpj_embarcador
                FROM
                    bilhet.TBIL_RELAC_TAXA_PROPOSTA a
                    JOIN bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR b
                        ON a.cod_cnpj_embarcador = b.cod_cnpj_embarcador
                        AND b.seq_numer_fat = p_seq_numer_fat
                WHERE
                    a.seq_numer_prs = p_seq_numer_prs
            )
            INSERT INTO bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR (
                seq_numer_fat,
                cod_cnpj_embarcador,
                num_tarif,
                idt_premi,
                vlr_calcu,
                dhr_alter,
                cod_user
            )
            SELECT
                p_seq_numer_fat,
                b.cod_cnpj_embarcador,
                94 AS num_tarif,
                'E' AS idt_premi,
                ROUND(p.premio_base_embarcador / t.total_mercadoria_embarcador * 100, 4) AS vlr_calcu,
                CURRENT_TIMESTAMP AS dhr_alter,
                p_cod_user
            FROM
                BaseData b
                LEFT JOIN PremioBase p
                    ON b.cod_cnpj_embarcador = p.cod_cnpj_embarcador
                LEFT JOIN TotalMercadoria t
                    ON b.cod_cnpj_embarcador = t.cod_cnpj_embarcador;
    END IF; 
    SET v_step = 6;
        -- SETANDO O STATUS DE FINALIZAÇÃO DA PROCEDURE
        SET v_out_result = 0;
        --
        SET v_out_err_message = '';
        --
END