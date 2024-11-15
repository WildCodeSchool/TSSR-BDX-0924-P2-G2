#Fonction pour l'affichage du menu principal

function DisplayMainMenu {
Clear-Host
Write-Host @"

+===============================================+
|  MENU SERVEUR - ACTION SUR CPU CLIENT DISTANT | 
+===============================================+
|                                               |       ____ ____  _   _ 
|              CHOIX DES ACTIONS                |      / ___/ ___|| | | |
|             -------------------               |      \___ \___ \| |_| |
|                                               |       ___) |__) |  _  |
|    1) SUR PC DISTANT                          |      |____/____/|_| |_|
|    2) SUR UTILISATEURS DU PC DISTANT          |
|    3) QUITTER                                 |
|                                               |
|                                               |
+===============================================+

"@ -ForegroundColor Green
}


#Fonction por l'affichage du menu secondaire CPU DISTANT
function DisplayCPUMenu {
Clear-Host
Write-Host @"

+===============================================+
|                 CPU DISTANT                   | 
+===============================================+
|              CHOIX DES ACTIONS                |
|              -----------------                |
|                                               |        _/_/_/  _/_/_/    _/    _/   
|    1) REDEMARRER                              |     _/        _/    _/  _/    _/    
|    2) ETEINDRE                                |    _/        _/_/_/    _/    _/     
|    3) AFFICHER SERVICES ACTIFS DU CPU         |   _/        _/        _/    _/      
|    4) AFFICHER TEMPS D'ALLUMAGE DU CPU        |    _/_/_/  _/          _/_/         
|    5) REVENIR AU MENU PRINCIPAL               |
|    6) QUITTER                                 |
|                                               |
+===============================================+

"@ -ForegroundColor Green
}


#Fonction pour l'affichage du menu secondaire UTILISATEURS
function DisplayUserMenu {
Clear-Host
Write-Host @"

+===============================================+
|               MENU UTILISATEUR                | 
+===============================================+
|              CHOIX DES ACTIONS                |
|              -----------------                |
|    1) LISTE DES UTILISATEURS                  |      _____ _____ _____ _____ 
|    2) CREER UN UTILISATEUR                    |     |  |  |   __|   __| __  |
|    3) SUPPRIMER UN UTILISATEUR                |     |  |  |__   |   __|    -|
|    4) INFOS SUR UN UTILISATEUR                |     |_____|_____|_____|__|__|
|    5) REVENIR AU MENU PRINCIPAL               |
|    6) QUITTER                                 |
|                                               |
+===============================================+

"@ -ForegroundColor Green
}

# Fonction pour exécuter une commande PowerShell à distance
function Executer-Commande { 
    param ( 
        [string]$execommande 
    ) 
    $result = Invoke-SSHCommand -SessionId $session.SessionId -Command "powershell -Command `"try { $execommande } catch { $_ }`"" 
    if ($result.ExitStatus -ne 0) { 
        Write-Host "Erreur lors de l'exécution de la commande : $($result.Error)" 
    } else { 
        $result.Output 
    }
}


# Fonction pour obtenir l'heure et la date d'allumage du PC distant
function ObtenirTempsAllumage { 
    $commande1 = "Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty LastBootUpTime"
    $uptimeInfo = Executer-Commande $commande1

    if ($uptimeInfo) {
        try {
            # Nettoyer la chaîne en enlevant les espaces et en extrayant la date brute
            $uptimeInfo = $uptimeInfo.Trim()
            
            # Extraire les 14 premiers caractères de la chaîne WMI si nécessaire
            if ($uptimeInfo.Length -ge 14) {
                $uptimeInfo = $uptimeInfo.Substring(0, 14)  # Garde seulement "yyyyMMddHHmmss"
            }

            # Convertir la chaîne manuellement en un format lisible
            $year = $uptimeInfo.Substring(0, 4)
            $month = $uptimeInfo.Substring(4, 2)
            $day = $uptimeInfo.Substring(6, 2)
            $hour = $uptimeInfo.Substring(8, 2)
            $minute = $uptimeInfo.Substring(10, 2)
            $second = $uptimeInfo.Substring(12, 2)
            
            # Formater la date et l'heure
            $formattedUptimeInfo = "${year}-${month}-${day} ${hour}:${minute}:${second}"

            # Calcul du temps écoulé depuis l'allumage
            $bootDate = [datetime]::ParseExact($formattedUptimeInfo, "yyyy-MM-dd HH:mm:ss", $null)
            $uptime = [datetime]::Now - $bootDate

            Write-Host "Informations d'allumage du PC distant :" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "=============================="
            Write-Host "L'ordinateur distant est allumé depuis : " -ForegroundColor Green
            Write-Host "$formattedUptimeInfo" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "Temps de fonctionnement : $($uptime.Days) jours, $($uptime.Hours) heures, $($uptime.Minutes) minutes" -ForegroundColor Yellow
            Write-Host "=============================="
        } catch {
            Write-Host "Erreur lors de la conversion de l'heure d'allumage." -ForegroundColor Red
        }
    } else { 
        Write-Host "Erreur de récupération des informations d'allumage." -ForegroundColor Red
    }
}

# Affiche un message et attend que l'utilisateur appuie sur "Entrée" 
function AttendreEntree { 
Write-Host "Appuyez sur Entrée pour continuer..." 
Read-Host 
}

# Fonction pour créer un utilisateur via SSH
function CreerUtilisateur { 
    param (
        [string]$nomUtilisateur, 
        [SecureString]$motDePasse 
    )
    
    $nomUtilisateur = Read-Host "Quel est le nom de l'utilisateur que vous voulez créer ?" 
    $motDePasse = Read-Host "Quel mot de passe voulez-vous pour cet utilisateur ?" -AsSecureString
    $plainMotDePasse = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($motDePasse))

    $commande = "net user $nomUtilisateur $plainMotDePasse /add"
    $result = Executer-Commande $commande

    # Libérer la mémoire allouée pour le mot de passe en clair
    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($motDePasse))

    if ($result) {
        Write-Host "Utilisateur $nomUtilisateur créé sur le PC distant." -ForegroundColor Green
        Write-Host "Voici maintenant la liste des utilisateurs sur le PC distant :"
        ListerUtilisateurs
        AttendreEntree
    } else {
        Write-Host "Erreur lors de la création de l'utilisateur $nomUtilisateur." -ForegroundColor Red
    }

 }


# Fonction pour supprimer un utilisateur via SSH
function SupprimerUtilisateur {
    param (
        [string]$nomUtilisateur
    )
    $commande = "net user $nomUtilisateur /delete"
    Executer-Commande $commande
    Write-Host "Utilisateur $nomUtilisateur supprimé sur le PC distant."
    Write-Host "Voici maintenant la liste des utilisateurs sur le PC distant :"
    ListerUtilisateurs
    AttendreEntree
    Start-Sleep -Seconds 2
}

# Fonction pour lister les utilisateurs
function ListerUtilisateurs {
    $commande = "net user"
    $utilisateurs = Executer-Commande $commande
    Write-Host "Liste des utilisateurs sur le PC distant :"
    $utilisateurs | ForEach-Object { Write-Host $_ -ForegroundColor Cyan }
    
}

# Fonction pour obtenir des informations supplémentaires sur un utilisateur
function ObtenirInfosUtilisateur {
    param (
        [string]$nomUtilisateur
    )

    # Récupération de l'UUID
    $commandeUUID = "Get-WmiObject -Class Win32_ComputerSystemProduct | Select-Object -ExpandProperty UUID"
    $UUID = Executer-Commande $commandeUUID

    # Récupération des informations de l'utilisateur via Get-LocalUser
    $commandeLocalUser = "Get-LocalUser -Name '$nomUtilisateur'"
    $localUser = Executer-Commande $commandeLocalUser

    # Récupération des tentatives de connexion échouées
    $commandeLogonFailures = "Get-WmiObject -Class Win32_NetworkLoginProfile -Filter ""Name = '$nomUtilisateur'"" | Select-Object -ExpandProperty BadPasswordCount"
    $logonFailures = Executer-Commande $commandeLogonFailures

    # Extraction des informations de diverses sources
    if ($localUser) {
        $accountStatus = $localUser.Enabled -eq $false
        $lockedOut = $localUser.LockedOut
    } else {
        $accountStatus = "Non disponible"
        $lockedOut = "Non disponible"
    }

    # Affichage des informations de l'utilisateur
    Write-Host "Informations sur l'utilisateur $nomUtilisateur :"
    Write-Host "UUID : $UUID"
    Write-Host "Statut du compte : $(if ($accountStatus) { 'Désactivé' } else { 'Actif' })"
    Write-Host "Compte verrouillé : $(if ($lockedOut) { 'Oui' } else { 'Non' })"
    Write-Host "Échecs de connexion : $logonFailures"
}



# Fonction pour afficher les services actifs 
function AfficherServicesActifs { 
$commande = "Get-Service" 
$services = Executer-Commande $commande 
Write-Host "Services actifs sur le PC distant :" 
if ($services) { 
    foreach ($service in $services) { 
        if ($service -match "Running") { 
        Write-Host $service 
        }
     } 
  } 
else { Write-Host "Aucun service actif trouvé ou erreur de récupération." } 
}


#Exécution du script por la connection SSH

C:\Users\Administrator\Documents\CoSSH.ps1

# Création d' une session SSH
$session = New-SSHSession -ComputerName $hostname -Credential $credential

# Récupérer l'index de la session SSH active 
$index = ($session | Select-Object -ExpandProperty SessionId) 

# Vérifier si la session SSH est bien établie
if ($session -eq $null) {
    Write-Host "Échec de la connexion SSH." -ForegroundColor Red
    Start-Sleep -Seconds 2
    exit }
else { Write-Host "La connection avec L'ordinateur distant $hostname a bien été établie" -ForegroundColor Green
      Start-Sleep -Seconds 2
}


C:\Users\Administrator\Documents\ExecScript.ps1



