#!/bin/bash

###### Variable #######


###### Fonctions ######


###### Script #########
echo "====== Menu cible : Utilisateur ======"
echo "Voulez-vous faire des actions ou demander des informations ?"
echo " Choix 1 : Je veux faire des actions sur la cible."
echo " Choix 2 : Je veux demander des informations sur la cible."
echo " Choix 3 : Retourner au menu de départ."
read -p "Votre choix : " choice

if [ $choice -gt 3 ]; then
    echo "[WARNING] Vous devez choisir l'une des options demandés."
    echo "Le script va donc redémarrer dans 5 secondes."
    sleep 2
    clear
    bash ./mainScript.sh
else
    case $choice in
    1)
        bash ./utilisateur/actionUser.sh
        ;;
    2)
        bash ./utilisateur/infoUser.sh
        ;;
    3)
        echo "Vous avez choisi de revenir au menu de départ."
        sleep 2
        clear
        bash ./mainScript.sh
        ;;
    esac
fi
