select h.num_termn as num_termn, p.des_prove_tec as des_prove_tec, count(*) as pos_msg
from hist_log_monitora_terminal h, provedor_tecnologia p
where h.dhr_alter between to_date('20100601','yyyymmdd') and to_date('20100630','yyyymmdd') 
and p.ctl_prove_tec = h.ctl_prove_tec
group by num_termn, des_prove_tec
order by des_prove_tec


select p.des_prove_tec as des_prove_tec, count(h.CTL_PROVE_TEC) as pos_msg
from hist_log_monitora_terminal h, provedor_tecnologia p
where h.dhr_alter between to_date('20100601','yyyymmdd') and to_date('20100630','yyyymmdd') 
and p.ctl_prove_tec = h.ctl_prove_tec
group by p.des_prove_tec
order by des_prove_tec



select * from hist_log_monitora_terminal

SELECT COUNT(1) FROM HIST_LOG_MONITORA_TERMINAL
WHERE NUM_TERMN = 701326
AND dhr_alter between to_date('20100601','yyyymmdd') and to_date('20100630','yyyymmdd') 



select * from tipo_operacao
where des_opera_tip like '%BRASKEM%'

11 BRASKEM

228 BRASKEM CP

select * from doc_vinculado


SELECT * FROM vinculado
WHERE NOM_GUERR LIKE '%AGNALDO JOSÉ DA SILVA%'

UPDATE VINCULADO SET nom_guerr = 'AGNALDO JOSÉ DA SILVA', nom_vincd='AGNALDO JOSÉ DA SILVA'
WHERE CTL_VINCD = 365545

COMMIT

SELECT pv.ctl_plvia AS VIAGEM, 
dv.cod_docum AS DOCUMENTO,
fc_vinculado_nom_guerr(ctl_motot) AS MOTORISTA,
fc_vinculado_nom_guerr(ctl_remet) AS ORIGEM, 
fc_vinculado_nom_guerr(ctl_desti) AS DESTINO, 
fc_vinculado_nom_guerr(ctl_trnsp) AS TRANSP, 
to_char(dhr_inclu,'dd/mm/yyyy hh24:mi:ss') AS INCLUSÃO
FROM plano_viagem pv, doc_vinculado dv
WHERE pv.ctl_opera_tip = 11
and pv.sit_plvia <> 10
and dv.ctl_vincd = pv.ctl_motot
and pv.dhr_inclu BETWEEN to_date('20100601','yyyymmdd') and to_date('20100630','yyyymmdd')
ORDER BY MOTORISTA




select fc_vinculado_nom_guerr(ctl_ptopd), to_char(dhr_efeti_rea,'dd/mm/yyyy hh24:mi:ss'), to_char(dhr_previ_sis,'dd/mm/yyyy hh24:mi:ss'), ctl_parad, 
sit_fase_rea, r.* from roteiro_motorista r
where ctl_plvia = 2035848
order by num_seque


select to_char(dhr_inclu,'dd/mm/yyyy hh24:mi:ss'), n.* from nc_roteiro_motorista n
where ctl_rtmot = 15652307

select * from evento_indevido_plano_viagem
where ctl_plvia = 2035848

select * from plano_viagem
where ctl_plvia = 2035848


select * from posicao_dispositivo
where ctl_rtmot = 15652307


select to_char(dhr_alter,'dd/mm/yyyy hh24:mi:ss'), 
fc_vinculado_nom_guerr(ctl_ptopd),
to_char(dhr_efeti_rea,'dd/mm/yyyy hh24:mi:ss'), 
to_char(dhr_previ_sis,'dd/mm/yyyy hh24:mi:ss'), 
ctl_parad,
h.* from hist_alter_roteiro_motorista h
where ctl_plvia = 2035848
order by ctl_histo_alt



select * from HIST_LOG_monitora_terminal

select * from provedor_tecnologia

select p.des_prove_tec as PROVEDOR, count(h.ctl_prove_tec) AS QTDE
from hist_log_monitora_terminal h, provedor_tecnologia p
where p.ctl_prove_tec = h.ctl_prove_tec
and h.dhr_alter between to_date('08/07/2010 12:00:00','dd/mm/yyyy hh24:mi:ss') and to_date('08/07/2010 12:59:59','dd/mm/yyyy hh24:mi:ss')
group by p.des_prove_tec


COMUNICADOR
COMUNICADOR AUTOTRAC
COMUNICADOR KRONA


SELECT * FROM EVENTO_GERENCIADORA_RISCO



DECLARE
  TIP_PROC CHAR(200);
  DDATA1 VARCHAR2(200);
  DDATA2 VARCHAR2(200);
BEGIN
  TIP_PROC := '4';
  DDATA1 := '20100101000000';
  DDATA2 := '20100131235959';

  SUPERVISOR.PR_INTEGRACAO_BRASKEM_HIST(
    TIP_PROC => TIP_PROC,
    DDATA1 => DDATA1,
    DDATA2 => DDATA2
  );
END;
