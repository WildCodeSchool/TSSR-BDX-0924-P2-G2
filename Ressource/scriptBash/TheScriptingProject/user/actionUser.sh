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
function addUser () {
    # Logging
    echo "$date-$hour-$name-Menu d'action : Utilisateur_Choix 1 : Demande de création d'un utilisateur." >> $logPath
    # Functions
    echo "========================================================"
    echo "Vous avez choisi de créer un nouveal utilisateur."
    echo "Quel est le nom de l'utilisateur que vous voulez créer ?"
    read -p " Nom : " userName

    # Cheking if the user exists
    if ssh wilder@10.3.0.14 grep -q "^$userName:" /etc/passwd; then
        # The user exists
        echo "$date-$hour-$name-Echec de création de l'utilisateur $userName car déjà existant." >> $logPath
        echo "==========================================================================="
        echo "L'utilisateur $userName existe déjà, vous ne pouvez pas en créer un second."
        echo "Merci de rentrer un nom d'utilisateur libre d'utilisation."
        echo "Vous allez être redirigé vers le menu précédent."
        sleep 2
        clear
    else
        # The user doesn't exists
        echo "========================================================================"
        echo "L'utilisateur $userName n'existe pas, vous pouvez créer cet utilisateur."
        sleep 2
        echo "Êtes-vous sur de vouloir créer l'utilisateur $userName ? [Oui/Non]"
        read answer
        if [ $answer = Oui ] || [ $answer = O ]; then
            echo "$date-$hour-$name-Création de l'utilisateur $userName." >> $logPath
            echo "================================================"
            echo "Création de l'utilisateur $userName."
            ssh root@10.3.0.14 useradd $userName
            echo "L'utilisateur $userName a été crée."
            echo "================================================"
            echo "Aucun mot de passe n'a été configuré."
            ssh root@10.3.0.14 passwd $userName
            echo "Le mot de passe a été crée."
            echo "================================================"
            echo "Création du dossier Home de $userName"
            ssh root@10.3.0.14 mkdir /home/$userName
            echo "Le dossier /home/$userName a été crée."
            echo "================================================"
            echo "Vous allez être redirigé vers le menu précédent."
            sleep 2
            clear
        else
            # Error while creating the new user
            echo "$date-$hour-$name-Echec lors de la création de l'utilisateur $userName." >> $logPath
            echo "============================================================================"
            echo -e "[${red}ERROR${noColor}] ${orange}Une erreur est survenu lors de la création du nouvel utilisateur${noColor}."
            echo "Veuillez réitérer la manoeuvre."
            sleep 2
            clear
        fi
    fi
}
function delUser () {
    # Logging
    echo "$date-$hour-$name-Menu d'action : Utilisateur_Choix 2 : Demande de suppresion d'un utilisateur." >> $logPath
    # Functions
    echo "=============================================="
    echo "Vous avez choisi de supprimer un utilisateur."
    echo "Quel est le nom de l'utilisateur à supprimer ?"
    read -p " Nom : " userName

    # Cheking if the user exists
    if ssh wilder@10.3.0.14 grep -q "^$userName:" /etc/passwd; then
        # The user exists
        echo "================================================================================"
        echo "L'utilisateur $userName existe dans notre base de donnée, il peut être supprimé."
        sleep 2
        echo "Êtes-vous sur de vouloir supprimer l'utilisateur $userName ? [Oui/Non]"
        read answer
        if [ $answer = Oui ] || [ $answer = O ]; then
            echo "$date-$hour-$name-L'utilisateur $userName a été supprimé." >> $logPath
            echo "===================================================="
            echo "L'utilisateur $userName va être supprimé."
            ssh root@10.3.0.14 deluser $userName
            echo "[${green}Success${noColor}] L'utilisateur $userName n'existe plus."
            echo "===================================================="
            echo "Le dossier home de $userName va être supprimé."
            ssh root@10.3.0.14 rm -rf /home/$userName
            echo "[${green}Success${noColor}] Le dossier /home/$userName a été supprimé."
            echo "===================================================="
            echo "Vous allez être redirigé vers le menu précédent."
            sleep 2
            clear
        else
            echo "$date-$hour-$name-Echec lors de la suppression de l'utilisateur $userName." >> $logPath
            echo "================================================"
            echo "L'utilisateur $userName ne sera pas supprimé."
            echo "Vous allez être redirigé vers le menu précédent."
            sleep 2
            clear
        fi
    else
        # The user doesn't exists
        echo "$date-$hour-$name-Echec lors de la suppression de l'utilisateur $userName car il n'existe pas." >> $logPath
        echo "========================================================================"
        echo "[${red}Erreur${noColor}] ${orange}L'utilisateur renseigné n'existe pas dans notre base de donnée${noColor}."
        echo "Vous allez être redirigé vers le menu précédent."
        sleep 2
        clear
    fi 
}
function modifyUser () {
    # Logging
    echo "$date-$hour-$name-Menu d'action : Utilisateur_Choix 3 : Demande de modification du mot de passe d'un utilisateur." >> $logPath
    # Functions
    echo "=============================================================="
    echo "Vous avez choisi de modifier le mot de passe d'un utilisateur."
    echo "Quel est le nom de l'utilisateur ?"
    read -p " Nom : " userName

    # Cheking if the user exists
    if ssh wilder@10.3.0.14 grep -q "^$userName:" /etc/passwd; then
        # The user exists
        echo "==============================================================================================="
        echo "L'utilisateur $userName existe dans notre base de donnée, vous pouvez modifié son mot de passe."
        sleep 2
        echo "Êtes-vous sur de vouloir modifier le mot de passe de l'utilisateur $userName ? [Oui/Non]"
        read answer
        if [ $answer = Oui ] || [ $answer = O ]; then
            echo "$date-$hour-$name-Modification du mot de passe de l'utilisateur $userName." >> $logPath
            echo "==========================================================="
            echo "Le mot de passe de l'utilisateur $userName va être modifié."
            ssh $userName@10.3.0.14 passwd
            echo "Vous allez être redirigé vers le menu précédent."
            sleep 2
            clear
        else
            echo "$date-$hour-$name-Aucune modification du mot de passe de l'utilisateur $userName" >> $logPath
            echo "================================================================"
            echo "Le mot de passe de l'utilisateur $userName ne sera pas supprimé."
            echo "Vous allez être redirigé vers le menu précédent."
            sleep 2
            clear
        fi
    else
        # The user doesn't exists
        echo "==============================================================="
        echo "L'utilisateur renseigné n'existe pas dans notre base de donnée."
        echo "Vous allez être redirigé vers le menu précédent."
        sleep 2
        clear
    fi 
}

###### Script #########
while true; do
    echo -e "================ ${cyan}Menu d'action : Utilisateur${noColor} ================="
    echo "========= Quel type d'action voulez-vous effectuer ? ========="
    echo " Choix 1 : Je veux créer un nouvel utilisateur."
    echo " Choix 2 : Je veux supprimer un utilisateur."
    echo " Choix 3 : Je veux modifier le mot de passe d'un utilisateur."
    echo " Choix 4 : Je veux retourner au menu précédent."
    echo " Choix 5 : Je veux retourner au menu de départ."
    echo " Choix 6 : Je veux sortir du script."
    echo "=============================================================="
    read -p "Votre choix : " choice

    case $choice in
        1)
            addUser
            ;;
        2)
            delUser
            ;;
        3)
            modifyUser
            ;;
        4)
            echo "$date-$hour-$name-Menu d'action_Utilisateur_Choix 4_Retour au menu précédent." >> $logPath
            echo "Vous avez choisi de revenir au menu précédent."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/user/menuUser.sh
            ;;
        5)
            echo "$date-$hour-$name-Menu d'action_Utilisateur_Choix 5_Retour au menu de départ." >> $logPath
            echo "Vous avez choisi de revenir au menu de départ."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/mainMenu.sh
            ;;
        6)
            echo "$date-$hour-$name-*********EndScript*********" >> $logPath
            echo "Vous avez choisi de sortir du script."
            sleep 2
            clear
            exit
            ;;
        *)
            echo "$date-$hour-$name-Menu d'action_Utilisateur_Réponse invalide, retour au menu actuel." >> $logPath
            echo -e "[${red}WARNING${noColor}] ${orange}Vous devez choisir l'une des options demandés ! ${noColor}"
            echo "Vous allez être redirigé au menu d'action : Utilisateur."
            sleep 2
            clear
            source /home/wilder/TheScriptingProject/user/actionUser.sh
            ;;
    esac
done
