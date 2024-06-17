/*Ativos na lista branca*/
select v.cod_placa as placa,
      t.des_opera_tip as operacao,
      d.cod_dispo_rst as dispositivo,
      c.des_conta_autotrac as conta,
      to_char(l.dhr_regis,'dd/mm/yyyy hh24:mi:ss') as entrada
--      p.ctl_plvia,
--      p.sit_plvia
from  inf_lista_branca l, 
      v_crp_veiculo v,
      tipo_operacao t,
      inf_dispositivo d,
      inf_conta_autotrac c,
--      inf_veicu_plano_viagem VP,
--      plano_viagem p,
      relac_veicu_vincd rv
where v.ctl_veicu = l.CTL_VEICU
and t.ctl_opera_tip = l.ctl_opera_tip
and d.ctl_dispo_rst = l.CTL_DISPO_RST
and c.ctl_conta_autotrac = l.CTL_CONTA_AUTOTRAC
and l.sta_ativo = 1
and VP.CTL_VEICU = l.ctl_veicu
and p.ctl_plvia = VP.CTL_plvia
and p.sit_plvia not in (0,1)
and rv.ctl_veicu = l.CTL_VEICU


select to_char(dhr_manut,'dd/mm/yyyy hh24:mi:ss'), v.* from inf_veicu_plano_viagem v
where ctl_plvia = 11403171

order by ctl_plvia desc
select * from v_crp_veiculo
where COD_PLACA = 'FEI1624'

select * from inf_dispositivo
where ctl_dispo_rst = 283658


where COD_DISPO_RST ='334190'


select to_char(dhr_regis,'dd/mm/yyyy hh24:mi:ss') ativacao,
       to_char(dhr_desat,'dd/mm/yyyy hh24:mi:ss') desativacao,
       sta_ativo,
       a.*
from inf_lista_branca a
where 1=1
and ctl_veicu =354690 
--and ctl_dispo_rst = 641709
order by a.CTL_LISTA_BRANCA desc



select * from v_crp_veiculo
where cod_placa = 'KGV2783';

select to_char(dhr_regis, 'YYYY-MM-DD HH24:MI:SS') dt, i.* from inf_int_condusit i where ctl_veicu = '354690' order by ctl_integ_cond desc;

select to_char(dhr_regis, 'YYYY-MM-DD HH24:MI:SS') ini, to_char(dhr_desat, 'YYYY-MM-DD HH24:MI:SS') fim, i.*
from inf_lista_branca i where ctl_veicu = '354690' order by ctl_lista_Branca desc;

select vd.*, d.cod_dispo_rst from inf_relac_veicu_dispo vd
inner join inf_dispositivo d on d.ctl_dispo_rst = vd.ctl_dispo_rst
where vd.ctl_veicu = 354690;



select * from inf_int_condusit
where nr_dispo = '999078'
order by dhr_regis desc

/*Ativos na lista branca e fora da lista de dedicados*/
select v.cod_placa as placa,
      l.ctl_veicu,
      t.des_opera_tip as operacao,
      d.cod_dispo_rst as dispositivo,
      c.des_conta_autotrac as conta,
      to_char(l.dhr_regis,'dd/mm/yyyy hh24:mi:ss') as entrada
--      ,p.ctl_plvia,
--      sp.des_situa
from  inf_lista_branca l, 
      v_crp_veiculo v,
      tipo_operacao t,
      inf_dispositivo d,
      inf_conta_autotrac c
--      ,inf_veicu_plano_viagem VP,
--      plano_viagem p,
--      situacao_plano_viagem sp
where v.ctl_veicu = l.CTL_VEICU
and t.ctl_opera_tip = l.ctl_opera_tip
and d.ctl_dispo_rst = l.CTL_DISPO_RST
and c.ctl_conta_autotrac = l.CTL_CONTA_AUTOTRAC
and l.sta_ativo = 1
--and VP.CTL_VEICU = l.ctl_veicu
--and p.ctl_plvia = VP.CTL_plvia
--and p.sit_plvia not in (0,1)
--and sp.sit_plvia = p.sit_plvia
and l.CTL_VEICU not in (select ctl_veicu from relac_veicu_vincd rv)


select * from situacao_plano_viagem


/*grava erros de comunicação com Condusit*/
select to_char(i.dhr_regis,'dd/mm/yyyy hh24:ss') regis,
      v.cod_placa,
      i.*
      ,T.DES_OPERA_TIP
from inf_int_condusit i,
      V_CRP_VEICULO V
      ,TIPO_OPERACAO T
where 1=1
and v.ctl_veicu = i.ctl_veicu
AND T.CTL_OPERA_TIP = I.CTL_OPERA_TIP
and i.nr_dispo in('253978') 
--and des_resp like '%"status":"404"%'
--and des_dados_envi like '%remove%'
order by dhr_regis desc

'326795','367377','340355','253978'

select to_char(dhr_event,'dd/mm/yyyy hh24:mi:ss'), des_event, num_latit, num_longi from monitora_terminal
where num_termn = '253978'



select * from inf_grupo_veicu_dedicado


select fc_vinculado_nom_guerr(v.ctl_vincd),
       fc_vinculado_nom_guerr(v.ctl_vincd_rld),
      v.*       
from relac_veicu_vincd v
where ctl_veicu in (299517)



select * from plano_viagem
where ctl_plvia = 11403171


select * from inf_relac_veicu_dispo_plano
where ctl_plvia = 11403171

641709

select to_char(dhr_alter,'dd/mm/yyyy hh24:mi:ss'), a.* 
from inf_relac_veicu_dispo a
where ctl_veicu = 299517

