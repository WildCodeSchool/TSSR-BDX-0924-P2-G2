#!/bin/bash

###### Variable #######


###### Fonctions ######
function dateUser () {
    echo "Vous avez choisi de demander des informations sur la dernière date de connexion d'un utilisateur. [IN PROGRESS]"
}
function existUser () {
    echo "Vous avez choisi de demander des informations si un utilisateur existe ou non. [IN PROGRESS]"
}
function recordInfo () {
    echo "Fonction pour enregistrer une ou des information et sera sauvegardé dans le dossier Documents. [IN PROGRESS]"
}


###### Script #########
echo "====== Menu d'information : Utilisateur ======"
echo "Quel type d'information voulez-vous ?"
echo " Choix 1 : La date de dernière connexion d'un utilisateur."
echo " Choix 2 : Savoir si l'utilisateur cible existe ou non."
echo " Choix 3 : Retourner au menu cible : Utilisateur."
echo " Choix 4 : Retourner au menu de départ."
read -p "Votre choix : " choice

if [ $choice -gt 4 ]; then
    echo "[WARNING] Vous devez choisir l'une des options demandés."
    echo "Le script va donc redémarrer dans 5 secondes."
    sleep 2
    clear
    bash ./mainScript.sh
else
    case $choice in
        1)
            dateUser
            ;;
        2)
            existUser
            ;;
        3)
            echo "Vous avez choisi de revenir au menu cible : Utilisateur."
            sleep 2
            clear
            bash ./utilisateur/menuUser.sh
            ;;
        4)
            echo "Vous avez choisi de revenir au menu de départ."
            sleep 2
            clear
            bash ./mainScript.sh
            ;;
    esac
fi
