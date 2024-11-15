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
function infoPC () {
    # Logging
    echo "$date-$hour-$name-Menu d'information : Ordinateur_Choix 1 : Demande d'information sur le type de système d'exploitation de l'ordinateur cible." >> $logPath
    # Functions
    echo "============================================================================================================================="
    echo "Vous avez choisi de demander des informations sur le type de système d'exploitation de l'ordinateur cible."
    echo "L'information sur le type de système d'exploitation utilisé par l'ordinateur cible sera enregistré dans le dossier Documents."
    echo "$date-$hour-$name-Enregistrement des informations concernant l'OS de la cible." >> $logPath
    ssh wilder@10.3.0.14 lsb_release -a >> /home/wilder/Documents/info_"$userName"_"$date".txt
    echo "============================================================================================================================="
    echo "Voulez-vous afficher les informations enregistrés ? [Oui/Non]"
    read answer
    if [ $answer = Oui ] || [ $answer = O ]; then
        echo "$date-$hour-$name-Affichage sur écran des informations demandés" >> $logPath
        echo Affichage des informations enregistrés en cours.
        sleep 2
        cat /home/wilder/Documents/info_"$userName"_"$date".txt
        sleep 10
        clear
    else
        echo "$date-$hour-$name-Non affichage sur écran des informations demandés, retour au menu précédent." >> $logPath
        echo "Vous allez être redirigé vers le menu précédent."
        sleep 2
        clear
    fi
}
function uptimePC () {
    # Logging
    echo "$date-$hour-$name-Menu d'information : Ordinateur_Choix 2 : Demande d'information sur l'uptime de l'ordinateur cible." >> $logPath
    # Functions
    echo "==========================================================================================="
    echo "Vous avez choisi de demander des informations sur l'uptime de l'ordinateur cible."
    echo "L'information sur l'uptime de l'ordinateur cible sera enregistré dans le dossier Documents."
    echo "$date-$hour-$name-Enregistrement des informations concernant l'uptime de la cible." >> $logPath
    ssh wilder@10.3.0.14 uptime >> /home/wilder/Documents/info_"$userName"_"$date".txt
    echo "==========================================================================================="
    echo "Voulez-vous afficher les informations enregistrés ? [Oui/Non]" 
    read answer
    if [ $answer = Oui ] || [ $answer = O ]; then
        echo "$date-$hour-$name-Affichage sur écran des informations demandés" >> $logPath
        echo Affichage des informations enregistrés en cours.
        sleep 2
        cat /home/wilder/Documents/info_"$userName"_"$date".txt
        sleep 10
        clear
    else
        echo "$date-$hour-$name-Non affichage sur écran des informations demandés, retour au menu précédent." >> $logPath
        echo "Vous allez être redirigé vers le menu précédent."
        sleep 2
        clear
    fi
}

###### Script #########
while true; do
    echo -e "=============== ${yellow}Menu d'information : Ordinateur${noColor} ==============="
    echo "============ Quel type d'information voulez-vous ? ============"
    echo " Choix 1 : Je veux savoir le type de système d'exploitation."
    echo " Choix 2 : Je veux savoir depuis quand l'ordinateur est allumé."
    echo " Choix 3 : Je veux retourner au menu précédent."
    echo " Choix 4 : Je veux retourner au menu de départ."
    echo " Choix 5 : Je veux sortir du script."
    echo "==============================================================="
    read -p "Votre choix : " choice

    case $choice in
        1)
            infoPC
            ;;
        2)
            uptimePC
            ;;
        3)
            echo "$date-$hour-$name-Menu d'information_Ordinateur_Choix 3_Retour au menu précédent." >> $logPath
            echo "Vous avez choisi de revenir au menu précédent."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/computer/menuComputer.sh
            ;;
        4)
            echo "$date-$hour-$name-Menu d'information_Ordinateur_Choix 4_Retour au menu de départ." >> $logPath
            echo "Vous avez choisi de revenir au menu de départ."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/mainMenu.sh
            ;;
        5)
            echo "$date-$hour-$name-*********EndScript*********" >> $logPath
            echo "Vous avez choisi de sortir du script."
            sleep 2
            clear
            exit
            ;;
        *)
            echo "$date-$hour-$name-Menu d'information_Ordinateur_Réponse invalide, retour au menu actuel." >> $logPath
            echo -e "[${red}WARNING${noColor}] ${orange}Vous devez choisir l'une des options demandés ! ${noColor}"
            echo "Vous allez être redirigé au menu d'information : Ordinateur."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/computer/infoComputer.sh
            ;;
    esac
done
