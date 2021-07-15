#!/bin/bash
#  
#       CA Tool v1.0 
#  
#                                     
#                                                  
#
#Colors
cyan='\e[0;36m'
lightcyan='\e[96m'
green='\e[0;32m'
lightgreen='\e[1;32m'
white='\e[1;37m'
yellow='\e[1;33m'
blue='\e[1;34m'
echo ""
sleep 2

#banner head
function main_menu()
{
    while :
    do

echo -e $Green ""

echo "            +-+-+-+-+-+-+-+                             ";
echo "             |C|A|T|O|O|L|                              ";
echo "            +-+-+-+-+-+-+-+                             ";
echo "                                                        ";
echo " ██████╗ ████████╗   ████████╗ ██████╗  ██████╗ ██╗     ";
echo "██╔════╝ ██════██║   ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ";
echo "██║      ████████║      ██║   ██║   ██║██║   ██║██║     ";
echo "██║      ██║   ██║      ██║   ██║   ██║██║   ██║██║     ";
echo "╚██████╗ ██║   ██║      ██║   ╚██████╔╝╚██████╔╝███████╗";
echo " ╚═════╝ ╚═╝   ╚═╝      ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝";
echo "                                                        ";

echo ""

echo -e $cyan ""
echo -e $okegreen"   ====================== Tool Lest =======================    ";
        echo
        echo "[1] ✔ Passphrase Creation      "
        echo "[2] ✔ Client Server Certificate Creation  "
        echo "[3] ✔ Server Root Certificate Creation   "
        echo "[4] ✔ Client Certificate Key Creation   "
        echo "[5] ✔ Client CSR Creation       "
        echo "[6] ✔ Client Certificate Creation       "        
        echo "[q] ✔ Quit"
        echo
        read -p "Select>: " option
        echo
        
        case "$option" in 
            1)  echo "Creating Passphrase"
                echo -e $red "############## Passphrase Creation  ###################"
                sleep 2
                                if [[ "$OSTYPE" == "linux-gnu" ]]; then
                 	passphrase=$(pwgen -c -n -y -s  -1 35 | sed -E "s/\"|<|>|\`|'/$(($RANDOM % 9))/g")
                elif [[ "$OSTYPE" == "darwin"* ]]; then
                	passphrase=$(pwgen -c -n -y -s -B -1 35 -r "\"'\`<>")
                fi	             	
                echo $passphrase
                echo -e $green "Passphrase Created successfully"
                echo -e "#####This is a one time password so please save######"
                
                echo -e "【!】Return To The Main Menu【!】"
                read -p "pess any key to return ..."
                clear
                ;;
            2)  echo "Creating Server Certificate Key"
                echo -e $red "############## Server CA Key Creation  ###################"
                sleep 2
                #reading the input
                echo envname="Enter Environment shortname (EX, Stg. Prod, Dev)"
                read envname
                echo Creating rootCa $envname.key
                      rootcakey=$(openssl genrsa -des3 -out rootCa$envname.key 4096)
                echo -e $green "Root CA Key Created successfully"
                echo
                echo -e $green "【!】Return To The Main Menu【!】"
                read -p "pess any key to return ..."
                clear
                ;;
            3)  echo "Creating Server Root Certificate"
                echo -e $red "############## Server Root CA Creation ###################"
                sleep 2
               #reading the input
                echo "Enter root CA key Name created in step 2"
                read rootcakey
                echo "Enter Environment shortname (EX, Stg. Prod, Dev)"
                read rootcaenvname
                echo "Enter Certificate valid date count"
                read validdatecount
                echo Create and self sign the Root Certificate
                      rootca=$(openssl req -x509 -new -nodes -key $rootcakey -sha256 -days $validdatecount -out rootCa$rootcaenvname.crt)
                echo -e $green "Certficate Created successfully"
                echo
                echo -e $green "【!】Return To The Main Menu【!】"
                read -p "pess any key to return ..."
                clear
                ;;
            4)  echo "Creating Client Certificate Key"
                echo -e $red "############## Client CA Key Creation ###################"
                sleep 2
                echo envname="Enter Environment shortname (EX, Stg. Prod, Dev)"
                read envname
                echo Creating ClientCa $envname.key
                      rootcakey=$(openssl genrsa -out orgsync.$envname.choreo.$envname.key 2048)
                echo -e $green "Key Created successfully"
                echo
                echo -e $green "【!】Return To The Main Menu【!】"
                read -p "pess any key to return ..."
                clear
                ;;
            5)  echo "Creating Client CSR"
                echo -e $red "############## CSR Creation ###################"
                sleep 2
                echo "Enter Client CA key name (EX, Created in step 4)"
                read clientcakey
                echo "Enter Environment shortname (EX, Stg. Prod, Dev)"
                read envname
                echo "Enter Name of the product (Ex: Choreo, Asgardio, Clevercare)"
                read product
                echo "Enter Country name (Ex: US)"
                read C
                echo "Enter State or Province name (Ex: California)"
                read ST
                echo "Enter Name of the organization (Ex: WSO2.Inc.)"
                read O
                echo Creating ClientCSR $envname.csr
                      Clientcsr=$(openssl req -new -sha256 -key $clientcakey \
                      -subj "/C=$C/ST=$ST/O=$O/CN=orgsync.$envname.$product.$envname" -out orgsync.$envname.$product.$envname.csr)
                echo -e $green "Client CSR successfully"
                echo
                echo -e $green "【!】Return To The Main Menu【!】"
                read -p "pess any key to return ..."
                clear
                ;;      
            6)  echo "Creating Client Certificate"
                echo -e $red "############## Client CA Creation ###################"
                sleep 2
                echo "Enter Client CSR Name (EX, Created in step 5)"
                read clientcsrname
                echo "Enter root Ca cert name (EX, Created in step 3)"
                read rootCacertname
                echo "Enter Root CA key Name (EX, Created in step 2)"
                read rootcakeyname                        
                echo "Enter Name of the product (Ex: Choreo, Asgardio, Clevercare)"
                read product
                echo "Enter Environment shortname (EX, Stg. Prod, Dev)"
                read envname
                echo "Enter Certificate valid date count"
                read validdatecount
                echo Creating orgsync.$envname.$product.$envname.crt
                     Clientcsr=$(openssl x509 -req -in $clientcsrname -CA $rootCacertname -CAkey $rootcakeyname -CAcreateserial -out orgsync.$envname.$product.$envname.crt -days 500 -sha256)                   
                echo -e $green "Client cert. Created successfully"
                echo
                echo -e $green "【!】Return To The Main Menu【!】"
                read -p "pess any key to return ..."
                clear
                ;;  
            q)  echo -e $yellow " Thanks For Using My Tools Good Bye !!"
                echo
                exit 0 
                ;;
        esac
    done
}
main_menu
