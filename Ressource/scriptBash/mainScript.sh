#!/bin/bash

###### Variable #######


###### Fonctions ######


###### Script #########
echo "================== Menu de départ ===================="
echo "====== Sur quel cible voulez-vous travailler ? ======="
echo " Choix 1 : Je veux travailler sur une cible de type utilisateur."
echo " Choix 2 : Je veux travailler sur une cible de type ordinateur."
echo " Choix 3 : Sortir du menu."
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
            clear
            bash ./utilisateur/menuUser.sh
            ;;
        2)
            clear
            bash ./ordinateur/menuComputer.sh
            ;;
        3)
            echo "Vous avez choisi de sortir du menu."
            sleep 2
            clear
            exit
            ;;
    esac
fi
