# Script powershell

function DisplayMainMenu {
Clear-Host
Write-Host @"
+===============================================+
|          SERVER MENU - REMOTE CONTROL         | 
+===============================================+
|                                               | ____ ____  _   _ 
|              CHOIX DES ACTIONS                |/ ___/ ___|| | | |
|             -------------------               |\___ \___ \| |_| |
|                                               | ___) |__) |  _  |
|    1) SUR PC DISTANT                          ||____/____/|_| |_|                                               |
|    2) SUR UTILISATEURS DU PC DISTANT          |
|    3) QUITTER                                 |
|                                               |
|                                               |
+===============================================+

"@
}

function DisplayCPUMenu {
Clear-Host
Write-Host @"
+===============================================+
|                 CPU DISTANT                   | 
+===============================================+
|              CHOIX DES ACTIONS                |
|              -----------------                |                          
|                                               |        .----.
|    1) REDEMARRER                              |        |C>_ |
|    2) ETEINDRE                                |      __|____|__
|    3) AFFICHER INFOS SUR LE CPU               |     |  ______--|
|    4) REVENIR AU MENU PRINCIPAL               |     `-/.::::.\-'a
|    5) QUITTER                                 |      `--------'                         
|                                               |
+===============================================+

"@
}

function DisplayUserMenu {
Clear-Host
Write-Host @"
+===============================================+
|               MENU UTILISATEUR                | 
+===============================================+
|              CHOIX DES ACTIONS                |
|              -----------------                |
|    1) LISTE DES UTILISATEURS                  |
|    2) CREER UN UTILISATEUR                    |                ......
|    3) SUPPRIMER UN UTILISATEUR                |             .:||||||||:.
|    4) INFOS SUR UN UTILISATEUR                |            /            \
|    5) REVENIR AU MENU PRECEDENT               |           (   o      o   )
|    6) QUITTER                                 | --@@@@----------:  :----------@@@@--
|                                               |
+===============================================+

"@
}
Clear-Host
DisplayMainMenu
$MENU = Read-Host "VOTRE CHOIX"
Switch ($MENU) {
    1 {
    #OPTION1 - SUR PC DISTANT
        Clear-Host
        DisplayCPUMenu   
        $MENUCPU = Read-Host "VOTRE CHOIX"
        
        Switch ($MENUCPU){
            1 {
            #OPTIONCPU1 - REDEMARRER
            $OPTIONCPU1 = Read-Host "Redémarrage du PC distant ? Confirmez (O/N)"
            if ( $OPTIONCPU1 -eq 'O' ) { Write-Host "Le PC Distant va redémarrer..."}
            Start-Sleep -Seconds 2
            elsif ($OPTIONCPU1 -eq 'N' ){ Write-Host "Retour au menu CPU..." 
            Start-Sleep -Seconds 2
            DisplayCPUMenu }
            else { Write-Host "Mauvaise entrée..."
            Start-Sleep -Seconds 2
            DisplayCPUMenu }
            }
            2 {
            #OPTIONCPU2 - ETEINDRE
            $OPTIONCPU2 = Read-Host "Eteindre le PC distant ? Confirmez (O/N)"
            if ($OPTIONCPU2 -eq "O") {  Write-Host "Le PC distant va s'éteindre..." }
            elsif ($OPTION2 -eq "N") { Write-Host "Retour au menu CPU..." 
            Start-Sleep -Seconds 2
            DisplayCPUMenu }
            else { Write-Host "Mauvaise entrée..." 
            Start-Sleep -Seconds 2
            DisplayCPUMenu }
            }
            3 {
            #OPTIONCPU3 - AFFICHER INFOS CPU
            Write-Host "Le PC Distant est allumé depuis..."
            Write-Host "Ses services actifs sont..."
            }
            4 {
            #OPTION4 - RETOUR AU MENU PRINCIPAL
            .\Untitled1.ps1
            }
            }
      }
    2 {  
    #OPTION 2 SUR UTILISATEUR 
    Clear-Host
    DisplayUserMenu
            $MENUUSER = Read-Host "VOTRE CHOIX"
            Switch ($MENUUSER){
            1 {
            #OPTIONUSER1 - LISTE DES UTILISATEURS
            Write-Host "Les utilisateurs sont :"
         
            }
            2 {
            #OPTIONUSER2 - CREER UTILISATEURS
            $OPTIONUSER2 = Read-Host "Quel est le nom de l'utilisateur que vous voulez créer ?"
            Write-Host "L'utilisateur $($OPTIONUSER2) va être créé"
            }
            3 {
            #OPTIONUSER3 - SUPPRIMER UN UTILISATEUR
            $OPTIONUSER3 = Read-Host "Quel est le nom de l'utilisateur que vous voulez supprimer ?"
            Write-Host "L'utilisateur $($OPTIONUSER3) va être supprimé..."
        
            }
            4 {
            #OPTION4 - INFOS SUR LES UTILISATEURS
            $OPTIONUSER4 = Read-Host "Sur quel utilisateur voulez-vous des infos ?"
            Write-Host "L'utilisateur $($OPTIONUSER4) A été dernièrement connecté le .. à ..."
            }
            5 {
            #RETOUR AU MENU PRINCIPAL
            Clear-Host
            DisplayMainMenu
            }
            6 {
            #QUITTER
            Break
            }
        }
        }
     3 {
    #OPTION3 - QUITTER
    $OPTION3 = Write-Host "Au revoir !"
    Start-Sleep -Seconds 2
    break
    }
    default {
    #DEFAULT OPTION
    Write-Host "Option non valide"
    Start-Sleep -Seconds 2
    DisplayMainMenu
    }
}

DisplayMainMenu
