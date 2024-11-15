# A l'exécution du script, l'utilisateur doit renter le mot de passe Informations de connexion
# On attribue une valeur globale à nos variables afin qu'elles aient la bonne valeur dans le script de contrôle à distance
$global:hostname = "10.1.0.43"
$global:username = "wilder"
Write-Warning "Le PC distant est un PC WINDOWS 10 `nL'utilistateur principal est wilder, pour agir sur cette session distante vous aller devoir rentrer le mot de passe."
Start-Sleep -Seconds 2
$global:passWord = Read-Host "Veuillez entrer le mot de passe pour l'utilisateur "wilder"" -AsSecureString
$global:credential = New-Object -TypeName System.Management.Automation.PSCredential -
$global:credential = New-Object System.Management.Automation.PSCredential ($username, $password)