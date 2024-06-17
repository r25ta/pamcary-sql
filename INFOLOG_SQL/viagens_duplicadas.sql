select e.nome,pt.nsu, pt.id_viagem, to_char(pt.dt_pedido_transacao,'dd/mm/yyyy hh24:mi:ss'),
pt.valor, pt.pan, cd_transacao, er.DS_COMPLETA_ERRO, ps.ds_pedido_trans_status,
pd.lmt_transacao_taxa,pd.VALOR_TRANSACAO_TAXA,pd.PCT_TRANSACAO_TAXA
from viagem v, pedido_transacao pt, pedido_transacao_x_erro te, pedido_trans_erro er,
pedido_trans_status ps, empresa e, pedagio pd
where v.id_viagem=pt.id_viagem and te.nsu=pt.nsu and e.id_empresa=v.id_empresa
and pt.id_pedido_trans_status=ps.id_pedido_trans_status
and v.id_viagem=pd.id_viagem
and te.id_pedido_trans_erro=er.id_pedido_trans_erro
and pt.nsu_origem is null and cd_resposta=0 and pd.fg_transacao_taxa=0
order by to_char(pt.dt_pedido_transacao,'yyyymmdd hh24:mi:ss') desc
