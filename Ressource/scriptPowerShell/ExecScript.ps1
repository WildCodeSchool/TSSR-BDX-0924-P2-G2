Clear-Host
DisplayMainMenu
$MENU = Read-Host "VOTRE CHOIX"
Switch ($MENU) {
    1 {
        # OPTION1 - SUR PC DISTANT
        Clear-Host
        DisplayCPUMenu   
        $MENUCPU = Read-Host "VOTRE CHOIX"
        
        Switch ($MENUCPU){
            1 {
                # OPTIONCPU1 - REDEMARRER
                $OPTIONCPU1 = Read-Host "Redémarrage du PC distant ? Confirmez (O/N)"
                
                if ( $OPTIONCPU1 -eq 'O' ) { 
                    Write-Host "Le PC Distant va redémarrer..."
                    Executer-Commande "Restart-Computer -Force" 
                    Start-Sleep -Seconds 3
                    C:\Users\Administrator\Documents\ExecScript.ps1
                } elseif ($OPTIONCPU1 -eq 'N') { 
                    Write-Host "Retour au menu principal..." 
                    Start-Sleep -Seconds 2
                    C:\Users\Administrator\Documents\ExecScript.ps1 
                } else { 
                    Write-Host "Mauvaise entrée, retour au menu principal..."
                    Start-Sleep -Seconds 2
                    C:\Users\Administrator\Documents\ExecScript.ps1 
                }
            }
            2 {
                # OPTIONCPU2 - ETEINDRE
                $OPTIONCPU2 = Read-Host "Eteindre le PC distant ? Confirmez (O/N)"
                if ($OPTIONCPU2 -eq "O") {  
                    Write-Host "Le PC distant va s'éteindre..."
                    Executer-Commande "Stop-Computer -Force"
                    Start-Sleep -Seconds 2
                    Write-Host "Fermeture du programme..."
                    Write-Host "Avant de réexécuter le Script, pensez à redémarrer l'ordinateur distant"
                    Write-Host "Au revoir ! "
                    Start-Sleep -Seconds 2
                    Break 
                } elseif ($OPTIONCPU2 -eq "N") { 
                    Write-Host "Retour au menu principal..." 
                    Start-Sleep -Seconds 2
                    C:\Users\Administrator\Documents\ExecScript.ps1 
                } else { 
                    Write-Host "Mauvaise entrée, retour au menu principal..." -ForegroundColor Red
                    Start-Sleep -Seconds 2
                    C:\Users\Administrator\Documents\ExecScript.ps1 
                }
            }
            3 {
                # OPTIONCPU3 - AFFICHER SERVICES ACTIFS CPU
                Write-Host "Services actifs :"
                AfficherServicesActifs
                AttendreEntree
                C:\Users\Administrator\Documents\ExecScript.ps1          
            }
            
            4 {
                # OPTIONCPU4 - AFFICHER TEMPS D'ALLUMAGE PC DISTANT
                ObtenirTempsAllumage
                AttendreEntree
                C:\Users\Administrator\Documents\ExecScript.ps1
            }
            5 {
                # OPTIONCPU5 - RETOUR AU MENU PRINCIPAL
                Clear-Host
                C:\Users\Administrator\Documents\ExecScript.ps1
            }
            6 { 
                # OPTIONCPU 6 - QUITTER 
                Write-Host "Au revoir !" 
                Write-Host "Fermeture de la connexion avec l'ordinateur distant..." 
                Start-Sleep -Seconds 2 
                # Fermeture de la session SSH 
                Remove-SSHSession -Index $index -Verbose 
                # Vérification si la session SSH est bien fermée 
                $sessionStatus = Get-SSHSession -Index $index 
                if ($sessionStatus -eq $null) { 
                    Write-Host "La connexion avec l'ordinateur distant est bien fermée." -ForegroundColor Green 
                    Start-Sleep -Seconds 2 
                    exit 
                } else { 
                    Write-Host "La connexion avec l'ordinateur distant $hostname est encore active !" -ForegroundColor Red 
                    Start-Sleep -Seconds 2 
                    exit 
                } 
                Clear-Host 
            }
            default {
                Write-Host "[ERREUR] Mauvaise saisie, veuillez entrer une saisie valide" -ForegroundColor Red

                DisplayCPUMenu
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
            ListerUtilisateurs
            AttendreEntree
            C:\Users\Administrator\Documents\ExecScript.ps1
                     
            }
            2 {
            #OPTIONUSER2 - CREER UTILISATEURS
            CreerUtilisateur
            C:\Users\Administrator\Documents\ExecScript.ps1
            }
            3 {
            #OPTIONUSER3 - SUPPRIMER UN UTILISATEUR
            ListerUtilisateurs
            $OPTIONUSER3 = Read-Host "Quel est le nom de l'utilisateur que vous voulez supprimer ?"
            Write-Host "L'utilisateur $($OPTIONUSER3) va être supprimé..."
            Start-Sleep -Seconds 2
            SupprimerUtilisateur -nomUtilisateur "$OPTIONUSER3"
            C:\Users\Administrator\Documents\ExecScript.ps1
            }
            4 {
            # OPTIONUSER4 - INFOS SUR LES UTILISATEURS
            Write-Host "Voici la liste des utilisateurs sur le PC distant :"
            ListerUtilisateurs
            $OPTIONUSER4 = Read-Host "Sur quel utilisateur voulez-vous des infos ?"
            ObtenirInfosUtilisateur -nomUtilisateur $OPTIONUSER4
            AttendreEntree
            C:\Users\Administrator\Documents\ExecScript.ps1
            }

            5 {
            #OPTIONUSER5 - RETOUR AU MENU PRINCIPAL
            C:\Users\Administrator\Documents\ExecScript.ps1
            }
            6 { 
            # OPTIONUSER 6 - QUITTER 
            Write-Host "Au revoir !" 
            Write-Host "Fermeture de la connexion avec l'ordinateur distant..." 
            Start-Sleep -Seconds 2 
            # Fermeture de la session SSH 
            Remove-SSHSession -Index $index -Verbose 
            # Vérification si la session SSH est bien fermée 
            $sessionStatus = Get-SSHSession -Index $index 
            if ($sessionStatus -eq $null) { 
            Write-Host "La connexion avec l'ordinateur distant est bien fermée." -ForegroundColor Green 
            Start-Sleep -Seconds 2 
            exit } 
            else { 
            Write-Host "La connexion avec l'ordinateur distant $hostname est encore active !" -ForegroundColor Red 
            Start-Sleep -Seconds 2 exit } 
            Clear-Host 
     }
            default {
                Write-Host "[ERREUR] Mauvaise saisie, veuillez entrer une saisie valide" 
                Start-Sleep -Seconds 2
                DisplayUserMenu
            }
        }
        }
     3 { 
     # OPTION 3 - QUITTER 
     Write-Host "Au revoir !" 
     Write-Host "Fermeture de la connexion avec l'ordinateur distant..." 
     Start-Sleep -Seconds 2 
     # Fermeture de la session SSH 
     Remove-SSHSession -Index $index -Verbose 
     # Vérification si la session SSH est bien fermée 
     $sessionStatus = Get-SSHSession -Index $index 
     if ($sessionStatus -eq $null) { 
     Write-Host "La connexion avec l'ordinateur distant est bien fermée." -ForegroundColor Green 
     Start-Sleep -Seconds 2 
     exit } 
     else { 
     Write-Host "La connexion avec l'ordinateur distant $hostname est encore active !" -ForegroundColor Red 
     Start-Sleep -Seconds 2 exit } 
     Clear-Host 
     }
    default {
    #DEFAULT OPTION
    Write-Host "Option non valide"
    Start-Sleep -Seconds 2
    C:\Users\Administrator\Documents\ExecScript.ps1
    }
}

