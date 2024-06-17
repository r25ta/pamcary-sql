select distinct num_model_vei, 
  nom_marca_vei,
  nom_model_vei,
  nom_tipo_vei,
  nom_categ_vei,
  NOM_TIPO_VEICU_INF
from v_crp_veiculo
order by nom_marca_vei
