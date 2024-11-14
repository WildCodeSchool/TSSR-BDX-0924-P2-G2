<h1>Document Administrateur</h1>

<details>
    <summary><h2>Installation sous Linux<h2></summary>
    <br>

<details>
    <summary><h4>Prérequis techniques</h4></summary>

    **Serveur Debian 12 (en CLI sans GUI) :**
      * Nom : **SRVLX01**
      * Compte : **root**
      * Mot de passe : **Azerty1**
      * Adresse IP fixe : **172.16.10.10/24**
    <br>

    **Client Ubuntu 22.04/24.04 LTS :**
      * Nom : **SRVLX01**
      * Compte : **root**
      * Mot de passe : **Azerty1**
      * Adresse IP fixe : **172.16.10.10/24**
    <br>

    Notre projet s'est fait sur des machines virtuelles avec l'hyperviseur Proxmox.<br>
    Chacune de ces machines a leurs propres configuration qui sera détaillé dans les chapitres suivants.
</details>

  + <details>
    <summary><h4>Etapes d'installation et de configuration de la machine SRVLX01.</h4></summary>
    <br>

    ##### Configuration systèmes

  </details>

</details>

<details>
    <summary><h2>Installation sous Windows<h2></summary>
    <br>
  + <details>
    <summary><h4>Prérequis techniques<h4></summary>
    <br>

    **Serveur Windows Server 2022 (avec GUI):**
    Nom : **SRVWIN01**
    Compte : **Administrator** (dans le groupe des admins locaux)
    Mot de passe : **Azerty1***
    Adresse IP fixe : **172.16.10.5/24**

    **Client Windows 10 :**
    Nom : **CLIWIN01**
    Compte utilisateur : **wilder** (dans le groupe des admins locaux)
    Mot de passe : **Azerty1***
    Adresse IP fixe : **172.16.10.20/24**

    </details>

  + <details>
    <summary><h4>Etapes d'installation et de configuration<h4></summary>
    <br>

    #### Instruction étape par étape :

    Le script va s'exécuter sur le PC WINDOWS SERVER 2022 et agir sur le PC distant WINDOWS 11 client.
    Il va donc falloir configurer :
    **1- Le PC Windows Serveur**
    **2- Le PC Windows Client**

    **Configuration et installations des deux interfaces Windows**

    Toutes les opératieons décrites ci-après se trouvent dans le script co_ssh.ps1 etr sont donc automatisées.
    Pour commencer, il faut ouvrir Powershell en tant qu'administrateur
    Installer Open ssh sur le serveur avec la commande :

        Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0


    Après ça il faut démarrer le service ssh :

        Start-Service sshd

    Ensuite, on le configure pour qu'il démarre automatiquement :

        Set-Service -Name -StartupType "Automatic"

    Le démarrage du service SSH a généré le fichier de configuration C:\ProgramData\ssh\sshd_config .
    Nous allons le modifier avec le bloc notes Windows :

        notepad C:\ProgramData\ssh\sshd_config

    Une fois le fichier ouvert, nous allons modifier la configuration du serveur SSH en autorisant la connexion par mot de passe. Pour ce faire il faut retirer le caractère # situé devant cette ligne :

    <P ALIGN="center"><IMG src="https://github.com/WildCodeSchool/TSSR-BDX-0924-P2-G2/tree/main/Images/notepad1.png" width=600></P>

    Nous devons ajouter la prise en charge de PowerShell en l'intégrant en tant que sous-système, sinon il n'y a que quelques commandes qui vont fonctionner (non PowerShell). Vous devez ajouter cette nouvelle ligne à la suite de ces deux lignes :

        Subsystem powershell c:/progra~1/powershell/7/pwsh.exe -sshs -NoLogo

    <P ALIGN="center"><IMG src="https://github.com/WildCodeSchool/TSSR-BDX-0924-P2-G2/tree/main/Images/notepad2.png" width=600></P>

    </details>



  + <details>
    <summary><h4>F.A.Q.<h4></summary>

    #### Solutions aux problèmes et communs liés à l'installation et à la configuration.


    </details>
</details>
