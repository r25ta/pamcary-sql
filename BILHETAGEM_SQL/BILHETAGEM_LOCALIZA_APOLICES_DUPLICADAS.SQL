/*CAPTURA PROPOSTAS DUPLICADAS*/
SELECT A.SEQ_NUMER_PRS
	,A.NUM_APOLI 
	,A.NUM_PROPT 
	,A.NUM_RAMO_SEG 
	,A.CTL_PESSO_CLI
	,A.CTL_PEJUR_CIA
	,A.DAT_INICI_VIG
	,A.DAT_FIM_VIG 
	,A.DHR_ALTER 
FROM bilhet.TBIL_PROPOSTA A 
WHERE NUM_APOLI IN (
						SELECT NUM_APOLI
						FROM BILHET.TBIL_PROPOSTA tp
						WHERE NUM_APOLI <> 0
						AND CTL_PEJUR_CIA = A.CTL_PEJUR_CIA
						GROUP BY NUM_APOLI 
						HAVING  count(1) > 1 
					)
AND A.DAT_FIM_VIG > '2021-12-31'
ORDER BY A.NUM_APOLI 


SELECT * FROM bilhet.TBIL_PROPOSTA tp 
WHERE NUM_APOLI = 3836000007101


SELECT BILHET.FC_TARIFA_PROPT(507173, 75, '2023-05-31') FROM dual
SELECT bilhet.fc_tarifa_fatura(67999978732, 14, 'C') FROM dual
SELECT BILHET.FC_TARIFA_PROPT(67999978732, 75, '202305') FROM dual

SELECT
   NUM_TARIF, vlr_calcu
FROM    bilhet.tbil_valor_soma_tipo_tarifa
WHERE    seq_numer_fat = 67999978732 
   AND num_tarif = 90
   AND idt_premi = 'C'

   c.vlr_tarif * d.pce_multi_tar
FROM    bilhet.tbil_vigencia_taxa_cliente c,
   bilhet.tbil_relac_taxa_proposta b,
   bilhet.tbil_proposta a,
   bilhet.tbil_tipo_tarifa_proposta d
WHERE    d.num_tarif = p_num_tarif
   AND a.seq_numer_prs = p_seq_numer_prs
   AND c.vlr_tarif > 0
   AND p_competencia BETWEEN date(YEAR(c.dat_inici_vig)|| '-' || MONTH(c.dat_inici_vig)|| '-' || '01') AND c.dat_fim_vig
   AND a.seq_numer_prs = b.seq_numer_prs
   AND b.num_seque_tar = c.num_seque_tar
   AND d.num_tarif = b.num_tarif   
 
   
   
   
SELECT * FROM pamais.tcrp_unidade_federal

SELECT
   NVL(SUM(x.vlr_is), 0)
FROM    (
   SELECT
       DISTINCT d.seq_numer_prs,
       d.seq_numer_avb,
       d.vlr_is,
       c.vlr_tarif_pec,
       c.ctl_vigen_pec
   FROM        bilhet.tbil_relac_averb_propt d,
       bilhet.tbil_averbacao avb,
       bilhet.tbil_relac_visao_percu_padra c
   WHERE        d.seq_numer_prs = 507112
       --					AND d.seq_numer_fat IS NULL
       AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31')
           AND avb.seq_numer_avb = d.seq_numer_avb
           AND d.seq_numer_prs = c.seq_numer_prs
           AND d.seq_numer_avb = c.seq_numer_avb 
											) x   
											
SELECT * FROM bilhet.TBIL_VIGEN_TARIFA_PERCURSO tvtp 											