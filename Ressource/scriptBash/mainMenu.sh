#!/bin/bash

#Function for user
#Action
function addUser () {
    echo "Vous avez choisi de créer un nouvel utilisateur. [IN PROGRESS]"
    exit
}
function delUser () {
    echo "Vous avez choisi de supprimer un nouvel utilisateur. [IN PROGRESS]"
    echo "Attention, nous vous préconisons de vérifier au préalable que l'Utilisateur cible existe avant de le supprimer."
}
function modifyUser () {
    echo "Vous avez choisi de modifier le mot de passe d'un utilisateur existant. [IN PROGRESS]"
    echo "Attention, nous vous préconisons de vérifier au préalable que l'Utilisateur cible existe avant de le supprimer."
}
#Information
function dateUser () {
    echo "Vous avez choisi de demander des informations sur la dernière date de connexion d'un utilisateur. [IN PROGRESS]"
}
function existUser () {
    echo "Vous avez choisi de demander des informations si un utilisateur existe ou non. [IN PROGRESS]"
}

#Function for computer
#Action
function rebootPC () {
    echo "Vous avez choisi de redémarrer l'ordinateur cible. [IN PROGRESS]"
}
function stopPC () {
    echo "Vous avez choisi d'arrêter l'ordinateur cible. [IN PROGRESS]"
}
#Information
function infoPC () {
    echo "Vous avez choisi de demander des informations sur l'ordinateur cible. [IN PROGRESS]"
}
function uptimePC () {
    echo "Vous avez choisi de demander depuis quand tourne l'ordinateur cible sans interruption. [IN PROGRESS]"
}

# Enregistrement des informations recueilli sur la cible (utilisateur ou ordinateur)
function recordInfo () {
    echo "Fonction pour enregistrer une ou des information et sera sauvegardé dans le dossier Documents. [IN PROGRESS]"
}

#Function log


# Display an ergonomic menu
# Choice of target, user or computer, choice of action or information & call of functions.
echo "================== Menu de départ ===================="
echo "====== Sur quel cible voulez-vous travailler ? ======="
echo " Choix 1 : Je veux travailler sur une cible de type utilisateur."
echo " Choix 2 : Je veux travailler sur une cible de type ordinateur."
echo " Choix 3 : Sortir du menu."
read -p "Votre choix : " target

if [ $target -gt 3 ]; then
    echo "[WARNING] Vous devez choisir l'une des options demandés."
    echo "Le script va donc redémarrer dans 5 secondes."
    sleep 2
    clear
    bash ./mainMenu.sh
else
    case $target in
        1)
            # User target
            clear
            echo "====== Menu cible : Utilisateur ======"
            echo "Voulez-vous faire des actions ou demander des informations ?"
            echo " Choix 1 : Je veux faire des actions sur la cible."
            echo " Choix 2 : Je veux demander des informations sur la cible."
            echo " Choix 3 : Retourner au menu de départ."
            read -p "Votre choix : " typeUser
            if [ $typeUser -gt 3 ]; then
                echo "[WARNING] Vous devez choisir l'une des options demandés."
                echo "Le script va donc redémarrer dans 5 secondes."
                sleep 2
                clear
                bash ./mainMenu.sh
            else
                case $typeUser in
                    1)
                        # Action utilisateur
                        echo "====== Menu d'action : Utilisateur ======"
                        echo "Quel action voulez-vous effectuer ?"
                        echo " Choix 1 : Créer un compte."
                        echo " Choix 2 : Supprimer un compte."
                        echo " Choix 3 : Modifier un compte."
                        echo " Choix 4 : Retourner au menu de départ."
                        read -p "Votre choix : " actionUser
                            if [ $actionUser -gt 4 ]; then
                                echo "[WARNING] Vous devez choisir l'une des options demandés."
                                echo "Le script va donc redémarrer dans 5 secondes."
                                sleep 2
                                clear
                                bash ./mainMenu.sh
                            else
                                case $actionUser in
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
                                        echo "Vous avez choisi de revenir au menu de départ."
                                        sleep 5
                                        clear
                                        bash ./mainMenu.sh
                                        ;;
                                esac
                            fi
                        ;;
                    2)
                        # Information utilisateur
                        echo "====== Menu d'information : Utilisateur ======"
                        echo "Quel type d'information voulez-vous ?"
                        echo " Choix 1 : La date de dernière connexion d'un utilisateur."
                        echo " Choix 2 : Savoir si l'utilisateur cible existe ou non."
                        echo " Choix 3 : Retourner au menu de départ."
                        read -p "Votre choix : " informationUser
                            if [ $informationUser -gt 3 ]; then
                                echo "[WARNING] Vous devez choisir l'une des options demandés."
                                echo "Le script va donc redémarrer dans 5 secondes."
                                sleep 2
                                clear
                                bash ./mainMenu.sh
                            else
                                case $informationUser in
                                    1)
                                        dateUser
                                        ;;
                                    2)
                                        existUser
                                        ;;
                                    3)
                                        echo "Vous avez choisi de revenir au Start Menu."
                                        sleep 2
                                        clear
                                        bash ./mainMenu.sh
                                        ;;
                                esac
                            fi
                        ;;
                    3)
                        echo "Vous avez choisi de revenir au Start Menu."
                        sleep 2
                        clear
                        bash ./mainMenu.sh
                        ;;
                esac
            fi
            ;;

        2)
            # Computer target
            clear
            echo "====== Menu cible : Ordinateur ======"
            echo "Voulez-vous faire des actions ou demander des informations ?"
            echo " Choix 1 : Je veux faire des actions sur la cible."
            echo " Choix 2 : Je veux demander des informations sur la cible."
            echo " Choix 3 : Retourner au menu de départ."
            read -p "Votre choix : " typeComputer
            if [ $typeComputer -gt 3 ]; then
                echo "[WARNING] Vous devez choisir l'une des options demandés."
                echo "Le script va donc redémarrer dans 5 secondes."
                sleep 2
                clear
                bash ../mainMenu.sh
            else
                case $typeComputer in
                    1)
                        echo "====== Menu d'action : Ordinateur ======"
                        echo "Quel action voulez-vous effectuer ?"
                        echo " Choix 1 : Eteindre l'ordinateur."
                        echo " Choix 2 : Redémarrer l'ordinateur."
                        echo " Choix 3 : Retourner au menu de départ."
                        read -p "Votre choix : " actionComputer
                        if [ $actionComputer -gt 3 ]; then
                            echo "[WARNING] Vous devez choisir l'une des options demandés."
                            echo "Le script va donc redémarrer dans 5 secondes."
                            sleep 2
                            clear
                            bash ./mainMenu.sh
                        else
                            case $actionComputer in
                                1)
                                    stopPC
                                    ;;
                                2)
                                    rebootPC
                                    ;;
                                3)
                                    echo "Vous avez choisi de revenir au Start Menu."
                                    sleep 2
                                    clear
                                    bash ./mainMenu.sh
                                    ;;
                            esac
                        fi
                        ;;
                    2)
                        echo "====== Menu d'information : Ordinateur ======"
                        echo "Quel type d'information voulez-vous ?"
                        echo " Choix 1 : Information sur le système d'exploitation."
                        echo " Choix 2 : Demande d'information sur l'uptime de l'ordinateur cible."
                        echo " Choix 3 : Retourner au menu de départ."
                        read -p "Votre choix : " informationComputer
                        if [ $informationComputer -gt 3 ]; then
                            echo "[WARNING] Vous devez choisir l'une des options demandés."
                            echo "Le script va donc redémarrer dans 5 secondes."
                            sleep 2
                            clear
                            bash ./mainMenu.sh
                        else
                            case $informationComputer in
                                1)
                                    infoPC
                                    ;;
                                2)
                                    uptimePC
                                    ;;
                                3)
                                    echo "Vous avez choisi de revenir au Start Menu."
                                    sleep 2
                                    clear
                                    bash ./mainMenu.sh
                                    ;;
                            esac
                        fi
                        ;;
                    3)
                        echo "Vous avez choisi de revenir au Start Menu."
                        sleep 2
                        clear
                        bash ./mainMenu.sh
                        ;;
                    esac
            fi
            ;;

        3)
            echo "Vous avez choisi de sortir du menu."
            sleep 2
            clear
            exit
            ;;
    esac
fi
