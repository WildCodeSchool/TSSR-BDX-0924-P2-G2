#!/bin/bash

#Function for user
#Action
function addUser () {
    echo "Vous avez choisi de créer un nouvel utilisateur. [IN PROGRESS]"
    exit
}
function delUser () {
    echo "Vous avez choisi de supprimer un nouvel utilisateur. [IN PROGRESS]"
}
function modifyUser () {
    echo "Vous avez choisi de modifier le mot de passe d'un utilisateur existant. [IN PROGRESS]"
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

# Display an ergonomic menu
# Choice of target, user or computer, choice of action or information & call of functions.
echo "================== Start Menu ===================="
echo "====== Sur quel cible voulez-vous travailler ? ======"
echo " Choix 1 : Je veux travailler sur une cible de type utilisateur."
echo " Choix 2 : Je veux travailler sur une cible de type ordinateur."
echo " Choix 3 : Sortir du menu."
read -p "Your choice : " target

if [ $target -gt 3 ]; then
    echo "[WARNING] Vous devez choisir l'une des options demandés."
    echo "Le script va donc redémarrer dans 5 secondes."
    sleep 5
    clear
    bash ./scriptBash.sh
else
    case $target in
        1)
        # User target
        clear
        echo "====== You choose to work on a user target. ======"
        echo "Do you want to take action or ask for information ?"
        echo " Choice 1 : Take action."
        echo " Choice 2 : Ask for information."
        echo " Choice 3 : Return to the start menu."
        read -p "Your choice : " typeUser
        if [ $typeUser -gt 3 ]; then
            echo "[WARNING] You need to choose between the differents choice proposed."
            echo "The script will now reboot."
            clear
            bash ./scriptBash.sh
        else
            case $typeUser in
                1)
                # Action utilisateur
                echo "====== You choose to take action. ======"
                echo "What action do you want to do ?"
                echo " Choice 1 : Create an account."
                echo " Choice 2 : Delete an account."
                echo " Choice 3 : Modify an account."
                echo " Choice 4 : Return to the start menu."
                read -p "Your choice : " actionUser
                    if [ $actionUser -gt 4 ]; then
                            echo "[WARNING] You need to choose between the differents choice proposed."
                            echo "The script will now reboot."
                            clear
                            bash ./scriptBash.sh
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
                        echo "You choose to return to the start menu."
                        clear
                        bash ./scriptBash.sh
                        ;;
                        esac
                    fi
                ;;
                2)
                # Information utilisateur
                echo "====== You choose to ask for information. ======"
                echo "What information do you want ?"
                echo " Choice 1 : Date of last login of a user."
                echo " Choice 2 : Existence of a user."
                echo " Choice 3 : Return to the start menu."
                read -p "Your choice : " informationUser
                    if [ $informationUser -gt 3 ]; then
                            echo "[WARNING] You need to choose between the differents choice proposed."
                            echo "The script will now reboot."
                            clear
                            bash ./scriptBash.sh
                    else
                        case $informationUser in
                        1)
                        dateUser
                        ;;
                        2)
                        existUser
                        ;;
                        3)
                        echo "You choose to return to the start menu."
                        clear
                        bash ./scriptBash.sh
                        ;;
                        esac
                    fi
                ;;
                3)
                echo "You choose to return to the start menu."
                clear
                bash ./scriptBash.sh
                ;;
            esac
        fi
        ;;

        2)
        # Computer target
        clear
        echo "====== You choose to work on a computer target. ======"
        echo "Do you want to take action or ask for information ?"
        echo " Choice 1 : Take action."
        echo " Choice 2 : Ask for information."
        echo " Choice 3 : Return to the start menu."
        read -p "Your choice : " typeComputer
        if [ $typeComputer -gt 3 ]; then
            echo "[WARNING] You need to choose between the differents choice proposed."
            echo "The script will now reboot."
            clear
            bash ./scriptBash.sh
        else
            case $typeComputer in
            1)
            echo "====== You choose to take action. ======"
            echo "What action do you want to do ?"
            echo " Choice 1 : Shutting down the computer."
            echo " Choice 2 : Reboot the computer."
            echo " Choice 3 : Return to the start menu."
            read -p "Your choice : " actionComputer
            if [ $actionComputer -gt 3 ]; then
                echo "[WARNING] You need to choose between the differents choice proposed."
                echo "The script will now reboot."
                clear
                bash ./scriptBash.sh
            else
                case $actionComputer in
                1)
                stopPC
                ;;
                2)
                rebootPC
                ;;
                3)
                echo "You choose to return to the start menu."
                clear
                bash ./scriptBash.sh
                ;;
                esac
            fi
            ;;
            2)
            echo "====== You choose to ask for information. ======"
            echo "What information do you want ?"
            echo " Choice 1 : Information about the OS of the computer."
            echo " Choix 2 : Demande d'information sur l'uptime de l'ordinateur cible."
            echo " Choice 3 : Return to the start menu."
            read -p "Your choice : " informationComputer
            if [ $informationComputer -gt 3 ]; then
                echo "[WARNING] You need to choose between the differents choice proposed."
                echo "The script will now reboot."
                clear
                bash ./scriptBash.sh
            else
                case $informationComputer in
                1)
                infoPC
                ;;
                2)
                uptimePC
                ;;
                3)
                echo "You choose to return to the start menu."
                clear
                bash ./scriptBash.sh
                ;;
                esac
            fi
            ;;
            3)
            echo "You choose to return to the start menu."
            clear
            bash ./scriptBash.sh
            ;;
            esac
        fi
        ;;

        3)
        echo "You choose to exit the menu."
        clear
        exit
        ;;
    esac
fi
