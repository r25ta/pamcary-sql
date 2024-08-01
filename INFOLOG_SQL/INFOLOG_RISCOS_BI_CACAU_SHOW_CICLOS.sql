
/*VIAGENS ORDENADAS POR CICLO*/
WITH ordenacao AS (
    SELECT
		 v.cod_placa as placa
		,pv.ctl_plvia  as plvia
		,pv.ctl_remet as remet
		,pv.ctl_desti as desti
		,pv.dhr_plvia_ini as plvia_ini
		,pv.dhr_plvia_ter as plvia_ter
		,date_part('month', pv.dhr_plvia_ini) as mes
		,ROW_NUMBER() OVER (PARTITION BY   date_part('month', pv.dhr_plvia_ini) ORDER by pv.dhr_plvia_ini)  AS num_linha
    FROM
		plano_viagem pv 
		inner join supervisor.tinf_veicu_plano_viagem vp 
		on pv.ctl_plvia = vp.ctl_plvia 
		inner join pamais_prd.v_crp_veiculo v on v.ctl_veicu = vp.ctl_veicu --and vp.ord_veicu = 1 
		where pv.ctl_opera_tip = 522
		and v.cod_placa = 'CUI0J05'
		order by pv.ctl_plvia
)
SELECT
    FLOOR((num_linha - 1) / 2) AS ciclo
		,placa
		,plvia 
		,remet
		,desti
		,plvia_ini
		,plvia_ter
		,mes
FROM
    ordenacao
ORDER BY
    mes;

