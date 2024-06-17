select CTL_MONIT_CAO, num_termn, cod_docum, num_carta_pac, num_funca_col, to_char(dhr_passa_cao,'DD/MM/YYYY HH24:MI:SS'),
       ctl_plvia
from monitora_cartao_detalhe
where num_termn = 3480

SELECT * FROM MONITORA_CARTAO
WHERE 


SELECT MC.ctl_monit_cao, NVL(MC.num_versa_arq,0) AS num_versa_arq , MC.num_lote_arq,
    TO_CHAR(MC.dhr_gerac_arq,'DD/MM/YYYY HH24:MI:SS') AS dhr_gerac_arq, NVL(MC.qtd_regis_arq,0) AS qtd_regis_arq,
    MCD.num_seque_cao, MCD.num_seque_rgt, MCD.num_termn,
    MCD.num_seque_pas, MCD.cod_docum, FC_VINCULADO_NOM_GUERR(V.ctl_vincd) AS nom_guerr,
    MCD.num_carta_pac, MCD.num_funca_col,
	TO_CHAR(MCD.dhr_passa_cao,'DD/MM/YYYY HH24:MI:SS') AS dhr_passa_cao, MCD.ctl_plvia, MCD.sta_procs
FROM MONITORA_CARTAO MC, MONITORA_CARTAO_DETALHE MCD,
     DOC_VINCULADO DV, VINCULADO V
WHERE MC.ctl_monit_cao = MCD.ctl_monit_cao
AND MCD.cod_docum = DV.cod_docum
AND DV.ctl_vincd = V.ctl_vincd
AND MCD.num_termn = 3480
ORDER BY MCD.num_seque_pas DESC


SELECT distinct(MC.ctl_monit_cao), NVL(MC.num_versa_arq,0) AS num_versa_arq , MC.num_lote_arq,
TO_CHAR(MC.dhr_gerac_arq,'DD/MM/YYYY HH24:MI:SS') AS dhr_gerac_arq, NVL(MC.qtd_regis_arq,0) AS qtd_regis_arq,
MCD.num_seque_cao, MCD.num_seque_rgt, MCD.num_termn,
MCD.num_seque_pas, MCD.cod_docum, 
MCD.num_carta_pac, MCD.num_funca_col,
TO_CHAR(MCD.dhr_passa_cao,'DD/MM/YYYY HH24:MI:SS') AS dhr_passa_cao, MCD.ctl_plvia, MCD.sta_procs
FROM MONITORA_CARTAO MC, MONITORA_CARTAO_DETALHE MCD, DOC_VINCULADO DV
WHERE MC.ctl_monit_cao = MCD.ctl_monit_cao
AND MCD.cod_docum = DV.cod_docum
AND MCD.num_termn = 3480
ORDER BY MCD.num_seque_pas DESC


