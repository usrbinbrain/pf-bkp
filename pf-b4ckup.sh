#!/usr/bin/env bash

############################################################ Script realiza o backup em massa de firewalls pfSense. #######################################################


dat3=$(date +%Y%m%d)	# Obtem o momento da execucao do script.

sshcmd () {
	# Funcao para execucao de comando via SSH.
	timeout 9 ssh -q -o StrictHostKeyChecking=no -p "$port" admin@"$ip" "$1"
}

scpget () {
	# Funcao para execuacao de downloads via SCP.
	scp -P "$port" -q -o StrictHostKeyChecking=no "$1" "$2"
}

# Condicao para verificar e criar a estrutura de diretorios dos backups.
if [ ! -d "./fw-backups/$dat3" ]
then
    mkdir -p ./fw-backups/"$dat3"							# Cria estrutura de backup para os arquvos XML.
    echo "[ $(date) ] + Diretorio ./fw-backups/$dat3 foi criado" >> .log.backup 	# Escrita de log.
fi

########## Loop para execucao dos backups em massa. ########## 

for line in $(cat firewall.lst)             # O arquivo firewall.lst contem os firewall alvo.
do
	ip=$(echo "$line"|cut -d "#" -f1)         # Obtem o valor do conteudo antes do caracter "#" de cada linha do arquivo firewall.lst
	port=$(echo "$line"|cut -d "#" -f2)       # Obtem o valor do conteudo depois do caracter "#" de cada linha no arquivo firewall.lst
	name=$(sshcmd "hostname" || echo "fail")	# Obtem o hostname do firewall ou retorna "fail" caso o SSH nao se autentique corretamente.
	
	if [ "$name" != "fail" ]			                                               
	then
		scpget "root@$ip:/cf/conf/config.xml" "./fw-backups/$dat3/$name.xml" &&    # Efetua o download do arquivo de backup do firewall para a pasta "./fw-backup".
		echo "[ $(date) ] + Backup do firewall $name foi salvo no arquivo $PWD/fw-backup/$dat3/$name.xml" | tee -a .log.backup  # Escrita de log.
	else
		echo "[ $(date) ] + Falha de login SSH no firewall $ip:$port" >> .log.backup  # Escrita de log.
	fi
done

######### Controle e recliclagem de backups. ##########

cd ./fw-backups &&	 	        # Acessando diretorio dos backups.
npastas=$(ls -1t|wc -l)		    # Obtendo a quantidade de pastas de backup.

while [ "$npastas" -gt "61" ]	# Condicao acionada caso exista mais de 60 pastas de backup.
do
	last=$(ls -1t|tail -n1)	    # Obtem a pasta mais antiga do diretorio.
	npastas=$(ls -1t|wc -l)	    # Obtendo a quantidade de pastas de backup.
	rm -fr "$last"		          # Deleta a pasta mais antiga caso existam mais de 60 pastas.
	echo "[ $(date) ] + Pasta $last foi deletada pela reciclagem de backups antigos." | tee -a ../.log.backupc 	# Escrita de log.
done
