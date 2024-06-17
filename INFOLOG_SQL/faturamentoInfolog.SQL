/*Remet e operacao */
select distinct(ctl_remet) as ctl_remet, ctl_opera_tip 
from plano_viagem 
where to_char(dhr_inclu, 'yyyymmdd') between '20040101' and '20040131' 
and sit_plvia <> 10 
and ctl_opera_tip in (3,20,21,22,23,25)
order by ctl_opera_tip, ctl_remet

/*Cnpj do pagador conforme operacao*/
    SELECT ctl_vincd_emb, fc_vinculado_documento(ctl_vincd_emb,1) AS cnpj_pag
    FROM tipo_operacao
    WHERE ctl_opera_tip = 3
    
 /*transportadora*/        
 select distinct(ctl_trnsp) as ctl_trnsp, fc_vinculado_documento(ctl_trnsp,1) as doc_trnsp, fc_vinculado_nom_guerr(ctl_trnsp) as trnsp
    from plano_viagem
    where to_char(dhr_inclu, 'yyyymmdd') between '20040101' and '20040131'
    and sit_plvia <> 10
    and ctl_opera_tip = 3
    and ctl_remet = 41079
    order by ctl_trnsp

/*produto gps - 07010003*/
select fc_vinculado_nom_guerr(ctl_remet) as remet,fc_vinculado_documento(ctl_trnsp,1) as doc_trnsp,
         fc_vinculado_nom_guerr(ctl_trnsp) as trnsp, count(*) AS total
         from plano_viagem
         where to_char(dhr_inclu, 'yyyymmdd') between '20040101' and '20040131'
         and tip_rastr = 1
         and sit_plvia <> 10
         and ctl_opera_tip = 3
         and ctl_remet = 41079
         and ctl_trnsp = 39979
         group by fc_vinculado_nom_guerr(ctl_remet), fc_vinculado_documento(ctl_trnsp,1),fc_vinculado_nom_guerr(ctl_trnsp)
         
/*cartao - (07010004, 0710005, 07010006, 07010007, 07010008)*/
select p.ctl_plvia, fc_vinculado_nom_guerr(p.ctl_remet) as remet,
fc_vinculado_nom_guerr(p.ctl_trnsp) as trnsp, r.ctl_parad
from plano_viagem p, roteiro_motorista r
where to_char(dhr_inclu, 'yyyymmdd') between '20040101' and '20040131'
and p.sit_plvia <> 10
and p.tip_rastr in ( 2, 3 )
and p.ctl_opera_tip = 3
and p.ctl_remet = 41079
and p.ctl_trnsp = 39979
and p.ctl_plvia = r.ctl_plvia 
order by p.ctl_plvia

/*Aviso Embarque - 07010011*/
select fc_vinculado_nom_guerr(p.ctl_remet) as remet, fc_vinculado_nom_guerr(p.ctl_trnsp) as transp, count(*) as total
from aviso_embarque a, plano_viagem p
where to_char(p.dhr_inclu, 'yyyymmdd') between '20040101' and '20040131'
and p.sit_plvia <> 10
and p.ctl_opera_tip =3
and p.ctl_remet =41079
and p.ctl_trnsp =39979
and a.ctl_plvia = p.ctl_plvia
group by fc_vinculado_nom_guerr(p.ctl_remet), fc_vinculado_nom_guerr(p.ctl_trnsp)

/*Cartao Provisorio - 0710012*/

select fc_vinculado_nom_guerr(ctl_remet) as remet, fc_vinculado_nom_guerr(ctl_trnsp) as transp, count(*) as total
from plano_viagem
where to_char(dhr_inclu, 'yyyymmdd') between '20040101' and '20040131'
and sit_plvia <> 10
and ctl_opera_tip = 3
and ctl_remet = 41079
and ctl_trnsp = 39979
and num_pcard is not null and tip_rastr = 2
and substr(rtrim(ltrim(to_char(num_pcard,'0000000000'))),8,2) = '00'
group by fc_vinculado_nom_guerr(ctl_remet), fc_vinculado_nom_guerr(ctl_trnsp)



select 
