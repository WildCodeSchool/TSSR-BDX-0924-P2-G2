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
    echo -e "======================== ${purple}Menu de départ ${noColor} ========================"
    echo "============ Sur quel cible voulez-vous travailler ? ============"
    echo " Choix 1 : Je veux travailler sur une cible de type utilisateur."
    echo " Choix 2 : Je veux travailler sur une cible de type ordinateur."
    echo " Choix 3 : Sortir du script."
    echo "================================================================="
    read -p "Votre choix : " choice

    case $choice in
        1)
            clear
            echo "$date-$hour-$name-*********StartScript*********" >> $logPath
            echo "$date-$hour-$name-Menu de départ_Choix 1_Travail sur cible utilisateur" >> $logPath
            source /home/wilder/TheScriptingProject/user/menuUser.sh
            ;;
        2)
            clear
            echo "$date-$hour-$name-*********StartScript*********" >> $logPath
            echo "$date-$hour-$name-Menu de départ_Choix 2_Travail sur cible ordinateur" >> $logPath
            source /home/wilder/TheScriptingProject/computer/menuComputer.sh
            ;;
        3)
            echo "$date-$hour-$name-*********EndScript*********" >> $logPath
            echo "Vous avez choisi de sortir du script."
            sleep 2
            clear
            exit
            ;;
        *)
            echo "$date-$hour-$name-*********StartScript*********" >> $logPath
            echo "$date-$hour-$name-Menu de départ_Réponse invalide, retour au menu actuel." >> $logPath
            echo -e "[${red}WARNING${noColor}] ${orange}Vous devez choisir l'une des options demandés ! ${noColor}"
            echo "Vous allez être redirigé au menu de départ."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/mainMenu.sh
            ;;
    esac
done
