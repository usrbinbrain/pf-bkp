# pf_bkp.sh

Backup massivo de firewalls pfSense via SSH.

Esse script assume que já exista uma chave RSA configurada nos dispositivos remotos.

O script [pf_bkp.sh](pf_bkp.sh) requer um arquivo com a lista de firewalls, contendo um IP ou FQDN e porta SSH por linha, conforme o seguinte formato.

> myfirewalladdress.local:mySSHport

O backup do arquivo de configuração (`/cf/conf/config.xml`) do firewall é salvo na estrutura de diretórios criada na execução do script.

> ./fw_backup/bkp_<date>-<hours>/<firewallName>/config.xml

***
