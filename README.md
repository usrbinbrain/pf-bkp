# pf-b4ckup.sh

Backup massivo de firewalls pfSense.

O script [pf-b4ckup.sh](pf-b4ckup.sh) usa um arquivo de enderecos de firewalls pfSense, e então realiza o backup do arquivo `/cf/conf/config.xml` de configuração do firewall.

Essa lista chamada [firewall.lst](https://github.com/tr4kthebox/pf-bkp/blob/main/pf-b4ckup.sh#L27) deve conter um endereco de IP ou FQDN por linha.

O script gera o diretório `fw-backup` que e criado no diretório corrente da execução, todos os backups são salvos nesse diretório, dentro de uma pasta que leva o nome do `ano`, `mês` e `dia` da execução do script.

Os arquivos de backup são salvos no formato `XML` e recebem o nome do `hostname` configurado do S.O. (FreeBSD) do firewall pf-sense.

Caso o script seja executado mais de uma vez no mesmo dia, os arquivos de backups antigos serão `substituídos` pelos arquivos de backup gerados na última execução do script.

O script realiza a própria reciclagem de backups, excluindo backups superiores a 60 dias, que pode ser moficado na linha [47](https://github.com/tr4kthebox/pf-bkp/blob/main/pf-b4ckup.sh#L47).
***
