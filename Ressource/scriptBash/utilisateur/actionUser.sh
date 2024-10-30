#!/bin/bash

###### Variable #######


###### Fonctions ######
function addUser () {
    echo "Vous avez choisi de créer un nouvel utilisateur. [IN PROGRESS]"
}
function delUser () {
    echo "Vous avez choisi de supprimer un nouvel utilisateur. [IN PROGRESS]"
}
function modifyUser () {
    echo "Vous avez choisi de modifier le mot de passe d'un utilisateur existant. [IN PROGRESS]"
}


###### Script #########
echo "====== Menu d'action : Utilisateur ======"
echo "Quel action voulez-vous effectuer ?"
echo " Choix 1 : Créer un compte."
echo " Choix 2 : Supprimer un compte."
echo " Choix 3 : Modifier un compte."
echo " Choix 4 : Retourner au menu cible : Utilisateur."
echo " Choix 5 : Retourner au menu de départ."
read -p "Votre choix : " choice

if [ $choice -gt 5 ]; then
    echo "[WARNING] Vous devez choisir l'une des options demandés."
    echo "Le script va donc redémarrer dans 5 secondes."
    sleep 2
    clear
    bash ./mainScript.sh
else
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
            echo "Vous avez choisi de revenir au menu cible : Utilisateur."
            sleep 2
            clear
            bash ./utilisateur/menuUser.sh
            ;;
        5)
            echo "Vous avez choisi de revenir au menu de départ."
            sleep 2
            clear
            bash ./mainScript.sh
            ;;
    esac
fi
