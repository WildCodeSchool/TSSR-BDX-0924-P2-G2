#!/bin/bash

###### Variable #######
date=$(date +%Y%m%d)
hour=$(date +%H%M%S)
namePC=$(hostname)
name=$(whoami)
red='\033[0;31m'
green='\033[0;32m'
cyan='\033[0;36m'
purple='\033[0;35m'
blue='\033[0;34m'
orange='\033[0;33m'
yellow='\033[1;33m'
noColor='\033[0m'
# La journalisation du projet sera enregistrés dans le fichier /var/log/log_evt.log
logPath="/var/log/log_evt.log"

###### Fonctions ######

###### Script #########
while true; do
    echo -e "========================= ${yellow}Menu cible : Ordinateur${noColor} =========================="
    echo "=== Voulez-faire des actions ou demander des informations sur la cible ? ==="
    echo " Choix 1 : Je veux faire des actions sur la cible."
    echo " Choix 2 : Je veux demander des informations sur la cible."
    echo " Choix 3 : Je veux retourner au menu de départ."
    echo " Choix 4 : Je veux sortir du script."
    echo "============================================================================"
    read -p "Votre choix : " choice

    case $choice in
        1)
            echo "$date-$hour-$name-Menu cible_Ordinateur_Choix 1_Action sur la cible." >> $logPath
            source /home/wilder/TheScriptingProject/computer/actionComputer.sh
            ;;
        2)
            echo "$date-$hour-$name-Menu cible_Ordinateur_Choix 2_Information sur la cible." >> $logPath
            source /home/wilder/TheScriptingProject/computer/infoComputer.sh
            ;;
        3)
            echo "$date-$hour-$name-Menu cible : Ordinateur_Choix 3_Retour au menu de départ." >> $logPath
            echo "Vous avez choisi de revenir au menu de départ."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/mainMenu.sh
            ;;
        4)
            echo "$date-$hour-$name-*********EndScript*********" >> $logPath
            echo "Vous avez choisi de sortir du script."
            sleep 2
            clear
            exit
            ;;
        *)
            echo "$date-$hour-$name-Menu cible_Ordinateur_Réponse invalide, retour au menu actuel." >> $logPath
            echo -e "[${red}WARNING${noColor}] ${orange}Vous devez choisir l'une des options demandés ! ${noColor}"
            echo "Vous allez être redirigé au menu cible : Ordinateur."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/computer/menuComputer.sh
            ;;
    esac
done
