CREATE
PROCEDURE "BILHET"."SP_GERA_FATURA" (IN p_num_perio_fat    SMALLINT,
                                     IN p_competencia      DATE,
                                     IN p_cod_user         VARCHAR(50),
                                     IN p_ctl_contr_taf    BIGINT,
                                     OUT v_out_result      SMALLINT,
                                     OUT v_out_err_message VARCHAR(255))
  --result sets 1
  LANGUAGE SQL NOT DETERMINISTIC CALLED ON NULL input MODIFIES SQL DATA INHERIT special registers SPECIFIC sql160324164023000
BEGIN
  DECLARE v_dat_inici_vig       DATE;
  DECLARE v_dat_fim_vig         DATE;
  DECLARE v_num_perio           SMALLINT;
  DECLARE v_seq_numer_prs       BIGINT;
  DECLARE v_num_dia_vec         SMALLINT;
  DECLARE v_dat_venci           DATE;
  DECLARE v_comp                DATE;
  DECLARE v_propt_msg           VARCHAR(4000) DEFAULT '';
  DECLARE v_msg                 SMALLINT DEFAULT 0;
  DECLARE v_err_msg             VARCHAR(4000) DEFAULT '';
  DECLARE v_seq_numer_fat       BIGINT;
  DECLARE v_seq_numer_fat_filho BIGINT DEFAULT NULL;
  DECLARE v_linha               INTEGER DEFAULT 0;
  DECLARE v_num_mes_cpt         INTEGER;
  DECLARE v_step                INTEGER DEFAULT 0;
  DECLARE v_seq_gera_fat        SMALLINT DEFAULT 0;
  DECLARE v_rows_affected       BIGINT DEFAULT 0;
  DECLARE v_err_sqlstate        CHAR(5) DEFAULT '00000';
  DECLARE v_err_message         VARCHAR(255) DEFAULT '';
  DECLARE sqlcode               integer DEFAULT 0;
  DECLARE sqlstate              CHAR(5);
  DECLARE v_data_procs TIMESTAMP;
  DECLARE v_grupo_seq BIGINT;
  DECLARE v_count     BIGINT;
  DECLARE EXIT HANDLER FOR sqlexception P1:
BEGIN
  SET v_err_sqlstate = sqlstate;
  SET v_err_message = 'ERRO PROC: SP_GERA_FATURA - Passo: ' CONCAT Rtrim(Ltrim(CHAR(v_step))) CONCAT ' - Linha: ' CONCAT v_linha CONCAT ' - SQLSTATE:' CONCAT v_err_sqlstate CONCAT ' -SQLCODE' CONCAT ' : ' CONCAT sqlcode;
  SET v_out_result = -1;
  SET v_out_err_message = v_err_message;
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs,
                          seq_numer_fat
              )
              VALUES
              (
                          'xx',
                          'SQLEXCEPTION - vai abrir bilhet.sp_estorno_procs_fatura - '
                                      CONCAT v_err_message,
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          v_seq_gera_fat,
                          v_seq_numer_prs,
                          v_seq_numer_fat
              );
  
  CALL bilhet.sp_estorno_procs_fatura (p_ctl_contr_taf, v_msg, v_err_msg);
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs,
                          seq_numer_fat
              )
              VALUES
              (
                          'xx',
                          'SQLEXCEPTION - vai abrir gedad.sp_dad_finaliza_tarefa_conco - '
                                      CONCAT v_err_message,
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          v_seq_gera_fat,
                          v_seq_numer_prs,
                          v_seq_numer_fat
              );
  
  CALL gedad.sp_dad_finaliza_tarefa_conco(p_ctl_contr_taf, v_msg, v_err_msg);
  COMMIT;
END p1;
DECLARE GLOBAL temporary TABLE SESSION.cursor_proposta
                               (
                                                              seq_numer_prs bigint,
                                                              num_dia_vec   smallint,
                                                              ano_mes       bigint
                               )
ON COMMIT preserve ROWS WITH replace;

CREATE INDEX SESSION.idx_cursor_proposta
ON SESSION.cursor_proposta
             (
                          seq_numer_prs
             );

DELETE
FROM   SESSION.cursor_proposta;

SET v_dat_inici_vig = p_competencia;
SET v_dat_fim_vig = last_day(p_competencia);
SET v_seq_gera_fat = 0;
SET v_step = 1;
SET v_data_procs = CURRENT_TIMESTAMP;
SET v_grupo_seq = p_ctl_contr_taf;
INSERT INTO bilhet.log_bilhet
            (
                        tipo,
                        txt,
                        DATA,
                        seq,
                        num_grupo_seq,
                        seq_gera_fat
            )
            VALUES
            (
                        to_char(v_step),
                        'parametros - p_competencia: '
                                    || p_competencia
                                    || ' p_ctl_contr_taf:'
                                    || p_ctl_contr_taf
                                    || ' p_num_perio_fat:'
                                    || p_num_perio_fat
                                    || ' p_cod_user:'
                                    || p_cod_user ,
                        CURRENT_TIMESTAMP,
                        next VALUE FOR bilhet.seq,
                        v_grupo_seq,
                        0
            );

SET v_step = 2;
INSERT INTO bilhet.log_bilhet
            (
                        tipo,
                        txt,
                        DATA,
                        seq,
                        num_grupo_seq,
                        seq_gera_fat
            )
            VALUES
            (
                        to_char(v_step),
                        'vai calcular periodo',
                        CURRENT_TIMESTAMP,
                        next VALUE FOR bilhet.seq,
                        v_grupo_seq,
                        0
            );

IF (p_num_perio_fat = 1) THEN
  --1a QUINZENA
  SET v_num_perio = 2;
  --QUINZENAL
ELSEIF
  (p_num_perio_fat = 2) THEN
  --2a QUINZENA
  SET v_num_perio = 2;
  --QUINZENAL
ELSEIF
  (p_num_perio_fat = 3) THEN
  --MENSAL
  SET v_num_perio = 3;
  --MENSAL
END IF;
/* ================================================================================
SELECT * FROM BILHET.TBIL_PERIODO  SELECT * FROM BILHET.TBIL_PERIODO_FATURA
NUM_PERIO  NOM_PERIO                 NUM_PERIO_FAT  NOM_PERIO_FAT
---------  ---------                 -------------  -------------
1          SEMANAL                   1              1a QUINZENA
2          QUINZENAL                 2              2a QUINZENA
3          MENSAL                    3              MENSAL
4          DIÁRIO
================================================================================  */
/*  ================================================================================
CONSULTA CARREGAMENTO DA DATA DE VENCIMENTO DA FATURA. QUINZENAL DEVERÁ TER 2 REGISTROS
================================================================================
SELECT A.SEQ_NUMER_PRS, A.NUM_PERIO, C.NOM_PERIO_FAT, B.SEQ_NUMER_PRS
FROM BILHET.TBIL_PROPOSTA A
LEFT JOIN BILHET.TBIL_VENCIMENTO_FATURA_PROPT B ON B.SEQ_NUMER_PRS = A.SEQ_NUMER_PRS
LEFT JOIN BILHET.TBIL_PERIODO_FATURA C ON C.NUM_PERIO_FAT = B.NUM_PERIO_FAT
WHERE A.NUM_PERIO = 2
================================================================================ */
SET v_step = 3;
INSERT INTO bilhet.log_bilhet
            (
                        tipo,
                        txt,
                        DATA,
                        seq,
                        num_grupo_seq,
                        seq_gera_fat
            )
            VALUES
            (
                        to_char(v_step),
                        'vai abrir cursor - session.cursor_proposta',
                        CURRENT_TIMESTAMP,
                        next VALUE FOR bilhet.seq,
                        v_grupo_seq,
                        0
            );

INSERT INTO SESSION.cursor_proposta
            (
                        seq_numer_prs,
                        num_dia_vec,
                        ano_mes
            )
SELECT DISTINCT seq_numer_prs,
                num_dia_vec,
                ano_mes
FROM            (
                       SELECT a.seq_numer_prs,
                              num_dia_vec,
                              YEAR(b.dhr_embar)
                                     || RIGHT('0'
                                     || MONTH(b.dhr_embar), 2) AS ano_mes
                       FROM   bilhet.tbil_relac_averb_propt d,
                              bilhet.tbil_relac_visao_percu_propt a,
                              bilhet.tbil_averbacao b,
                              bilhet.tbil_proposta c,
                              bilhet.tbil_vencimento_fatura_propt e,
                              gedad.v_dad_consulta_procs_propt_bilhe f
                       WHERE  d.seq_numer_fat IS NULL
                       AND    f.ctl_contr_taf = p_ctl_contr_taf
                       AND    c.num_perio = v_num_perio
                       AND    e.num_perio_fat = p_num_perio_fat
                       AND    trunc(b.dhr_embar) <= last_day(v_dat_fim_vig)
                       AND    a.seq_numer_prs = d.seq_numer_prs
                       AND    a.seq_numer_avb = d.seq_numer_avb
                       AND    a.seq_numer_prs = c.seq_numer_prs
                       AND    a.seq_numer_avb = b.seq_numer_avb
                       AND    c.seq_numer_prs = e.seq_numer_prs
                       AND    f.seq_numer_prs = c.seq_numer_prs
                       UNION
                       SELECT aa.seq_numer_prs,
                              num_dia_vec,
                              YEAR(bb.dhr_embar)
                                     || RIGHT('0'
                                     || MONTH(bb.dhr_embar), 2) AS ano_mes
                       FROM   bilhet.tbil_relac_averb_propt dd,
                              bilhet.tbil_relac_visao_propt aa,
                              bilhet.tbil_averbacao bb,
                              bilhet.tbil_proposta cc,
                              bilhet.tbil_vencimento_fatura_propt ee,
                              gedad.v_dad_consulta_procs_propt_bilhe ff
                       WHERE  dd.seq_numer_fat IS NULL
                       AND    ff.ctl_contr_taf = p_ctl_contr_taf
                       AND    cc.num_perio = v_num_perio
                       AND    ee.num_perio_fat = p_num_perio_fat
                       AND    trunc(bb.dhr_embar) <= last_day(v_dat_fim_vig)
                       AND    aa.seq_numer_prs = dd.seq_numer_prs
                       AND    aa.seq_numer_avb = dd.seq_numer_avb
                       AND    aa.seq_numer_prs = cc.seq_numer_prs
                       AND    aa.seq_numer_avb = bb.seq_numer_avb
                       AND    cc.seq_numer_prs = ee.seq_numer_prs
                       AND    ff.seq_numer_prs = cc.seq_numer_prs
                       UNION
                       SELECT aaa.seq_numer_prs,
                              num_dia_vec,
                              YEAR(bbb.dhr_embar)
                                     || RIGHT('0'
                                     || MONTH(bbb.dhr_embar), 2) AS ano_mes
                       FROM   bilhet.tbil_relac_averb_propt ddd,
                              bilhet.tbil_relac_visao_percu_padra aaa,
                              bilhet.tbil_averbacao bbb,
                              bilhet.tbil_proposta ccc,
                              bilhet.tbil_vencimento_fatura_propt eee,
                              gedad.v_dad_consulta_procs_propt_bilhe fff
                       WHERE  ddd.seq_numer_fat IS NULL
                       AND    fff.ctl_contr_taf = p_ctl_contr_taf
                       AND    ccc.num_perio = v_num_perio
                       AND    eee.num_perio_fat = p_num_perio_fat
                       AND    trunc(bbb.dhr_embar) <= last_day(v_dat_fim_vig)
                       AND    aaa.seq_numer_prs = ddd.seq_numer_prs
                       AND    aaa.seq_numer_avb = ddd.seq_numer_avb
                       AND    aaa.seq_numer_prs = ccc.seq_numer_prs
                       AND    aaa.seq_numer_avb = bbb.seq_numer_avb
                       AND    ccc.seq_numer_prs = eee.seq_numer_prs
                       AND    fff.seq_numer_prs = ccc.seq_numer_prs) x
WHERE           x.ano_mes <= YEAR(v_dat_fim_vig)
                                || RIGHT('0'
                                || MONTH(v_dat_fim_vig), 2)
AND             (
                                seq_numer_prs, num_dia_vec, ano_mes) NOT IN
                (
                       SELECT a.seq_numer_prs,
                              num_dia_vec,
                              num_mes_cpt
                       FROM   bilhet.tbil_proposta b,
                              bilhet.tbil_fatura a,
                              bilhet.tbil_vencimento_fatura_propt c,
                              gedad.v_dad_consulta_procs_propt_bilhe f
                       WHERE  num_mes_cpt <= YEAR(v_dat_fim_vig)
                                     || RIGHT('0'
                                     || MONTH(v_dat_fim_vig), 2)
                       AND    sit_fatur IN (2,
                                            5)
                              --2 (PROCESSADA) 5 (PROCESSADA POR PRÊMIO MÍNIMO)
                       AND    b.num_perio = v_num_perio
                       AND    f.ctl_contr_taf = p_ctl_contr_taf
                       AND    a.num_perio_fat = p_num_perio_fat
                       AND    c.num_perio_fat = p_num_perio_fat
                       AND    a.seq_numer_prs = b.seq_numer_prs
                       AND    b.seq_numer_prs = c.seq_numer_prs
                       AND    f.seq_numer_prs = b.seq_numer_prs );

SET v_count =
(
       SELECT COUNT(*)
       FROM   SESSION.cursor_proposta);
IF v_count > 0 THEN
  SET v_step = 4;
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat
              )
              VALUES
              (
                          to_char(v_step),
                          'agrupado - session.cursor_proposta',
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          0
              );
  
  FOR w
AS
  SELECT   seq_numer_prs,
           max(num_dia_vec) AS num_dia_vec,
           max(ano_mes)     AS ano_mes,
           COUNT(*)         AS qtd_agrupado
  FROM     SESSION.cursor_proposta
  GROUP BY seq_numer_prs
  ORDER BY seq_numer_prs,
           ano_mes desc DO SET v_propt_msg = 'seq_numer_prs: '
                    || CHAR(w.seq_numer_prs)
                    || ' num_dia_vec: '
                    || CHAR(w.num_dia_vec)
                    || ' ano_mes: '
                    || CHAR(w.ano_mes)
                    || ' qtd_agrupado: '
                    || CHAR(qtd_agrupado);
  
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs
              )
              VALUES
              (
                          to_char(v_step),
                          v_propt_msg,
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          0,
                          w.seq_numer_prs
              );

END FOR;
FOR x
AS
  SELECT   seq_numer_prs,
           max(num_dia_vec) AS num_dia_vec,
           max(ano_mes)     AS ano_mes
  FROM     SESSION.cursor_proposta
  GROUP BY seq_numer_prs
  ORDER BY seq_numer_prs,
           ano_mes desc DO SET v_step = 5;
  
  SET v_seq_numer_fat = NULL;
  SET v_seq_numer_prs = x.seq_numer_prs;
  SET v_num_dia_vec = x.num_dia_vec;
  SET v_num_mes_cpt = x.ano_mes;
  SET v_seq_gera_fat = v_seq_gera_fat + 1;
  --insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat, seq_numer_prs) values (to_char(v_step),'laço session.cursor_proposta', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat, v_seq_numer_prs);
  SET v_comp = DATE(LEFT(v_num_mes_cpt, 4)
  || '-'
  || RIGHT(v_num_mes_cpt, 2)
  || '-01');
  IF (p_num_perio_fat = 1) THEN
    --1a QUINZENA
    SET v_dat_inici_vig = v_comp;
    SET v_dat_fim_vig = v_comp + 14 DAYS;
    SET v_num_perio = 2;
    --QUINZENAL
  ELSEIF
    (p_num_perio_fat = 2) THEN
    --2a QUINZENA
    SET v_dat_inici_vig = v_comp + 15 DAYS;
    SET v_dat_fim_vig = last_day(v_comp);
    SET v_num_perio = 2;
    --QUINZENAL
  ELSEIF
    (p_num_perio_fat = 3) THEN
    --MENSAL
    SET v_dat_inici_vig = v_comp;
    SET v_dat_fim_vig = last_day(v_comp);
    SET v_num_perio = 3;
    --MENSAL
  END IF;
  SET v_linha = v_linha + 1;
  IF coalesce(v_seq_numer_prs, 0) > 0 THEN
    SET v_step = 6;
    INSERT INTO bilhet.log_bilhet
                (
                            tipo,
                            txt,
                            DATA,
                            seq,
                            num_grupo_seq,
                            seq_gera_fat,
                            seq_numer_prs
                )
                VALUES
                (
                            to_char(v_step),
                            'v_seq_numer_prs - '
                                        || v_seq_numer_prs,
                            CURRENT_TIMESTAMP,
                            next VALUE FOR bilhet.seq,
                            v_grupo_seq,
                            v_seq_gera_fat,
                            v_seq_numer_prs
                );
    
    SET v_step = 7;
    SET v_dat_venci = bilhet.fc_bil_data_vencimento (v_seq_numer_prs, p_num_perio_fat, v_comp, 'FATURA');
    INSERT INTO bilhet.log_bilhet
                (
                            tipo,
                            txt,
                            DATA,
                            seq,
                            num_grupo_seq,
                            seq_gera_fat,
                            seq_numer_prs,
                            num_perio_fat,
                            dat_inici_vig,
                            dat_fim_vig,
                            num_perio,
                            dat_venci
                )
                VALUES
                (
                            to_char(v_step),
                            'parâmetros iniciais',
                            CURRENT_TIMESTAMP,
                            next VALUE FOR bilhet.seq,
                            v_grupo_seq,
                            v_seq_gera_fat,
                            v_seq_numer_prs,
                            p_num_perio_fat,
                            v_dat_inici_vig,
                            v_dat_fim_vig,
                            v_num_perio,
                            v_dat_venci
                );
    
    /*
--select b.num_perio_fat,
--coalesce(bilhet.fc_dia_venci_prs(a.seq_numer_prs, b.num_perio_fat), 0),
--bilhet.fc_bil_data_vencimento (a.seq_numer_prs, b.num_perio_fat, date('01/01/2016'), 'fatura') dat_venci
--from bilhet.v_bil_proposta a
--inner join bilhet.tbil_vencimento_fatura_propt b on a.seq_numer_prs = b.seq_numer_prs
--where b.num_perio_fat in (1, 2 )
IF v_num_dia_vec > 30 THEN
SET v_step = 7;
insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat, seq_numer_prs) values (to_char(v_step),'v_num_dia_vec > 30 ', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat, v_seq_numer_prs);
SET v_dat_venci = (SELECT CASE WHEN
DAY((v_comp + 1 MONTH + (v_num_dia_vec/30) MONTHS) + (MOD(v_num_dia_vec,30)) DAYS - 1 DAY) = 31 THEN
DATE(v_comp + 1 MONTH + (v_num_dia_vec/30) MONTHS) + (MOD(v_num_dia_vec,30)) DAYS - 2 DAY
ELSE
DATE(v_comp + 1 MONTH + (v_num_dia_vec/30) MONTHS) + (MOD(v_num_dia_vec,30)) DAYS - 1 DAY END RESULT
FROM DBPROD.dual);
ELSE
SET v_step = 7;
insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat, seq_numer_prs) values (to_char(v_step),'v_num_dia_vec <= 30 ', CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat, v_seq_numer_prs);
--Essa condição é apenas para o mês de competência Janeiro com vencimento para Fevereiro
IF RIGHT(v_num_mes_cpt, 2) = '01' AND v_num_dia_vec IN ( 29, 30 ) THEN
SET v_dat_venci = LAST_DAY(DATE(v_comp + 1 MONTH));
ELSE
SET v_dat_venci = DATE(v_comp + 1 MONTH + v_num_dia_vec DAYS - 1 DAY);
END IF;
END IF;
SET v_step = 8;
insert into bilhet.log_bilhet (tipo, txt, data, seq, num_grupo_seq, seq_gera_fat, seq_numer_prs) values (to_char(v_step),'v_dat_venci '||to_char(v_dat_venci,'dd/mm/yyyy'), CURRENT_TIMESTAMP, next value for bilhet.seq, v_grupo_seq, v_seq_gera_fat, v_seq_numer_prs);
*/
    SET v_step = 9;
    SET v_seq_numer_fat =
    (
           SELECT coalesce(seq_numer_fat, 0)
           FROM   FINAL TABLE
                  (
                              INSERT INTO bilhet.tbil_fatura
                                          (
                                                      dhr_fatur,
                                                      seq_numer_prs,
                                                      dat_venci_fat,
                                                      num_mes_cpt,
                                                      sit_fatur,
                                                      num_perio_fat,
                                                      dhr_alter,
                                                      cod_user,
                                                      sit_envio_fat,
                                                      num_motiv_sit
                                          )
                                          VALUES
                                          (
                                                      v_data_procs,
                                                      v_seq_numer_prs,
                                                      v_dat_venci,
                                                      v_num_mes_cpt,
                                                      1,
                                                      p_num_perio_fat,
                                                      v_data_procs,
                                                      p_cod_user,
                                                      1,
                                                      5
                                          ))
    )
    ;
  END IF;
  SET v_step = 10;
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs,
                          seq_numer_fat
              )
              VALUES
              (
                          to_char(v_step),
                          'vai abrir bilhet.sp_gera_fatura_filho',
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          v_seq_gera_fat,
                          v_seq_numer_prs,
                          v_seq_numer_fat
              );
  
  CALL bilhet.sp_gera_fatura_filho(v_seq_numer_prs, v_seq_numer_fat, v_data_procs, v_dat_venci, v_num_mes_cpt, p_num_perio_fat, p_cod_user, v_dat_inici_vig, v_seq_numer_fat_filho, v_msg, v_err_msg);
  IF nvl(v_seq_numer_fat_filho, 0) > 0 THEN
    INSERT INTO bilhet.log_bilhet
                (
                            tipo,
                            txt,
                            DATA,
                            seq,
                            num_grupo_seq,
                            seq_gera_fat,
                            seq_numer_prs,
                            seq_numer_fat
                )
                VALUES
                (
                            to_char(v_step),
                            'gerou fatura filho seq_numer_fat_filho - '
                                        || v_seq_numer_fat_filho,
                            CURRENT_TIMESTAMP,
                            next VALUE FOR bilhet.seq,
                            v_grupo_seq,
                            v_seq_gera_fat,
                            v_seq_numer_prs,
                            v_seq_numer_fat
                );
  
  END IF;
  SET v_step = 10;
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs,
                          seq_numer_fat
              )
              VALUES
              (
                          to_char(v_step),
                          'vai abrir bilhet.sp_atualiza_visao_propt: ',
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          v_seq_gera_fat,
                          v_seq_numer_prs,
                          v_seq_numer_fat
              );
  
  CALL bilhet.sp_atualiza_visao_propt ( v_seq_numer_prs, p_cod_user, v_msg, v_err_msg);
  SET v_step = 11;
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs,
                          seq_numer_fat
              )
              VALUES
              (
                          to_char(v_step),
                          'vai abrir tbil_valor_soma_tipo_tarifa: seq_numer_prs - '
                                      || v_seq_numer_prs
                                      || ' seq_numer_fat - '
                                      || v_seq_numer_fat
                                      || ' VIGÊNCIA: v_dat_inici_vig: '
                                      || to_char(v_dat_inici_vig, 'DD/MM/YYYY')
                                      || ' v_dat_fim_vig: '
                                      || to_char(v_dat_fim_vig, 'DD/MM/YYYY'),
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          v_seq_gera_fat,
                          v_seq_numer_prs,
                          v_seq_numer_fat
              );
  
  --INSERE TARIFAS COM VALORES DE: COMERCIAL DA PROPOSTA (NÃO PERCURSO) + COMERCIAL DA PROPOSTA (EM PERCURSO) + MERCADO (EM PERCURSO) EXCEPT COMERCIAL DA PROPOSTA (EM PERCURSO)
  INSERT INTO bilhet.tbil_valor_soma_tipo_tarifa
              (
                          seq_numer_fat,
                          num_tarif,
                          idt_premi,
                          vlr_calcu,
                          dhr_alter,
                          cod_user
              )
  SELECT   v_seq_numer_fat,
           num_tarif,
           'C',
           sum(vlr),
           v_data_procs,
           p_cod_user
  FROM     (
                    SELECT   cc2.num_tarif,
                             sum(aa2.vlr_tarif_pec) vlr
                    FROM     bilhet.tbil_relac_visao_percu_propt aa2,
                             bilhet.tbil_tarif_percu_proposta bb2,
                             bilhet.tbil_relac_tarifa_percurso cc2,
                             bilhet.tbil_relac_averb_propt dd2,
                             bilhet.tbil_averbacao avb
                    WHERE    aa2.seq_numer_prs = v_seq_numer_prs
                    AND      dd2.seq_numer_fat IS NULL
                    AND      trunc(avb.dhr_embar) <= last_day(v_dat_fim_vig)
                    AND      cc2.num_tarif <> 91
                             --NÃO CONTABILIZAR EMBARCADOR
                    AND      avb.seq_numer_avb = dd2.seq_numer_avb
                    AND      aa2.seq_numer_pec = bb2.seq_numer_pec
                    AND      cc2.num_tarif_pec = bb2.num_tarif_pec
                    AND      aa2.seq_numer_prs = dd2.seq_numer_prs
                    AND      aa2.seq_numer_avb = dd2.seq_numer_avb
                    GROUP BY aa2.seq_numer_prs,
                             cc2.num_tarif
                    UNION
                    SELECT   cc1.num_tarif,
                             sum(aa1.vlr_tarif_prs) vlr
                    FROM     bilhet.tbil_relac_visao_propt aa1,
                             bilhet.tbil_vigencia_taxa_cliente bb1,
                             bilhet.tbil_relac_taxa_proposta cc1,
                             bilhet.tbil_relac_averb_propt dd1,
                             bilhet.tbil_averbacao avb
                    WHERE    aa1.seq_numer_prs = v_seq_numer_prs
                    AND      dd1.seq_numer_fat IS NULL
                    AND      trunc(avb.dhr_embar) <= last_day(v_dat_fim_vig)
                    AND      cc1.num_tarif <> 91
                             --NÃO CONTABILIZAR EMBARCADOR
                    AND      avb.seq_numer_avb = dd1.seq_numer_avb
                    AND      cc1.num_seque_tar = bb1.num_seque_tar
                    AND      aa1.num_seque_vig = bb1.num_seque_vig
                    AND      aa1.seq_numer_prs = dd1.seq_numer_prs
                    AND      aa1.seq_numer_avb = dd1.seq_numer_avb
                    GROUP BY aa1.seq_numer_prs,
                             cc1.num_tarif
                    UNION
                    SELECT   c1.num_tarif,
                             sum(a1.vlr_tarif_pec) vlr
                    FROM     bilhet.tbil_relac_visao_percu_padra a1,
                             bilhet.tbil_vigen_tarifa_percurso b1,
                             bilhet.tbil_relac_tarifa_percurso c1
                    WHERE    a1.seq_numer_prs = v_seq_numer_prs
                    AND      a1.ctl_vigen_pec = b1.ctl_vigen_pec
                    AND      b1.num_tarif_pec = c1.num_tarif_pec
                    AND      (
                                      a1.seq_numer_prs, a1.seq_numer_avb, c1.num_tarif) IN
                             (
                                    SELECT a.seq_numer_prs,
                                           a.seq_numer_avb,
                                           c.num_tarif
                                    FROM   bilhet.tbil_relac_visao_percu_padra a,
                                           bilhet.tbil_vigen_tarifa_percurso b,
                                           bilhet.tbil_relac_tarifa_percurso c,
                                           bilhet.tbil_relac_averb_propt d,
                                           bilhet.tbil_averbacao avb
                                    WHERE  a.seq_numer_prs = v_seq_numer_prs
                                    AND    d.seq_numer_fat IS NULL
                                    AND    trunc(avb.dhr_embar) <= last_day(v_dat_fim_vig)
                                    AND    avb.seq_numer_avb = d.seq_numer_avb
                                    AND    a.ctl_vigen_pec = b.ctl_vigen_pec
                                    AND    b.num_tarif_pec = c.num_tarif_pec
                                    AND    a.seq_numer_prs = d.seq_numer_prs
                                    AND    a.seq_numer_avb = d.seq_numer_avb
                                    EXCEPT
                                    SELECT aa.seq_numer_prs,
                                           aa.seq_numer_avb,
                                           cc.num_tarif
                                    FROM   bilhet.tbil_relac_visao_percu_propt aa,
                                           bilhet.tbil_tarif_percu_proposta bb,
                                           bilhet.tbil_relac_tarifa_percurso cc,
                                           bilhet.tbil_relac_averb_propt dd,
                                           bilhet.tbil_averbacao avb
                                    WHERE  aa.seq_numer_prs = v_seq_numer_prs
                                    AND    dd.seq_numer_fat IS NULL
                                    AND    trunc(avb.dhr_embar) <= last_day(v_dat_fim_vig)
                                    AND    avb.seq_numer_avb = dd.seq_numer_avb
                                    AND    aa.seq_numer_pec = bb.seq_numer_pec
                                    AND    cc.num_tarif_pec = bb.num_tarif_pec
                                    AND    aa.seq_numer_prs = dd.seq_numer_prs
                                    AND    aa.seq_numer_avb = dd.seq_numer_avb
                                    EXCEPT
                                    SELECT aax.seq_numer_prs,
                                           aax.seq_numer_avb,
                                           ccx.num_tarif
                                    FROM   bilhet.tbil_relac_visao_propt aax,
                                           bilhet.tbil_vigencia_taxa_cliente bbx,
                                           bilhet.tbil_relac_taxa_proposta ccx,
                                           bilhet.tbil_relac_averb_propt ddx,
                                           bilhet.tbil_averbacao avb
                                    WHERE  aax.seq_numer_prs = v_seq_numer_prs
                                    AND    ddx.seq_numer_fat IS NULL
                                    AND    trunc(avb.dhr_embar) <= last_day(v_dat_fim_vig)
                                    AND    avb.seq_numer_avb = ddx.seq_numer_avb
                                    AND    aax.num_seque_vig = bbx.num_seque_vig
                                    AND    ccx.num_seque_tar = bbx.num_seque_tar
                                    AND    aax.seq_numer_prs = ddx.seq_numer_prs
                                    AND    aax.seq_numer_avb = ddx.seq_numer_avb )
                    GROUP BY a1.seq_numer_prs,
                             c1.num_tarif )
  GROUP BY num_tarif;
  
  SET v_step = 12;
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs,
                          seq_numer_fat
              )
              VALUES
              (
                          to_char(v_step),
                          'vai abrir tbil_valor_soma_tipo_tarifa - EM PERCURSO',
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          v_seq_gera_fat,
                          v_seq_numer_prs,
                          v_seq_numer_fat
              );
  
  --INSERE TARIFAS COM VALORES DE MERCADO (EM PERCURSO)
  INSERT INTO bilhet.tbil_valor_soma_tipo_tarifa
              (
                          seq_numer_fat,
                          num_tarif,
                          idt_premi,
                          vlr_calcu,
                          dhr_alter,
                          cod_user
              )
  SELECT   v_seq_numer_fat,
           c.num_tarif,
           'T',
           sum(a.vlr_tarif_pec),
           v_data_procs,
           p_cod_user
  FROM     bilhet.tbil_relac_visao_percu_padra a,
           bilhet.tbil_vigen_tarifa_percurso b,
           bilhet.tbil_relac_tarifa_percurso c,
           bilhet.tbil_relac_averb_propt d,
           bilhet.tbil_averbacao avb
  WHERE    a.seq_numer_prs = v_seq_numer_prs
  AND      d.seq_numer_fat IS NULL
  AND      trunc(avb.dhr_embar) <= last_day(v_dat_fim_vig)
  AND      avb.seq_numer_avb = d.seq_numer_avb
  AND      a.ctl_vigen_pec = b.ctl_vigen_pec
  AND      b.num_tarif_pec = c.num_tarif_pec
  AND      a.seq_numer_prs = d.seq_numer_prs
  AND      a.seq_numer_avb = d.seq_numer_avb
  GROUP BY a.seq_numer_prs,
           c.num_tarif;
  
  SET v_step = 13;
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs,
                          seq_numer_fat
              )
              VALUES
              (
                          to_char(v_step),
                          'vai abrir tbil_valor_soma_tipo_tarifa - VALOR TOTAL DE MERCADORIA: ',
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          v_seq_gera_fat,
                          v_seq_numer_prs,
                          v_seq_numer_fat
              );
  
  --INSERE TARIFA COM VALOR TOTAL DE MERCADORIA
  INSERT INTO bilhet.tbil_valor_soma_tipo_tarifa
              (
                          seq_numer_fat,
                          num_tarif,
                          idt_premi,
                          vlr_calcu,
                          dhr_alter,
                          cod_user
              )
  SELECT v_seq_numer_fat,
         69,
         'A',
         nvl(sum(x.vlr_is), 0),
         v_data_procs,
         p_cod_user
  FROM   (
                         SELECT DISTINCT d.seq_numer_prs,
                                         d.seq_numer_avb,
                                         d.vlr_is
                         FROM            bilhet.tbil_relac_averb_propt d,
                                         bilhet.tbil_averbacao avb,
                                         bilhet.tbil_relac_visao_percu_padra c
                         WHERE           d.seq_numer_prs = v_seq_numer_prs
                         AND             d.seq_numer_fat IS NULL
                         AND             trunc(avb.dhr_embar) <= last_day(v_dat_fim_vig)
                         AND             avb.seq_numer_avb = d.seq_numer_avb
                         AND             d.seq_numer_prs = c.seq_numer_prs
                         AND             d.seq_numer_avb = c.seq_numer_avb ) x ;
  
  SET v_step = 14;
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs,
                          seq_numer_fat
              )
              VALUES
              (
                          to_char(v_step),
                          'vai abrir tbil_valor_soma_tipo_tarifa - VALOR MERCADORIA SEM ISENCAO: ',
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          v_seq_gera_fat,
                          v_seq_numer_prs,
                          v_seq_numer_fat
              );
  
  --INSERE TARIFA COM VALOR TOTAL DE MERCADORIA SEM ISENCAO
  INSERT INTO bilhet.tbil_valor_soma_tipo_tarifa
              (
                          seq_numer_fat,
                          num_tarif,
                          idt_premi,
                          vlr_calcu,
                          dhr_alter,
                          cod_user
              )
  SELECT v_seq_numer_fat,
         79,
         'A',
         nvl(sum(x.vlr_is), 0),
         v_data_procs,
         p_cod_user
  FROM   (
                         SELECT DISTINCT d.seq_numer_prs,
                                         d.seq_numer_avb,
                                         d.vlr_is
                         FROM            bilhet.tbil_relac_averb_propt d,
                                         bilhet.tbil_averbacao avb,
                                         bilhet.tbil_relac_visao_percu_padra c
                         WHERE           d.seq_numer_prs = v_seq_numer_prs
                         AND             avb.tip_isenc_seg = 1
                         AND             d.seq_numer_fat IS NULL
                         AND             trunc(avb.dhr_embar) <= last_day(v_dat_fim_vig)
                         AND             avb.seq_numer_avb = d.seq_numer_avb
                         AND             d.seq_numer_prs = c.seq_numer_prs
                         AND             d.seq_numer_avb = c.seq_numer_avb ) x ;
  
  SET v_step = 15;
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs,
                          seq_numer_fat
              )
              VALUES
              (
                          to_char(v_step),
                          'vai abrir tbil_valor_soma_tipo_tarifa - QUANTIDADE TOTAL DE VIAGEM: ',
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          v_seq_gera_fat,
                          v_seq_numer_prs,
                          v_seq_numer_fat
              );
  
  --INSERE TARIFA COM TOTAL DE VIAGEM
  INSERT INTO bilhet.tbil_valor_soma_tipo_tarifa
              (
                          seq_numer_fat,
                          num_tarif,
                          idt_premi,
                          vlr_calcu,
                          dhr_alter,
                          cod_user
              )
  SELECT   v_seq_numer_fat,
           70,
           'A',
           COUNT(DISTINCT avb.num_averb_pam),
           v_data_procs,
           p_cod_user
  FROM     bilhet.tbil_relac_visao_percu_padra a,
           bilhet.tbil_vigen_tarifa_percurso b,
           bilhet.tbil_relac_tarifa_percurso c,
           bilhet.tbil_relac_averb_propt d,
           bilhet.tbil_averbacao avb
  WHERE    a.seq_numer_prs = v_seq_numer_prs
  AND      d.seq_numer_fat IS NULL
  AND      trunc(avb.dhr_embar) <= last_day(v_dat_fim_vig)
  AND      avb.seq_numer_avb = d.seq_numer_avb
  AND      a.ctl_vigen_pec = b.ctl_vigen_pec
  AND      b.num_tarif_pec = c.num_tarif_pec
  AND      a.seq_numer_prs = d.seq_numer_prs
  AND      a.seq_numer_avb = d.seq_numer_avb
  GROUP BY a.seq_numer_prs;
  
  IF v_linha > 0 THEN
    SET v_step = 16;
    INSERT INTO bilhet.log_bilhet
                (
                            tipo,
                            txt,
                            DATA,
                            seq,
                            num_grupo_seq,
                            seq_gera_fat,
                            seq_numer_prs,
                            seq_numer_fat
                )
                VALUES
                (
                            to_char(v_step),
                            'vai abrir bilhet.sp_gera_premio_base',
                            CURRENT_TIMESTAMP,
                            next VALUE FOR bilhet.seq,
                            v_grupo_seq,
                            v_seq_gera_fat,
                            v_seq_numer_prs,
                            v_seq_numer_fat
                );
    
    CALL bilhet.sp_gera_premio_base (v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, v_seq_numer_fat_filho, p_cod_user, v_msg, v_err_msg);
    IF v_msg = 0 THEN
      SET v_step = 17;
      INSERT INTO bilhet.log_bilhet
                  (
                              tipo,
                              txt,
                              DATA,
                              seq,
                              num_grupo_seq,
                              seq_gera_fat,
                              seq_numer_prs,
                              seq_numer_fat
                  )
                  VALUES
                  (
                              to_char(v_step),
                              'vai abrir bilhet.sp_gera_premio_tarifa - v_seq_numer_fat: '
                                          || v_seq_numer_fat,
                              CURRENT_TIMESTAMP,
                              next VALUE FOR bilhet.seq,
                              v_grupo_seq,
                              v_seq_gera_fat,
                              v_seq_numer_prs,
                              v_seq_numer_fat
                  );
      
      CALL bilhet.sp_gera_premio_tarifa (v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
      IF v_msg = 0 THEN
        SET v_step = 18;
        INSERT INTO bilhet.log_bilhet
                    (
                                tipo,
                                txt,
                                DATA,
                                seq,
                                num_grupo_seq,
                                seq_gera_fat,
                                seq_numer_prs,
                                seq_numer_fat
                    )
                    VALUES
                    (
                                to_char(v_step),
                                'vai abrir bilhet.sp_gera_taxa_pamtax',
                                CURRENT_TIMESTAMP,
                                next VALUE FOR bilhet.seq,
                                v_grupo_seq,
                                v_seq_gera_fat,
                                v_seq_numer_prs,
                                v_seq_numer_fat
                    );
        
        CALL bilhet.sp_gera_taxa_pamtax (v_dat_inici_vig, v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
        IF v_msg = 0 THEN
          SET v_step = 19;
          INSERT INTO bilhet.log_bilhet
                      (
                                  tipo,
                                  txt,
                                  DATA,
                                  seq,
                                  num_grupo_seq,
                                  seq_gera_fat,
                                  seq_numer_prs,
                                  seq_numer_fat
                      )
                      VALUES
                      (
                                  to_char(v_step),
                                  'vai abrir bilhet.sp_gera_premio_minimo',
                                  CURRENT_TIMESTAMP,
                                  next VALUE FOR bilhet.seq,
                                  v_grupo_seq,
                                  v_seq_gera_fat,
                                  v_seq_numer_prs,
                                  v_seq_numer_fat
                      );
          
          CALL bilhet.sp_gera_premio_minimo (v_dat_inici_vig, v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
          IF v_msg = 0 THEN
            SET v_step = 20;
            INSERT INTO bilhet.log_bilhet
                        (
                                    tipo,
                                    txt,
                                    DATA,
                                    seq,
                                    num_grupo_seq,
                                    seq_gera_fat,
                                    seq_numer_prs,
                                    seq_numer_fat
                        )
                        VALUES
                        (
                                    to_char(v_step),
                                    'vai abrir bilhet.sp_gera_desconto_comercial',
                                    CURRENT_TIMESTAMP,
                                    next VALUE FOR bilhet.seq,
                                    v_grupo_seq,
                                    v_seq_gera_fat,
                                    v_seq_numer_prs,
                                    v_seq_numer_fat
                        );
            
            CALL bilhet.sp_gera_desconto_comercial (v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, v_seq_numer_fat_filho, p_cod_user, v_msg, v_err_msg);
            IF v_msg = 0 THEN
              SET v_step = 21;
              INSERT INTO bilhet.log_bilhet
                          (
                                      tipo,
                                      txt,
                                      DATA,
                                      seq,
                                      num_grupo_seq,
                                      seq_gera_fat,
                                      seq_numer_prs,
                                      seq_numer_fat
                          )
                          VALUES
                          (
                                      to_char(v_step),
                                      'vai abrir bilhet.sp_gera_premio_comercial',
                                      CURRENT_TIMESTAMP,
                                      next VALUE FOR bilhet.seq,
                                      v_grupo_seq,
                                      v_seq_gera_fat,
                                      v_seq_numer_prs,
                                      v_seq_numer_fat
                          );
              
              CALL bilhet.sp_gera_premio_comercial (v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, v_seq_numer_fat_filho, p_cod_user, v_msg, v_err_msg);
              IF v_msg = 0 THEN
                SET v_step = 22;
                INSERT INTO bilhet.log_bilhet
                            (
                                        tipo,
                                        txt,
                                        DATA,
                                        seq,
                                        num_grupo_seq,
                                        seq_gera_fat,
                                        seq_numer_prs,
                                        seq_numer_fat
                            )
                            VALUES
                            (
                                        to_char(v_step),
                                        'vai abrir bilhet.sp_gera_credito_debito',
                                        CURRENT_TIMESTAMP,
                                        next VALUE FOR bilhet.seq,
                                        v_grupo_seq,
                                        v_seq_gera_fat,
                                        v_seq_numer_prs,
                                        v_seq_numer_fat
                            );
                
                CALL bilhet.sp_gera_credito_debito (v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
                IF v_msg = 0 THEN
                  SET v_step = 23;
                  INSERT INTO bilhet.log_bilhet
                              (
                                          tipo,
                                          txt,
                                          DATA,
                                          seq,
                                          num_grupo_seq,
                                          seq_gera_fat,
                                          seq_numer_prs,
                                          seq_numer_fat
                              )
                              VALUES
                              (
                                          to_char(v_step),
                                          'vai abrir bilhet.sp_gera_desconto_avaria',
                                          CURRENT_TIMESTAMP,
                                          next VALUE FOR bilhet.seq,
                                          v_grupo_seq,
                                          v_seq_gera_fat,
                                          v_seq_numer_prs,
                                          v_seq_numer_fat
                              );
                  
                  CALL bilhet.sp_gera_desconto_avaria (v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
                  IF v_msg = 0 THEN
                    SET v_step = 24;
                    INSERT INTO bilhet.log_bilhet
                                (
                                            tipo,
                                            txt,
                                            DATA,
                                            seq,
                                            num_grupo_seq,
                                            seq_gera_fat,
                                            seq_numer_prs,
                                            seq_numer_fat
                                )
                                VALUES
                                (
                                            to_char(v_step),
                                            'vai abrir bilhet.sp_gera_juros',
                                            CURRENT_TIMESTAMP,
                                            next VALUE FOR bilhet.seq,
                                            v_grupo_seq,
                                            v_seq_gera_fat,
                                            v_seq_numer_prs,
                                            v_seq_numer_fat
                                );
                    
                    CALL bilhet.sp_gera_juros (v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, v_seq_numer_fat_filho, p_cod_user, v_msg, v_err_msg);
                    IF v_msg = 0 THEN
                      SET v_step = 25;
                      INSERT INTO bilhet.log_bilhet
                                  (
                                              tipo,
                                              txt,
                                              DATA,
                                              seq,
                                              num_grupo_seq,
                                              seq_gera_fat,
                                              seq_numer_prs,
                                              seq_numer_fat
                                  )
                                  VALUES
                                  (
                                              to_char(v_step),
                                              'vai abrir bilhet.sp_gera_premio_liquido',
                                              CURRENT_TIMESTAMP,
                                              next VALUE FOR bilhet.seq,
                                              v_grupo_seq,
                                              v_seq_gera_fat,
                                              v_seq_numer_prs,
                                              v_seq_numer_fat
                                  );
                      
                      CALL bilhet.sp_gera_premio_liquido (v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, v_seq_numer_fat_filho, p_cod_user, v_msg, v_err_msg);
                      IF v_msg = 0 THEN
                        SET v_step = 26;
                        INSERT INTO bilhet.log_bilhet
                                    (
                                                tipo,
                                                txt,
                                                DATA,
                                                seq,
                                                num_grupo_seq,
                                                seq_gera_fat,
                                                seq_numer_prs,
                                                seq_numer_fat
                                    )
                                    VALUES
                                    (
                                                to_char(v_step),
                                                'vai abrir bilhet.sp_gera_taxa_agravacao',
                                                CURRENT_TIMESTAMP,
                                                next VALUE FOR bilhet.seq,
                                                v_grupo_seq,
                                                v_seq_gera_fat,
                                                v_seq_numer_prs,
                                                v_seq_numer_fat
                                    );
                        
                        CALL bilhet.sp_gera_taxa_agravacao (v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
                        IF v_msg = 0 THEN
                          SET v_step = 27;
                          INSERT INTO bilhet.log_bilhet
                                      (
                                                  tipo,
                                                  txt,
                                                  DATA,
                                                  seq,
                                                  num_grupo_seq,
                                                  seq_gera_fat,
                                                  seq_numer_prs,
                                                  seq_numer_fat
                                      )
                                      VALUES
                                      (
                                                  to_char(v_step),
                                                  'vai abrir bilhet.sp_gera_custo_averbacao',
                                                  CURRENT_TIMESTAMP,
                                                  next VALUE FOR bilhet.seq,
                                                  v_grupo_seq,
                                                  v_seq_gera_fat,
                                                  v_seq_numer_prs,
                                                  v_seq_numer_fat
                                      );
                          
                          CALL bilhet.sp_gera_custo_averbacao (v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
                          IF v_msg = 0 THEN
                            SET v_step = 28;
                            INSERT INTO bilhet.log_bilhet
                                        (
                                                    tipo,
                                                    txt,
                                                    DATA,
                                                    seq,
                                                    num_grupo_seq,
                                                    seq_gera_fat,
                                                    seq_numer_prs,
                                                    seq_numer_fat
                                        )
                                        VALUES
                                        (
                                                    to_char(v_step),
                                                    'vai abrir bilhet.sp_gera_iof_premio_total',
                                                    CURRENT_TIMESTAMP,
                                                    next VALUE FOR bilhet.seq,
                                                    v_grupo_seq,
                                                    v_seq_gera_fat,
                                                    v_seq_numer_prs,
                                                    v_seq_numer_fat
                                        );
                            
                            CALL bilhet.sp_gera_iof_premio_total (v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, v_seq_numer_fat_filho, p_cod_user, v_msg, v_err_msg);
                            IF v_msg = 0 THEN
                              SET v_step = 29;
                              INSERT INTO bilhet.log_bilhet
                                          (
                                                      tipo,
                                                      txt,
                                                      DATA,
                                                      seq,
                                                      num_grupo_seq,
                                                      seq_gera_fat,
                                                      seq_numer_prs,
                                                      seq_numer_fat
                                          )
                                          VALUES
                                          (
                                                      to_char(v_step),
                                                      'vai abrir bilhet.sp_gera_taxa_media',
                                                      CURRENT_TIMESTAMP,
                                                      next VALUE FOR bilhet.seq,
                                                      v_grupo_seq,
                                                      v_seq_gera_fat,
                                                      v_seq_numer_prs,
                                                      v_seq_numer_fat
                                          );
                              
                              CALL bilhet.sp_gera_taxa_media (v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
                              IF v_msg = 0 THEN
                                SET v_step = 30;
                                INSERT INTO bilhet.log_bilhet
                                            (
                                                        tipo,
                                                        txt,
                                                        DATA,
                                                        seq,
                                                        num_grupo_seq,
                                                        seq_gera_fat,
                                                        seq_numer_prs,
                                                        seq_numer_fat
                                            )
                                            VALUES
                                            (
                                                        to_char(v_step),
                                                        'vai abrir bilhet.sp_gera_premio_embarcador',
                                                        CURRENT_TIMESTAMP,
                                                        next VALUE FOR bilhet.seq,
                                                        v_grupo_seq,
                                                        v_seq_gera_fat,
                                                        v_seq_numer_prs,
                                                        v_seq_numer_fat
                                            );
                                
                                CALL bilhet.sp_gera_premio_embarcador (v_dat_fim_vig, v_seq_numer_prs, v_seq_numer_fat, p_cod_user, v_msg, v_err_msg);
                                IF v_msg = 0 THEN
                                  SET v_step = 31;
                                  INSERT INTO bilhet.log_bilhet
                                              (
                                                          tipo,
                                                          txt,
                                                          DATA,
                                                          seq,
                                                          num_grupo_seq,
                                                          seq_gera_fat,
                                                          seq_numer_prs,
                                                          seq_numer_fat
                                              )
                                              VALUES
                                              (
                                                          to_char(v_step),
                                                          'vai atualizar bilhet.tbil_averbacao_indice',
                                                          CURRENT_TIMESTAMP,
                                                          next VALUE FOR bilhet.seq,
                                                          v_grupo_seq,
                                                          v_seq_gera_fat,
                                                          v_seq_numer_prs,
                                                          v_seq_numer_fat
                                              );
                                  
                                  UPDATE bilhet.tbil_averbacao_indice
                                  SET    sit_trans = 9 ,
                                         dhr_alter = v_data_procs
                                  WHERE  num_averb_pam IN
                                         (
                                                SELECT num_averb_pam
                                                FROM   bilhet.tbil_averbacao a,
                                                       bilhet.tbil_relac_averb_propt b,
                                                       bilhet.tbil_relac_visao_percu_padra c
                                                WHERE  b.seq_numer_fat IS NULL
                                                AND    b.seq_numer_prs = v_seq_numer_prs
                                                AND    trunc(a.dhr_embar) <= last_day(v_dat_fim_vig)
                                                AND    a.seq_numer_avb = b.seq_numer_avb
                                                AND    b.seq_numer_prs = c.seq_numer_prs
                                                AND    b.seq_numer_avb = c.seq_numer_avb );
                                  
                                  SET v_step = 32;
                                  INSERT INTO bilhet.log_bilhet
                                              (
                                                          tipo,
                                                          txt,
                                                          DATA,
                                                          seq,
                                                          num_grupo_seq,
                                                          seq_gera_fat,
                                                          seq_numer_prs,
                                                          seq_numer_fat
                                              )
                                              VALUES
                                              (
                                                          to_char(v_step),
                                                          'vai atualizar bilhet.tbil_relac_averb_propt : v_seq_numer_fat - '
                                                                      || v_seq_numer_fat,
                                                          CURRENT_TIMESTAMP,
                                                          next VALUE FOR bilhet.seq,
                                                          v_grupo_seq,
                                                          v_seq_gera_fat,
                                                          v_seq_numer_prs,
                                                          v_seq_numer_fat
                                              );
                                  
                                  --ATUALIZA PROPOSTA X AVERBACAO COM O NUMERO DA FATURA GERADO E ETAPA DA AVERBACAO PARA FATURADA
                                  UPDATE bilhet.tbil_relac_averb_propt
                                  SET    seq_numer_fat = v_seq_numer_fat ,
                                         num_etapa_avb = 4
                                  WHERE  seq_numer_fat IS NULL
                                  AND    (
                                                seq_numer_prs, seq_numer_avb) IN
                                         (
                                                SELECT b.seq_numer_prs,
                                                       b.seq_numer_avb
                                                FROM   bilhet.tbil_averbacao a,
                                                       bilhet.tbil_relac_averb_propt b,
                                                       bilhet.tbil_relac_visao_percu_padra c,
                                                       gedad.v_dad_consulta_procs_propt_bilhe d
                                                WHERE  b.seq_numer_fat IS NULL
                                                AND    b.seq_numer_prs = v_seq_numer_prs
                                                AND    d.ctl_contr_taf = p_ctl_contr_taf
                                                AND    trunc(a.dhr_embar) <= last_day(v_dat_fim_vig)
                                                AND    a.seq_numer_avb = b.seq_numer_avb
                                                AND    b.seq_numer_prs = c.seq_numer_prs
                                                AND    b.seq_numer_avb = c.seq_numer_avb
                                                AND    d.seq_numer_prs = b.seq_numer_prs );
                                  
                                  SET v_step = 33;
                                  INSERT INTO bilhet.log_bilhet
                                              (
                                                          tipo,
                                                          txt,
                                                          DATA,
                                                          seq,
                                                          num_grupo_seq,
                                                          seq_gera_fat,
                                                          seq_numer_prs,
                                                          seq_numer_fat
                                              )
                                              VALUES
                                              (
                                                          to_char(v_step),
                                                          'vai atualizar bilhet.tbil_fatura : v_seq_numer_fat - '
                                                                      || v_seq_numer_fat,
                                                          CURRENT_TIMESTAMP,
                                                          next VALUE FOR bilhet.seq,
                                                          v_grupo_seq,
                                                          v_seq_gera_fat,
                                                          v_seq_numer_prs,
                                                          v_seq_numer_fat
                                              );
                                  
                                  --ATUALIZA FATURA PARA PROCESSADA
                                  UPDATE bilhet.tbil_fatura
                                  SET    sit_fatur = 2 ,
                                         cod_user = p_cod_user
                                  WHERE  seq_numer_fat = v_seq_numer_fat;
                                  
                                  SET v_step = 34;
                                  INSERT INTO bilhet.log_bilhet
                                              (
                                                          tipo,
                                                          txt,
                                                          DATA,
                                                          seq,
                                                          num_grupo_seq,
                                                          seq_gera_fat,
                                                          seq_numer_prs,
                                                          seq_numer_fat
                                              )
                                              VALUES
                                              (
                                                          to_char(v_step),
                                                          'insere bilhet.tbil_movim_fatura ',
                                                          CURRENT_TIMESTAMP,
                                                          next VALUE FOR bilhet.seq,
                                                          v_grupo_seq,
                                                          v_seq_gera_fat,
                                                          v_seq_numer_prs,
                                                          v_seq_numer_fat
                                              );
                                  
                                  INSERT INTO bilhet.tbil_movim_fatura
                                              (
                                                          seq_numer_fat,
                                                          num_tarif,
                                                          des_movim_fat,
                                                          cod_user,
                                                          dhr_alter
                                              )
                                              VALUES
                                              (
                                                          v_seq_numer_fat,
                                                          81,
                                                          to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy hh24:mi:ss'),
                                                          p_cod_user,
                                                          CURRENT_TIMESTAMP
                                              );
                                  
                                  IF nvl(v_seq_numer_fat_filho, 0) > 0 THEN
                                    INSERT INTO bilhet.tbil_movim_fatura
                                                (
                                                            seq_numer_fat,
                                                            num_tarif,
                                                            des_movim_fat,
                                                            cod_user,
                                                            dhr_alter
                                                )
                                                VALUES
                                                (
                                                            v_seq_numer_fat_filho,
                                                            81,
                                                            to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy hh24:mi:ss'),
                                                            p_cod_user,
                                                            CURRENT_TIMESTAMP
                                                );
                                  
                                  END IF;
                                END IF;
                              END IF;
                            END IF;
                          END IF;
                        END IF;
                      END IF;
                    END IF;
                  END IF;
                END IF;
              END IF;
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
  END IF;
  SET v_step = 35;
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs,
                          seq_numer_fat
              )
              VALUES
              (
                          to_char(v_step),
                          'vai abrir gedad.sp_dad_atuaz_tarefa_conco',
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          v_seq_gera_fat,
                          v_seq_numer_prs,
                          v_seq_numer_fat
              );
  
  CALL gedad.sp_dad_atuaz_tarefa_conco(p_ctl_contr_taf, v_seq_numer_prs, v_seq_numer_fat, v_out_result, v_out_err_message);
  SET v_step = 36;
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs,
                          seq_numer_fat
              )
              VALUES
              (
                          to_char(v_step),
                          'vai chamar o proximo cursor',
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          v_seq_gera_fat,
                          v_seq_numer_prs,
                          v_seq_numer_fat
              );
  
  SET v_seq_numer_fat = NULL;
  --RAISE_APPLICATION_ERROR(-20010, 'Testando ROLLBACK');
END FOR;
SET v_step = 37;
INSERT INTO bilhet.log_bilhet
            (
                        tipo,
                        txt,
                        DATA,
                        seq,
                        num_grupo_seq,
                        seq_gera_fat,
                        seq_numer_prs,
                        seq_numer_fat
            )
            VALUES
            (
                        to_char(v_step),
                        'fecha cursor com commit',
                        CURRENT_TIMESTAMP,
                        next VALUE FOR bilhet.seq,
                        v_grupo_seq,
                        v_seq_gera_fat,
                        v_seq_numer_prs,
                        v_seq_numer_fat
            );

ELSE
  INSERT INTO bilhet.log_bilhet
              (
                          tipo,
                          txt,
                          DATA,
                          seq,
                          num_grupo_seq,
                          seq_gera_fat,
                          seq_numer_prs,
                          seq_numer_fat
              )
              VALUES
              (
                          'xx',
                          'não existe calculada',
                          CURRENT_TIMESTAMP,
                          next VALUE FOR bilhet.seq,
                          v_grupo_seq,
                          v_seq_gera_fat,
                          v_seq_numer_prs,
                          v_seq_numer_fat
              );

END IF;
SET v_step = 38;
INSERT INTO bilhet.log_bilhet
            (
                        tipo,
                        txt,
                        DATA,
                        seq,
                        num_grupo_seq,
                        seq_gera_fat,
                        seq_numer_prs,
                        seq_numer_fat
            )
            VALUES
            (
                        to_char(v_step),
                        'vai abrir gedad.sp_dad_finaliza_tarefa_conco',
                        CURRENT_TIMESTAMP,
                        next VALUE FOR bilhet.seq,
                        v_grupo_seq,
                        v_seq_gera_fat,
                        v_seq_numer_prs,
                        v_seq_numer_fat
            );

CALL gedad.sp_dad_finaliza_tarefa_conco(p_ctl_contr_taf, v_msg, v_err_msg);
COMMIT;
SET v_out_result = 0;
SET v_out_err_message = sqlcode;
END