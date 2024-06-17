
/*LOCALIZAR COLUNA NO BANCO DE DADOS*/
Select c.tabschema as schema_name,
       c.tabname as table_name, 
       c.colname as column_name,
       c.colno as position,
       c.typename as data_type,
       c.length,
       c.scale,
       c.remarks as description,   
       case when  c.nulls = 'Y' then 1 else 0 end as nullable,
       default as default_value,
       case when c.identity ='Y' then 1 else 0 end as is_identity,
       case when c.generated ='' then 0 else 1 end as  is_computed,
       c.text as computed_formula
from syscat.columns c
inner join syscat.tables t on 
      t.tabschema = c.tabschema and t.tabname = c.tabname
where t.type = 'T'
AND C.COLNAME LIKE '%VLR%'
order by schema_name, table_name