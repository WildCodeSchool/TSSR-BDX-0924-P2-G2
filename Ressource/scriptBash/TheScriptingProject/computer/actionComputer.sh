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
function stopPC () {
    # Logging
    echo "$date-$hour-$name-Menu d'action : Ordinateur_Choix 1 : Demande d'arrêt de la cible." >> $logPath
    # Functions
    echo "=========================================================="
    echo "Vous avez choisi d'éteindre l'ordinateur cible."
    echo "Êtes-vous sur de vouloir éteindre l'ordinateur ? [Oui/Non]"
    read answer
        if [ $answer = Oui ] || [ $answer = O ]; then
            echo "$date-$hour-$name-La cible s'éteind." >> $logPath
            echo "L'ordinateur cible est en cours d'extinction."
            echo "Azerty1*" | ssh wilder@10.3.0.14 sudo -S shutdown now
            echo "L'ordinateur cible est éteint, vous allez être redirigé vers le menu de départ."
            sleep 5
            clear
            source /home/wilder/TheScriptingProject/mainMenu.sh
        else
            echo "$date-$hour-$name-La cible ne s'éteind pas." >> $logPath
            echo "L'ordinateur cible ne sera pas éteint, vous allez être redirigé vers le menu précédent."
            sleep 2
            clear
        fi
}
function rebootPC () {
    # Logging
    echo "$date-$hour-$name-Menu d'action : Ordinateur_Choix 2 : Demande de redémarrage de la cible.." >> $logPath
    # Functions
    echo "============================================================"
    echo "Vous avez choisi de redémarrer l'ordinateur cible."
    echo "Êtes-vous sur de vouloir redémarrer l'ordinateur ? [Oui/Non]"
    read answer
        if [ $answer = Oui ] || [ $answer = O ]; then
            echo "$date-$hour-$name-La cible redémarre." >> $logPath
            echo "L'ordinateur cible est en cours de redémarrage."
            echo "Azerty1*" | ssh wilder@10.3.0.14 sudo -S reboot
            echo "L'ordinateur cible a redémarré, vous allez être redirigé vers le menu de départ."
            sleep 5
            clear
            source /home/wilder/TheScriptingProject/mainMenu.sh
        else
            echo "$date-$hour-$name-La cible ne redémarre pas." >> $logPath
            echo "L'ordinateur cible ne sera pas redémarré, vous allez être redirigé vers le menu précédent."
            sleep 2
            clear
        fi
}

###### Script #########
while true; do
    echo -e "========================= ${yellow}Menu d'action : Ordinateur${noColor} ======================="
    echo "=== Voulez-faire des actions ou demander des informations sur la cible ? ==="
    echo " Choix 1 : Je veux éteindre l'ordinateur."
    echo " Choix 2 : Je veux redémarrer l'ordinateur."
    echo " Choix 3 : Je veux retourner au menu précédent."
    echo " Choix 4 : Je veux retourner au menu de départ."
    echo " Choix 5 : Je veux sortir du script."
    echo "============================================================================"
    read -p "Votre choix : " choice

    case $choice in
        1)
            stopPC
            ;;
        2)
            rebootPC
            ;;
        3)
            echo "$date-$hour-$name-Menu d'action_Utilisateur_Choix 3_Retour au menu précédent." >> $logPath
            echo "Vous avez choisi de revenir au menu précédent."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/computer/menuComputer.sh
            ;;
        4)
            echo "$date-$hour-$name-Menu d'action_Utilisateur_Choix 4_Retour au menu de départ." >> $logPath
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
            echo "$date-$hour-$name-Menu d'action_Ordinateur_Réponse invalide, retour au menu actuel." >> $logPath
            echo -e "[${red}WARNING${noColor}] ${orange}Vous devez choisir l'une des options demandés ! ${noColor}"
            echo "Vous allez être redirigé au menu d'action : Ordinateur."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/computer/actionComputer.sh
            ;;
    esac
done
