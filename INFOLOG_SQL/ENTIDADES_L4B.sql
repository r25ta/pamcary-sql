select RV.ctl_vincd_rld
,case
	when RV.ctl_vincd = 1595628 then 'L4B'
	else 'ENTIDADE NAO FAZ PARTE DA OPERACAO L4B'
end as OPERACAO 
,FC_VINCULADO_NOM_GUERR(RV.CTL_VINCD_RLD) as ENTIDADE

,(select
	CASE
		WHEN tip_relac = 1 then 'DESTINO'
		WHEN tip_relac = 2 then 'TRANSPORTADORA'
		WHEN tip_relac = 3 then 'ORIGEM'
		else  'USUARIO'
	end
	from
		supervisor.tipo_relacionamento
	where
		tip_relac = RV.tip_relac) as TIPO_RELACIONAMENTO

,(select cod_docum from supervisor.doc_vinculado where tip_docum <> 3 and ctl_vincd = RV.ctl_vincd_rld) as DOCUMENTO
,(select cod_clien_ext from supervisor.tref_vinculado_cliente where ctl_vincd = RV.ctl_vincd and ctl_vincd_rld = RV.ctl_vincd_rld) as COD_EXTERNO
from
	RELACIONAMENTO_VINCULADO RV inner join VINCULADO E
	on E.ctl_vincd = RV.ctl_vincd_rld
	inner join tipo_operacao O
	on O.ctl_vincd_emb = RV.ctl_vincd
	and O.ctl_opera_tip = 441
	
