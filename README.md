# PF_Bkp

Pf_bkp realiza o backup da configuração de múltiplos firewalls pfSense via SSH.

### _Instalação._

Clone a ferramenta com o seguinte comando.

```bash
git clone https://github.com/usrbinbrain/pf-bkp.git
```

### _Uso._

O script [pf_bkp.sh](pf_bkp.sh) requer um arquivo como argumento para a execução.

Esse arquivo deve conter os endereços de IP ou FQDN dos firewalls pfSense, seguidos pelos números das portas SSH, separados por `:`, conforme o exemplo abaixo.

```
pfSense01.fqdn:2201
pfSense02.fqdn:2202
pfSense03.fqdn:2210
pfSense04.fqdn:2220
```
Essa ferramenta assume que sua chave RSA publica já esteja configurada nos firewalls pfsense, permitindo a execução de comandos.

O backup do arquivo de configuração `/cf/conf/config.xml` do firewall é salvo na estrutura de diretórios criada na execução do script.

A estrutura de diretório segue o seguinte padrão.

`
./fw_backup/bkp_$data-$hora/$nomedofirewall/config.xml
`

Apenas execute.

```bash
./pf_bkp.sh lista_pfsense.txt
```
***
