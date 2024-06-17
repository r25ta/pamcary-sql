/*CONSULTA PRAZOS POR PRAÇAS -- OPERAÇÃO PAMCARY.PAMCARY*/
select p1.des_praca origem_praca
	, p1.num_latit origem_latit
	, p1.num_longi origem_longi
	, uf1.sig_unfed origem_uf
	, p2.des_praca destino_praca
	, p2.num_latit destino_latit
	, p2.num_longi destino_longi
	,uf2.sig_unfed destino_uf
	,t.des_prazo_tmp prazo_tipo 
	,a.num_prazo prazo_tempo
from supervisor.tprazo_entrega_mercadoria a
,supervisor.praca p1
,supervisor.unidade_federal uf1 
,supervisor.praca p2
,supervisor.unidade_federal uf2
,supervisor.ttipo_prazo_tempo t
where a.ctl_vincd = 108762
and a.cod_praca_ori = p1.cod_praca 
and a.cod_praca_des = p2.cod_praca 
and p1.cod_unfed = uf1.cod_unfed 
and p2.cod_unfed = uf2.cod_unfed 
and t.tip_prazo_tmp = a.tip_prazo 

