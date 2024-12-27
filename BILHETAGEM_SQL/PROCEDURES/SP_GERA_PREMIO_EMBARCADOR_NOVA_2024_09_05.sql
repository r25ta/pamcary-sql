CREATE OR replace PROCEDURE bilhet.SP_GERA_PREMIO_EMBARCADOR
                                               (IN p_dat_fim_vig DATE,
                                                IN p_seq_numer_prs BIGINT,
                                                IN p_seq_numer_fat BIGINT,
                                                IN p_cod_user VARCHAR(50),
                                               OUT v_out_result SMALLINT,
OUT v_out_err_message VARCHAR(255))
LANGUAGE SQL
DYNAMIC RESULT SETS 1
BEGIN
   --
DECLARE v_step INTEGER DEFAULT 0;

   --
DECLARE v_err_message VARCHAR(255) DEFAULT '';

   --
DECLARE sqlstate CHAR(5);

   --
DECLARE v_err_sqlstate CHAR(5) DEFAULT '00000';

   --
DECLARE v_premio_base DECIMAL(17, 4) DEFAULT 0;

   --
DECLARE v_tem_taxa_embarcador SMALLINT;

   --
DECLARE v_tem_premio_comercial SMALLINT;

   --
DECLARE V_COUNT_TX_EMB INTEGER DEFAULT 0;

   --
DECLARE EXIT HANDLER FOR sqlexception
   P1:
BEGIN
       SET        v_err_sqlstate = SQLSTATE;

--
  SET v_err_message = 'ERRO PROC: SP_GERA_PREMIO_EMBARCADOR - Passo: ' CONCAT Rtrim(Ltrim(CHAR(v_step))) CONCAT ' - SQLSTATE:' CONCAT v_err_sqlstate;

--
  SET v_out_result = -1;

--
  SET v_out_err_message = v_err_message;

--
END P1;

--
--
SET v_step = 1;

--
SET V_COUNT_TX_EMB = (
    SELECT
   COUNT(1)
FROM    BILHET.TBIL_PROPOSTA P
INNER JOIN BILHET.TBIL_RELAC_TAXA_PROPOSTA A ON
   A.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS
INNER JOIN BILHET.TBIL_VIGENCIA_TAXA_CLIENTE B ON
   A.NUM_SEQUE_TAR = B.NUM_SEQUE_TAR
WHERE    P.SEQ_NUMER_PRS = p_seq_numer_prs
   AND A.NUM_TARIF = 91
   AND LAST_DAY(p_dat_fim_vig) BETWEEN B.DAT_INICI_VIG AND B.DAT_FIM_VIG 
);

--EXECUTA AS ROTINAS SE O SEGURADO TIVER TX EMBARCADOR VIGENTE
IF V_COUNT_TX_EMB > 0 THEN
    SET v_step = 2;
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
        e.cod_cnpj_embarcador,
        p.nom_pesso AS nom_embarcador,
        cc1.num_tarif,
        'E' AS idt_premi,
        SUM(aa1.vlr_tarif_prs) AS vlr_calcu,
        CURRENT TIMESTAMP AS dhr_alter,
        p_cod_user AS cod_user
    FROM
        bilhet.tbil_relac_visao_propt aa1
        JOIN bilhet.tbil_vigencia_taxa_cliente bb1 ON aa1.num_seque_vig = bb1.num_seque_vig
        JOIN bilhet.tbil_relac_taxa_proposta cc1 ON cc1.num_seque_tar = bb1.num_seque_tar
        JOIN bilhet.tbil_relac_averb_propt dd1 ON aa1.seq_numer_prs = dd1.seq_numer_prs
        AND aa1.SEQ_NUMER_AVB  = dd1.SEQ_NUMER_AVB
        JOIN bilhet.tbil_averbacao avb ON avb.seq_numer_avb = dd1.seq_numer_avb
        JOIN bilhet.TBIL_RELAC_TAXA_PROPOSTA e ON e.SEQ_NUMER_PRS = aa1.SEQ_NUMER_PRS
        JOIN pamais.tcrp_pessoa p ON p.cod_docum_pri = e.cod_cnpj_embarcador
    WHERE
        aa1.seq_numer_prs = p_seq_numer_prs
        AND dd1.seq_numer_fat IS NULL
        AND TRUNC(avb.dhr_embar) <= LAST_DAY(p_dat_fim_vig)
        AND cc1.NUM_TARIF = 91
        AND (
            (COALESCE(bb1.sta_agrega_filial, 'N') <> 'S' AND avb.COD_CNPJ_TOMADOR = e.COD_CNPJ_EMBARCADOR)
            OR
            (COALESCE(bb1.sta_agrega_filial, 'N') = 'S' AND SUBSTR(avb.COD_CNPJ_TOMADOR, 1, 8) = SUBSTR(e.COD_CNPJ_EMBARCADOR, 1, 8))
        )
    GROUP BY
        e.cod_cnpj_embarcador,
        p.nom_pesso,
        cc1.num_tarif;

    --
    SET v_step = 3;

    --
    --INSERE TARIFA COM TOTAL DE VIAGEM
    INSERT INTO bilhet.tbil_valor_soma_tipo_tar_embar (
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
        e.cod_cnpj_embarcador,
        p.nom_pesso AS nom_embarcador,
        92 AS num_tarif,
        'E' AS idt_premi,
        COUNT(DISTINCT(AVB.NUM_AVERB_PAM)) AS vlr_calcu,
        CURRENT TIMESTAMP AS dhr_alter,
        p_cod_user AS cod_user
    FROM
        bilhet.tbil_relac_visao_propt a
        INNER JOIN bilhet.tbil_vigencia_taxa_cliente bb1 ON bb1.num_seque_vig = a.num_seque_vig
        INNER JOIN bilhet.tbil_relac_taxa_proposta e ON e.num_seque_tar = bb1.num_seque_tar
        INNER JOIN bilhet.tbil_relac_averb_propt d ON d.seq_numer_avb = a.seq_numer_avb
            AND d.seq_numer_prs = a.seq_numer_prs
        INNER JOIN bilhet.tbil_averbacao avb ON avb.seq_numer_avb = d.seq_numer_avb
        LEFT JOIN pamais.tcrp_pessoa p ON p.cod_docum_pri = e.cod_cnpj_embarcador
    WHERE
        a.seq_numer_prs = p_seq_numer_prs
        AND d.seq_numer_fat IS NULL
        AND TRUNC(avb.dhr_embar) <= LAST_DAY(p_dat_fim_vig)
    GROUP BY
        e.cod_cnpj_embarcador,
        p.nom_pesso,
        bb1.sta_agrega_filial,
        avb.cod_cnpj_tomador
    HAVING
        (COALESCE(bb1.sta_agrega_filial, 'N') <> 'S' AND e.cod_cnpj_embarcador = avb.cod_cnpj_tomador)
        OR
        (COALESCE(bb1.sta_agrega_filial, 'N') = 'S' AND SUBSTR(e.cod_cnpj_embarcador, 1, 8) = SUBSTR(avb.cod_cnpj_tomador, 1, 8));
    
    --
    SET v_step = 4;

    --
    --INSERE TARIFA COM VALOR TOTAL DE MERCADORIA EMBARCADOR
        INSERT INTO bilhet.tbil_valor_soma_tipo_tar_embar (
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
            e.cod_cnpj_embarcador,
            p.nom_pesso AS nom_embarcador,
            93 AS num_tarif,
            'E' AS idt_premi,
            NVL(SUM(d.vlr_is), 0) AS vlr_calcu,
            CURRENT TIMESTAMP AS dhr_alter,
            p_cod_user AS cod_user
        FROM
            bilhet.tbil_relac_visao_propt a
            INNER JOIN bilhet.tbil_vigencia_taxa_cliente bb1
                ON bb1.num_seque_vig = a.num_seque_vig
            INNER JOIN bilhet.tbil_relac_taxa_proposta e
                ON e.num_seque_tar = bb1.num_seque_tar
            INNER JOIN bilhet.tbil_relac_averb_propt d
                ON d.seq_numer_avb = a.seq_numer_avb
                AND d.seq_numer_prs = a.seq_numer_prs
            INNER JOIN bilhet.tbil_averbacao avb
                ON avb.seq_numer_avb = d.seq_numer_avb
            LEFT JOIN pamais.tcrp_pessoa p
                ON p.cod_docum_pri = e.cod_cnpj_embarcador
        WHERE
            a.seq_numer_prs = p_seq_numer_prs
            AND d.seq_numer_fat IS NULL
            AND TRUNC(avb.dhr_embar) <= LAST_DAY(p_dat_fim_vig)
            AND e.num_tarif = 91
            AND (
                (COALESCE(bb1.sta_agrega_filial, 'N') <> 'S'
                 AND avb.cod_cnpj_tomador = e.cod_cnpj_embarcador)
                OR
                (COALESCE(bb1.sta_agrega_filial, 'N') = 'S'
                 AND SUBSTR(avb.cod_cnpj_tomador, 1, 8) = SUBSTR(e.cod_cnpj_embarcador, 1, 8))
            )
        GROUP BY
            e.cod_cnpj_embarcador,
            p.nom_pesso;

    --
    SET v_step = 5;

    --INSERE TAXA MEDIA EMBARCADOR(ROUND( (v_premio_base_embarcador / v_total_mercadoria) * 100, 4))
    INSERT
       INTO    bilhet.tbil_valor_soma_tipo_tar_embar
            (
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
       x.nom_embarcador,
       94,
       'E',
       Round(x.premio_base_embarcador / x.total_mercadoria_embarcador * 100, 4),
       CURRENT TIMESTAMP,
       p_cod_user
    FROM    (
       SELECT
           DISTINCT a.cod_cnpj_embarcador AS cod_cnpj_embarcador,
           (
           SELECT
               nom_pesso
           FROM            pamais.tcrp_pessoa
           WHERE            cod_docum_pri = a.cod_cnpj_embarcador) AS nom_embarcador,
           Round(
                                                (
                                                SELECT vlr_calcu
                                                FROM bilhet.tbil_valor_soma_tipo_tar_embar
                                                WHERE num_tarif = 91
                                                AND COALESCE(bb1.sta_agrega_filial, 'N') <> 'S'
                                                AND seq_numer_fat = p_seq_numer_fat
                                                AND cod_cnpj_embarcador = a.cod_cnpj_embarcador), 4) AS premio_base_embarcador,
           Round(
                                                (
                                                SELECT vlr_calcu
                                                FROM bilhet.tbil_valor_soma_tipo_tar_embar
                                                WHERE num_tarif = 93
                                                AND COALESCE(bb1.sta_agrega_filial, 'N') <> 'S'
                                                AND seq_numer_fat = p_seq_numer_fat
                                                AND cod_cnpj_embarcador = a.cod_cnpj_embarcador), 4) AS total_mercadoria_embarcador
       FROM        bilhet.tbil_relac_taxa_proposta a,
           bilhet.tbil_valor_soma_tipo_tar_embar b,
           bilhet.tbil_vigencia_taxa_cliente bb1
       WHERE        a.seq_numer_prs = p_seq_numer_prs
           AND b.seq_numer_fat = p_seq_numer_fat
           AND COALESCE(bb1.sta_agrega_filial, 'N') <> 'S'
               AND bb1.num_seque_tar = a.num_seque_tar
               AND a.cod_cnpj_embarcador = b.cod_cnpj_embarcador
       UNION
           SELECT
               DISTINCT a.cod_cnpj_embarcador AS cod_cnpj_embarcador,
               (
               SELECT
                   nom_pesso
               FROM                pamais.tcrp_pessoa
               WHERE                cod_docum_pri = a.cod_cnpj_embarcador) AS nom_embarcador,
               Round(
                                                (
                                                SELECT vlr_calcu
                                                FROM bilhet.tbil_valor_soma_tipo_tar_embar
                                                WHERE num_tarif = 91
                                                AND COALESCE(bb1.sta_agrega_filial, 'N') = 'S'
                                                AND seq_numer_fat = p_seq_numer_fat
                                                AND Substr(cod_cnpj_embarcador, 1, 8) = Substr(a.cod_cnpj_embarcador, 1, 8)), 4) AS premio_base_embarcador,
               Round(
                                                (
                                                SELECT vlr_calcu
                                                FROM bilhet.tbil_valor_soma_tipo_tar_embar
                                                WHERE num_tarif = 93
                                                AND COALESCE(bb1.sta_agrega_filial, 'N') = 'S'
                                                AND seq_numer_fat = p_seq_numer_fat
                                                AND Substr(cod_cnpj_embarcador, 1, 8) = Substr(a.cod_cnpj_embarcador, 1, 8)), 4) AS total_mercadoria_embarcador
           FROM            bilhet.tbil_relac_taxa_proposta a,
               bilhet.tbil_valor_soma_tipo_tar_embar b,
               bilhet.tbil_vigencia_taxa_cliente bb1
           WHERE            a.seq_numer_prs = p_seq_numer_prs
               AND b.seq_numer_fat = p_seq_numer_fat
               AND COALESCE(bb1.sta_agrega_filial, 'N') = 'S'
                   AND bb1.num_seque_tar = a.num_seque_tar
                   AND Substr(a.cod_cnpj_embarcador, 1, 8) = Substr(b.cod_cnpj_embarcador, 1, 8) )x
    GROUP BY
       x.cod_cnpj_embarcador,
       x.nom_embarcador,
       x.premio_base_embarcador,
       x.total_mercadoria_embarcador;

    --
    SET v_step = 6;

    --
    --VERIFICA SE FATURA TEM TAXA EMBARCADOR
    SET v_tem_taxa_embarcador =
    (
    SELECT
       count(1)
    FROM    bilhet.tbil_valor_soma_tipo_tar_embar
    WHERE    seq_numer_fat = p_seq_numer_fat
       AND num_tarif = 91);


    IF v_tem_taxa_embarcador > 0 THEN

    SET v_tem_premio_comercial = (
    SELECT
       count(1)
    FROM    bilhet.tbil_valor_soma_tipo_tarifa
    WHERE    seq_numer_fat = p_seq_numer_fat
       AND num_tarif = 16 );


    IF v_tem_premio_comercial > 0 THEN

    INSERT
       INTO    bilhet.tbil_valor_soma_tipo_tar_embar
            (
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
       '00000000000000',
       'DEMAIS EMBARQUES',
       91,
       'E',
       vlr,
       CURRENT TIMESTAMP,
       p_cod_user
    FROM    (
       SELECT
           a1.vlr_calcu AS vlr
       FROM        bilhet.tbil_valor_soma_tipo_tarifa a1
       WHERE        seq_numer_fat = p_seq_numer_fat
           AND a1.num_tarif = 16
          );

    ELSE  

    INSERT
       INTO    bilhet.tbil_valor_soma_tipo_tar_embar
            (
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
       '00000000000000',
       'DEMAIS EMBARQUES',
       91,
       'E',
       COALESCE(Sum(vlr), 0),
       CURRENT TIMESTAMP,
       p_cod_user
    FROM    (
       SELECT
           Sum(aa2.vlr_tarif_pec) vlr
       FROM        bilhet.tbil_relac_visao_percu_propt aa2,
           bilhet.tbil_tarif_percu_proposta bb2,
           bilhet.tbil_relac_tarifa_percurso cc2,
           bilhet.tbil_relac_averb_propt dd2,
           bilhet.tbil_averbacao avb
       WHERE        aa2.seq_numer_prs = p_seq_numer_prs
           AND dd2.seq_numer_fat IS NULL
           AND Trunc(avb.dhr_embar) <= Last_day(p_dat_fim_vig)
               AND cc2.num_tarif <> 91
               --NÃO CONTABILIZAR EMBARCADOR
               AND avb.seq_numer_avb = dd2.seq_numer_avb
               AND aa2.seq_numer_pec = bb2.seq_numer_pec
               AND cc2.num_tarif_pec = bb2.num_tarif_pec
               AND aa2.seq_numer_prs = dd2.seq_numer_prs
               AND aa2.seq_numer_avb = dd2.seq_numer_avb
           GROUP BY
               aa2.seq_numer_prs,
               cc2.num_tarif
       UNION
           SELECT
               Sum(aa1.vlr_tarif_prs) vlr
           FROM            bilhet.tbil_relac_visao_propt aa1,
               bilhet.tbil_vigencia_taxa_cliente bb1,
               bilhet.tbil_relac_taxa_proposta cc1,
               bilhet.tbil_relac_averb_propt dd1,
               bilhet.tbil_averbacao avb
           WHERE            aa1.seq_numer_prs = p_seq_numer_prs
               AND dd1.seq_numer_fat IS NULL
               AND Trunc(avb.dhr_embar) <= Last_day(p_dat_fim_vig)
                   AND cc1.num_tarif <> 91
                   --NÃO CONTABILIZAR EMBARCADOR
                   AND avb.seq_numer_avb = dd1.seq_numer_avb
                   AND cc1.num_seque_tar = bb1.num_seque_tar
                   AND aa1.num_seque_vig = bb1.num_seque_vig
                   AND aa1.seq_numer_prs = dd1.seq_numer_prs
                   AND aa1.seq_numer_avb = dd1.seq_numer_avb
               GROUP BY
                   aa1.seq_numer_prs,
                   cc1.num_tarif
           UNION
               SELECT
                   Sum(a1.vlr_tarif_pec) vlr
               FROM                bilhet.tbil_relac_visao_percu_padra a1,
                   bilhet.tbil_vigen_tarifa_percurso b1,
                   bilhet.tbil_relac_tarifa_percurso c1
               WHERE                a1.seq_numer_prs = p_seq_numer_prs
                   AND a1.ctl_vigen_pec = b1.ctl_vigen_pec
                   AND b1.num_tarif_pec = c1.num_tarif_pec
                   AND (
                                      a1.seq_numer_prs,
                   a1.seq_numer_avb,
                   c1.num_tarif) IN
                             (
                   SELECT
                       a.seq_numer_prs,
                       a.seq_numer_avb,
                       c.num_tarif
                   FROM                    bilhet.tbil_relac_visao_percu_padra a,
                       bilhet.tbil_vigen_tarifa_percurso b,
                       bilhet.tbil_relac_tarifa_percurso c,
                       bilhet.tbil_relac_averb_propt d,
                       bilhet.tbil_averbacao avb
                   WHERE                    a.seq_numer_prs = p_seq_numer_prs
                       AND d.seq_numer_fat IS NULL
                       AND Trunc(avb.dhr_embar) <= Last_day(p_dat_fim_vig)
                           AND avb.seq_numer_avb = d.seq_numer_avb
                           AND a.ctl_vigen_pec = b.ctl_vigen_pec
                           AND b.num_tarif_pec = c.num_tarif_pec
                           AND a.seq_numer_prs = d.seq_numer_prs
                           AND a.seq_numer_avb = d.seq_numer_avb
                   EXCEPT
                       SELECT
                           aa.seq_numer_prs,
                           aa.seq_numer_avb,
                           cc.num_tarif
                       FROM                        bilhet.tbil_relac_visao_percu_propt aa,
                           bilhet.tbil_tarif_percu_proposta bb,
                           bilhet.tbil_relac_tarifa_percurso cc,
                           bilhet.tbil_relac_averb_propt dd,
                           bilhet.tbil_averbacao avb
                       WHERE                        aa.seq_numer_prs = p_seq_numer_prs
                           AND dd.seq_numer_fat IS NULL
                           AND Trunc(avb.dhr_embar) <= Last_day(p_dat_fim_vig)
                               AND avb.seq_numer_avb = dd.seq_numer_avb
                               AND aa.seq_numer_pec = bb.seq_numer_pec
                               AND cc.num_tarif_pec = bb.num_tarif_pec
                               AND aa.seq_numer_prs = dd.seq_numer_prs
                               AND aa.seq_numer_avb = dd.seq_numer_avb
                       EXCEPT
                           SELECT
                               aax.seq_numer_prs,
                               aax.seq_numer_avb,
                               ccx.num_tarif
                           FROM                            bilhet.tbil_relac_visao_propt aax,
                               bilhet.tbil_vigencia_taxa_cliente bbx,
                               bilhet.tbil_relac_taxa_proposta ccx,
                               bilhet.tbil_relac_averb_propt ddx,
                               bilhet.tbil_averbacao avb
                           WHERE                            aax.seq_numer_prs = p_seq_numer_prs
                               AND ddx.seq_numer_fat IS NULL
                               AND Trunc(avb.dhr_embar) <= Last_day(p_dat_fim_vig)
                                   AND avb.seq_numer_avb = ddx.seq_numer_avb
                                   AND aax.num_seque_vig = bbx.num_seque_vig
                                   AND ccx.num_seque_tar = bbx.num_seque_tar
                                   AND aax.seq_numer_prs = ddx.seq_numer_prs
                                   AND aax.seq_numer_avb = ddx.seq_numer_avb )
               GROUP BY
                   a1.seq_numer_prs,
                   c1.num_tarif );

    END IF;

    --
    SET v_step = 7;

    --
    --INSERE TARIFA COM TOTAL DE VIAGEM
    INSERT
       INTO    bilhet.tbil_valor_soma_tipo_tar_embar
              (
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
       '00000000000000',
       'DEMAIS EMBARQUES',
       92,
       'E',
       COUNT(x.num_averb_pam),
       CURRENT TIMESTAMP,
       p_cod_user
    FROM    (
       SELECT
           DISTINCT avb.num_averb_pam,
           a.seq_numer_prs
       FROM        bilhet.tbil_relac_visao_percu_padra a,
           bilhet.tbil_vigen_tarifa_percurso b,
           bilhet.tbil_relac_tarifa_percurso c,
           bilhet.tbil_relac_averb_propt d,
           bilhet.tbil_averbacao avb
       WHERE        a.seq_numer_prs = p_seq_numer_prs
           AND d.seq_numer_fat IS NULL
           AND Trunc(avb.dhr_embar) <= Last_day(p_dat_fim_vig)
               AND avb.seq_numer_avb = d.seq_numer_avb
               AND a.ctl_vigen_pec = b.ctl_vigen_pec
               AND b.num_tarif_pec = c.num_tarif_pec
               AND a.seq_numer_prs = d.seq_numer_prs
               AND a.seq_numer_avb = d.seq_numer_avb
       EXCEPT
           SELECT
               DISTINCT avb.num_averb_pam,
               a.seq_numer_prs
           FROM            bilhet.tbil_relac_visao_percu_padra a,
               bilhet.tbil_vigen_tarifa_percurso b,
               bilhet.tbil_relac_tarifa_percurso c,
               bilhet.tbil_relac_averb_propt d,
               bilhet.tbil_averbacao avb,
               bilhet.tbil_relac_taxa_proposta e,
               bilhet.tbil_vigencia_taxa_cliente bb1
           WHERE            a.seq_numer_prs = p_seq_numer_prs
               AND d.seq_numer_fat IS NULL
               AND Trunc(avb.dhr_embar) <= Last_day(p_dat_fim_vig)
                   AND e.seq_numer_prs = a.seq_numer_prs
                   AND e.num_tarif = 91
                   AND avb.seq_numer_avb = d.seq_numer_avb
                   AND a.ctl_vigen_pec = b.ctl_vigen_pec
                   AND b.num_tarif_pec = c.num_tarif_pec
                   AND a.seq_numer_prs = d.seq_numer_prs
                   AND a.seq_numer_avb = d.seq_numer_avb
                   AND bb1.num_seque_tar = e.num_seque_tar
                   --INSTRUÇÃO QDO NÃO EMBARCADOR AGREGA FILIAIS
                   AND COALESCE(bb1.sta_agrega_filial, 'N') <> 'S'
                       AND e.cod_cnpj_embarcador = avb.cod_cnpj_tomador
               UNION
                   SELECT
                       DISTINCT avb.num_averb_pam,
                       a.seq_numer_prs
                   FROM                    bilhet.tbil_relac_visao_percu_padra a,
                       bilhet.tbil_vigen_tarifa_percurso b,
                       bilhet.tbil_relac_tarifa_percurso c,
                       bilhet.tbil_relac_averb_propt d,
                       bilhet.tbil_averbacao avb,
                       bilhet.tbil_relac_taxa_proposta e,
                       bilhet.tbil_vigencia_taxa_cliente bb1
                   WHERE                    a.seq_numer_prs = p_seq_numer_prs
                       AND d.seq_numer_fat IS NULL
                       AND Trunc(avb.dhr_embar) <= Last_day(p_dat_fim_vig)
                           AND e.seq_numer_prs = a.seq_numer_prs
                           AND e.num_tarif = 91
                           AND avb.seq_numer_avb = d.seq_numer_avb
                           AND a.ctl_vigen_pec = b.ctl_vigen_pec
                           AND b.num_tarif_pec = c.num_tarif_pec
                           AND a.seq_numer_prs = d.seq_numer_prs
                           AND a.seq_numer_avb = d.seq_numer_avb
                           AND bb1.num_seque_tar = e.num_seque_tar
                           --INSTRUÇÃO QDO EMBARCADOR AGREGA FILIAIS
                           AND COALESCE(bb1.sta_agrega_filial, 'N') = 'S'
                               AND Substr(e.cod_cnpj_embarcador, 1, 8) = Substr(avb.cod_cnpj_tomador, 1, 8) ) x;

    --GROUP BY x.seq_numer_prs;

    --
    SET v_step = 8;

    --
    --INSERE TARIFA COM VALOR TOTAL DE MERCADORIA
    INSERT
       INTO    bilhet.tbil_valor_soma_tipo_tar_embar
              (
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
       '00000000000000',
       'DEMAIS EMBARQUES',
       93,
       'E',
       Nvl(Sum(x.vlr_is), 0),
       CURRENT TIMESTAMP,
       p_cod_user
    FROM    (
       SELECT
           DISTINCT d.seq_numer_prs,
           d.seq_numer_avb,
           d.vlr_is
       FROM        bilhet.tbil_relac_averb_propt d,
           bilhet.tbil_averbacao avb,
           bilhet.tbil_relac_visao_percu_padra c
       WHERE        d.seq_numer_prs = p_seq_numer_prs
           AND d.seq_numer_fat IS NULL
           AND Trunc(avb.dhr_embar) <= Last_day(p_dat_fim_vig)
               AND avb.seq_numer_avb = d.seq_numer_avb
               AND d.seq_numer_prs = c.seq_numer_prs
               AND d.seq_numer_avb = c.seq_numer_avb
       EXCEPT
           SELECT
               DISTINCT d.seq_numer_prs,
               d.seq_numer_avb,
               d.vlr_is
           FROM            bilhet.tbil_relac_averb_propt d,
               bilhet.tbil_averbacao avb,
               bilhet.tbil_relac_visao_percu_padra c,
               bilhet.tbil_relac_taxa_proposta a,
               bilhet.tbil_vigencia_taxa_cliente bb1
           WHERE            d.seq_numer_prs = p_seq_numer_prs
               AND d.seq_numer_fat IS NULL
               AND a.seq_numer_prs = d.seq_numer_prs
               AND a.num_tarif = 91
               AND a.cod_cnpj_embarcador IS NOT NULL
               AND Trunc(avb.dhr_embar) <= Last_day(p_dat_fim_vig)
                   AND avb.seq_numer_avb = d.seq_numer_avb
                   AND d.seq_numer_prs = c.seq_numer_prs
                   AND d.seq_numer_avb = c.seq_numer_avb
                   AND bb1.num_seque_tar = a.num_seque_tar
                   --INSTRUÇÃO QDO EMBARCADOR NAO AGREGA FILIAIS
                   AND COALESCE(bb1.sta_agrega_filial, 'N') <> 'S'
                       AND avb.cod_cnpj_tomador = a.cod_cnpj_embarcador
               UNION
                   SELECT
                       DISTINCT d.seq_numer_prs,
                       d.seq_numer_avb,
                       d.vlr_is
                   FROM                    bilhet.tbil_relac_averb_propt d,
                       bilhet.tbil_averbacao avb,
                       bilhet.tbil_relac_visao_percu_padra c,
                       bilhet.tbil_relac_taxa_proposta a,
                       bilhet.tbil_vigencia_taxa_cliente bb1
                   WHERE                    d.seq_numer_prs = p_seq_numer_prs
                       AND d.seq_numer_fat IS NULL
                       AND a.seq_numer_prs = d.seq_numer_prs
                       AND a.num_tarif = 91
                       AND a.cod_cnpj_embarcador IS NOT NULL
                       AND Trunc(avb.dhr_embar) <= Last_day(p_dat_fim_vig)
                           AND avb.seq_numer_avb = d.seq_numer_avb
                           AND d.seq_numer_prs = c.seq_numer_prs
                           AND d.seq_numer_avb = c.seq_numer_avb
                           AND bb1.num_seque_tar = a.num_seque_tar
                           --INSTRUÇÃO QDO EMBARCADOR AGREGA FILIAIS
                           AND COALESCE(bb1.sta_agrega_filial, 'N') = 'S'
                               AND Substr(avb.cod_cnpj_tomador, 1, 8) = Substr(a.cod_cnpj_embarcador, 1, 8) ) x;

    --
    SET v_step = 9;

    --
    INSERT INTO bilhet.tbil_valor_soma_tipo_tar_embar
            (
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
       '00000000000000',
       'DEMAIS EMBARQUES',
       94,
       'E',
       COALESCE(Round(x.premio_base_embarcador / NULLIF(x.total_mercadoria_embarcador, 0) * 100, 4), 0),
       CURRENT TIMESTAMP,
       p_cod_user
    FROM    (
       SELECT
           Round(
                                                (
                                                SELECT vlr_calcu
                                                FROM bilhet.tbil_valor_soma_tipo_tar_embar
                                                WHERE seq_numer_fat = p_seq_numer_fat
                                                AND num_tarif = 91
                                                AND cod_cnpj_embarcador = 00000000000000), 4) AS premio_base_embarcador,
           Round(
                                                (
                                                SELECT vlr_calcu
                                                FROM bilhet.tbil_valor_soma_tipo_tar_embar
                                                WHERE seq_numer_fat = p_seq_numer_fat
                                                AND num_tarif = 93
                                                AND cod_cnpj_embarcador = 00000000000000), 4) AS total_mercadoria_embarcador
       FROM        DUAL 
    )x
    GROUP BY
       x.premio_base_embarcador,
       x.total_mercadoria_embarcador;

    --
    END IF;

END IF;

--
SET v_step = 10;

--
-- SETANDO O STATUS DE FINALIZAÇÃO DA PROCEDURE
SET v_out_result = 0;

--
--
SET v_out_err_message = '';

--
--
END
