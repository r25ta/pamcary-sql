select * from email_solicitacao_endereco
where des_email_end like 'msouza@eclipsetransportes.com.br'

SELECT ES.ctl_solic_env, ES.nom_aplic_sol, to_char(ES.dhr_solic_env,'DD/MM/YYYY HH24:MI:SS'),
ES.cod_situa_env, to_char(ES.dhr_envio,'DD/MM/YYYY HH24:MI:SS'), ES.des_email_res,
ES.des_email_ass, ES.cod_user, ESE.des_email_end
FROM email_solicitacao ES, email_solicitacao_endereco ESE
WHERE ES.ctl_solic_env = ESE.ctl_solic_env
AND ESE.des_email_end in ('elaine.santos@pamcary.com.br', 'abimael@ctb.rodosino.com.br','sfcoathayde@uol.com.br','dp@anr.com.br','marcela.prado@essemaga.com.br', 'msouza@eclipsetransportes.com.br')




select * from email_solicitacao
where ctl_solic_env in (11598, 11599)
