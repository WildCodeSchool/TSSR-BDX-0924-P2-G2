#!/bin/bash

###### Variable #######


###### Fonctions ######
function rebootPC () {
    echo "Vous avez choisi de redémarrer l'ordinateur cible. [IN PROGRESS]"
}
function stopPC () {
    echo "Vous avez choisi d'arrêter l'ordinateur cible. [IN PROGRESS]"
}


###### Script #########
echo "====== Menu d'action : Ordinateur ======"
echo "Quel action voulez-vous effectuer ?"
echo " Choix 1 : Eteindre l'ordinateur."
echo " Choix 2 : Redémarrer l'ordinateur."
echo " Choix 3 : Retourner au menu cible : Ordinateur."
echo " Choix 4 : Retourner au menu de départ."
read -p "Votre choix : " choice

if [ $choice -gt 4 ]; then
    echo "[WARNING] Vous devez choisir l'une des options demandés."
    echo "Le script va donc redémarrer dans 5 secondes."
    sleep 2
    clear
    bash ./mainMenu.sh
else
    case $choice in
        1)
            stopPC
            ;;
        2)
            rebootPC
            ;;
        3)
            echo "Vous avez choisi de revenir au menu cible : Ordinateur."
            sleep 2
            clear
            bash ./ordinateur/menuComputer.sh
            ;;
        4)
            echo "Vous avez choisi de revenir au Start Menu."
            sleep 2
            clear
            bash ./mainMenu.sh
            ;;
    esac
fi
