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
function dateUser () {
    # Logging
    echo "$date-$hour-$name-Menu d'information : Utilisateur_Choix 1 : Demande d'information sur les dates de connexion de l'utilisateur" >> $logPath
    # Functions
    echo "================================================================================================="
    echo "Vous avez choisi de demander des informations sur la dernière date de connexion d'un utilisateur."
    echo "Quel est le nom de l'utilisateur à vérifier ?"
    read -p " Nom : " userName

    # Cheking if the user exists
    if ssh wilder@10.3.0.14 grep -q "^$userName:" /etc/passwd; then
        # The user exists
        echo "L'utilisateur $userName se trouve dans notre base de donnée."
        sleep 1
        # Data recovery of the last user's connection on the server
        echo "==========================================================================================================================="
        echo "L'information sur les dernières dates de connexion de l'utilisateur $userName seront enregistrés dans le dossier Documents."
        echo "$date-$hour-$name-Enregistrement des dernières dates de connexion de l'utilisateur $userName." >> $logPath
        ssh wilder@10.3.0.14 last $userName >> /home/wilder/Documents/info_"$userName"_"$date".txt
        sleep 2
        # Request to display data
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
    else
        # The user doesn't exists
        echo "==================================================================="
        echo "$date-$hour-$name-L'utilisateur $userName n'existe pas." >> $logPath
        echo "L'utilisateur $userName ne se trouve pas dans notre base de donnée."
        echo "Vous allez être redirigé vers le menu précédent."
        sleep 2
        clear
    fi
}
function existUser () {
    # Logging
    echo "$date-$hour-$name-Menu d'information : Utilisateur_Choix 2 : Demande d'information sur l'existance de l'utilisateur" >> $logPath
    # Functions
    echo "====================================================================================="
    echo "Vous avez choisi de demander des informations sur l'existance d'un utilisateur cible."
    echo "Quel est le nom de l'utilisateur à vérifier ?"
    read -p " Nom : " userName

    # Cheking if the user exists & Data recovery of the last user's connection on the server if true
    if ssh wilder@10.3.0.14 grep -q "^$userName:" /etc/passwd; then
        # The user exists
        echo "$date-$hour-$name-L'utilisateur $userName existe." >> $logPath
        echo "============================================================"
        echo "L'utilisateur $userName se trouve dans notre base de donnée."
        echo "L'information sur l'existance de l'utilisateur $userName seront enregistrés dans le dossier Documents."
        echo "$date-$hour-$name-Enregistrement de l'existance de l'utilisateur $userName." >> $logPath
        ssh wilder@10.3.0.14 grep "^$userName:" /etc/passwd >> /home/wilder/Documents/info_"$userName"_"$date".txt
        sleep 2
        # Request to display data
        echo "Voulez-vous afficher les informations enregistrés ? [Oui][Non]" 
        read answer
        if [ $answer = Oui ] || [ $answer = O ]; then
            echo "$date-$hour-$name-Affichage sur écran des informations demandés" >> $logPath
            echo Affichage des informations enregistrés en cours.
            cat /home/wilder/Documents/info_"$userName"_"$date".txt
            sleep 10
        else
            echo "$date-$hour-$name-Non affichage sur écran des informations demandés, retour au menu précédent." >> $logPath
            echo "Vous allez être redirigé vers le menu précédent."
            sleep 2
            clear
        fi
    else
        # The user doesn't exists
        echo "==================================================================="
        echo "$date-$hour-$name-L'utilisateur $userName n'existe pas." >> $logPath
        echo "L'utilisateur $userName ne se trouve pas dans notre base de donnée."
        echo "Vous allez être redirigé vers le menu précédent."
        sleep 2
        clear
    fi
}

###### Script #########
while true; do
    echo -e "=================== ${cyan}Menu d'information : Utilisateur${noColor} ===================="
    echo "================= Quel type d'information voulez-vous ? ================="
    echo " Choix 1 : Je veux savoir la date de dernière connexion d'un utilisateur."
    echo " Choix 2 : Je veux savoir si l'utilisateur existe."
    echo " Choix 3 : Je veux retourner au menu précédent."
    echo " Choix 4 : Je veux retourner au menu de départ."
    echo " Choix 5 : Je veux sortir du script."
    echo "========================================================================="
    read -p "Votre choix : " choice

    case $choice in
        1)
            dateUser
            ;;
        2)
            existUser
            ;;
        3)
            echo "$date-$hour-$name-Menu d'information_Utilisateur_Choix 3 : Retour au Menu cible : Utilisateur." >> $logPath
            echo "Vous avez choisi de revenir au menu précédent."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/user/menuUser.sh
            ;;
        4)
            echo "$date-$hour-$name-Menu d'information_Utilisateur_Choix 4 : Retour au Menu de départ." >> $logPath
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
            echo "$date-$hour-$name-Menu d'information_Utilisateur_Réponse invalide, retour au menu actuel." >> $logPath
            echo -e "[${red}WARNING${noColor}] ${orange}Vous devez choisir l'une des options demandés ! ${noColor}"
            echo "Vous allez être redirigé au menu d'information : Utilisateur."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/user/infoUser.sh
            ;;
    esac
done
