   SELECT
       cc2.num_tarif,
       SUM(aa2.vlr_tarif_pec) vlr
   FROM        bilhet.tbil_relac_visao_percu_propt aa2,
       bilhet.tbil_tarif_percu_proposta bb2,
       bilhet.tbil_relac_tarifa_percurso cc2,
       bilhet.tbil_relac_averb_propt dd2,
       bilhet.tbil_averbacao avb
   WHERE        aa2.seq_numer_prs = 505036
       AND dd2.seq_numer_fat IS NULL
       AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31 23:59:59')
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
           cc1.num_tarif,
           bb1.num_seque_vig,
           cc1.num_seque_tar,
           SUM(aa1.vlr_tarif_prs) vlr
       FROM            bilhet.tbil_relac_visao_propt aa1,
           bilhet.tbil_vigencia_taxa_cliente bb1,
           bilhet.tbil_relac_taxa_proposta cc1,
           bilhet.tbil_relac_averb_propt dd1,
           bilhet.tbil_averbacao avb
       WHERE            aa1.seq_numer_prs = 505036
           AND dd1.seq_numer_fat IS NULL
           AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31 23:59:59')
               AND avb.seq_numer_avb = dd1.seq_numer_avb
               AND cc1.num_seque_tar = bb1.num_seque_tar
               AND aa1.num_seque_vig = bb1.num_seque_vig
               AND aa1.seq_numer_prs = dd1.seq_numer_prs
               AND aa1.seq_numer_avb = dd1.seq_numer_avb
           GROUP BY
               aa1.seq_numer_prs,
               cc1.num_tarif
               ,bb1.num_seque_vig
               , cc1.num_seque_tar
       UNION
           SELECT
               c1.num_tarif,
               SUM(a1.vlr_tarif_pec) vlr
           FROM                bilhet.tbil_relac_visao_percu_padra a1,
               bilhet.tbil_vigen_tarifa_percurso b1,
               bilhet.tbil_relac_tarifa_percurso c1
           WHERE                a1.seq_numer_prs = 505036
               AND a1.ctl_vigen_pec = b1.ctl_vigen_pec
               AND b1.num_tarif_pec = c1.num_tarif_pec
               AND (a1.seq_numer_prs,
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
               WHERE                    a.seq_numer_prs = 505036
                   AND d.seq_numer_fat IS NULL
                   AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31 23:59:59')
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
                   WHERE                        aa.seq_numer_prs = 505036
                       AND dd.seq_numer_fat IS NULL
                       AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31 23:59:59')
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
                       WHERE                            aax.seq_numer_prs = 505036
                           AND ddx.seq_numer_fat IS NULL
                           AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31 23:59:59')
                               AND avb.seq_numer_avb = ddx.seq_numer_avb
                               AND aax.num_seque_vig = bbx.num_seque_vig
                               AND ccx.num_seque_tar = bbx.num_seque_tar
                               AND aax.seq_numer_prs = ddx.seq_numer_prs
                               AND aax.seq_numer_avb = ddx.seq_numer_avb
			)
           GROUP BY
               a1.seq_numer_prs,
               c1.num_tarif