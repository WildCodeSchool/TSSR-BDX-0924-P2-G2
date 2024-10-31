#/bin/bash

###### Variable #######


###### Fonctions ######
function infoPC () {
    echo "Vous avez choisi de demander des informations sur l'ordinateur cible. [IN PROGRESS]"
}
function uptimePC () {
    echo "Vous avez choisi de demander depuis quand tourne l'ordinateur cible sans interruption. [IN PROGRESS]"
}
function recordInfo () {
    echo "Fonction pour enregistrer une ou des information et sera sauvegardé dans le dossier Documents. [IN PROGRESS]"
}


###### Script #########
echo "====== Menu d'information : Ordinateur ======"
echo "Quel type d'information voulez-vous ?"
echo " Choix 1 : Information sur le système d'exploitation."
echo " Choix 2 : Demande d'information sur l'uptime de l'ordinateur cible."
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
            infoPC
            ;;
        2)
            uptimePC
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
