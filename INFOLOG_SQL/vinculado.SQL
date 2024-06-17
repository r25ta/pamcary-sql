select  V.ctl_vincd, V.nom_gUerr, V.nom_vincd, DV.cod_docum
from vinculado V, doc_vinculado DV
where V.ctl_vincd = DV.ctl_vincd
and V.nom_guerr like '%DOURADA%'
AND V.cod_ativi = 8
