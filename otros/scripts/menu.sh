#!/bin/bash

title="Homestead Selección"
prompt="Elija una opción:"
options=(   
            "pwd" 
            "cd Homestead" 
            "Vagrant up" 
            "Vagrant ssh" 
            "Vagrant halt"
            "micro /etc/hosts"
            "code /etc/hosts"
            "network-manager restart"
            "vagrant reload --provision"
            "code Homestead.yaml"
            "micro Homestead.yaml"
            "https ecommerce"
            "Edit menu.sh"
            "MsCode"
            "Clear"
        )

echo "$title"
# agrega una linea en blanco
echo ""

PS3="$prompt "
select opt in "${options[@]}" "Quit"; do 
   case "$REPLY" in

   1) echo "power working directory"
      pwd;;

   2) cd ~/Homestead
      pwd;;

   3) cd ~/Homestead
      pwd
      vagrant up;;

   4) cd ~/Homestead
      pwd
      vagrant ssh;;

   5) cd ~/Homestead
      pwd 
      vagrant halt
      break;;

   6) sudo micro /etc/hosts;;

   7) code /etc/hosts;;

   8) sudo service network-manager restart
      echo "service network-manager restart"
      echo "Listo...";;

   9) vagrant reload --provision
      echo "vagrant reload --provision"
      echo "Listo...";;

   10) code ~/Homestead/Homestead.yaml
      echo "Abrir Homestead.yaml en code"
      echo "Listo...";;
   
   11) micro ~/Homestead/Homestead.yaml
      echo "Abrir Homestead.yaml en micro"
      echo "Listo...";;

   12) xdg-open https://homestead.ecommerce
      echo "Abrir Site https://homestead.ecommerce"
      echo "Listo...";;

   13) code ~/scripts/menu.sh
      echo "Abrir menu.sh en code"
      echo "Listo...";;

   14) code 
      echo "Abrir MsCode"
      echo "Listo...";;

   15) clear;;

   $((${#options[@]}+1))) echo "Goodbye!"; break;;
   *) echo "Invalid option. Try another one.";continue;;
   esac
done

