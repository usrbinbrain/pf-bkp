#!/usr/bin/env bash
t=$(date +%Y%m%d-%H%M%S)

banner () {
    printf "\e[34;1m
              __ _     _          
             / _| |   | |         
       _ __ | |_| |__ | | ___ __  
      | '_ \|  _| '_ \| |/ | '_ \ 
      | |_) | | | |_) |   <| |_) |
      | .__/|_| |_.__/|_|\_| .__/ 
      | |   ______         | |    
      |_|  |______|        |_|\e[0m

"
}

getxml () {
    x=$1
    pfsense=${x%%:*}
    port=${x##*:}
    xml=$(ssh -p "$port" -q -o PasswordAuthentication=no -o StrictHostKeyChecking=no -o ConnectTimeout=5 root@"$pfsense" 'cat /cf/conf/config.xml' 2>/dev/null) &&
    [[ ! -d "./fw_backup/bkp_$t/$pfsense" ]] &&
    mkdir -p ./fw_backup/bkp_"$t"/"$pfsense" &>/dev/null &&
    echo "$xml" > ./fw_backup/bkp_"$t"/"$pfsense"/config.xml && 
    echo -e "\e[32m +\e[0m Backup OK on pfSense \e[1m$pfsense\e[0m \e[32;1m[ Saved:\e[0m ./fw_backup/bkp_$t/$pfsense/config.xml \e[32;1m]\e[0m" ||
    echo -e "\e[31;1m -\e[0m Authentication Fail on \e[31;1m$pfsense\e[0m"
}

[[ -f "$1" ]] &&
banner &&
for fw in $(cat $1); do

    getxml "$fw"
done || echo -e "\e[1m * $0 require a firewall list as argument"
