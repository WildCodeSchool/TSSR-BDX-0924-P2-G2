<h1>Document Administrateur</h1>

<details>
    <summary><h2>Installation sous Linux<h2></summary>
    <br>

  + <details>
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

    + <details>
      <summary><h5>Configuration systèmes</h5></summary>
      <br>

      Cette machine aura les spécificités suivantes :
        * CPU : 2 cœur
        * RAM : Minimum - 512 Mo / Maximum - 2048 Mo
        * Stockage : HDD de 32 Go
    </details>

    + <details>
      <summary><h5>Configuration réseaux</h5></summary>
      <br>

      Cette machine aura les spécificités suivantes :
        * Carte réseau 1 : Connectés au NET pour recevoir les mises à jours systèmes.
          * Laisser le DHCP du proxmox lui donner son adresse IP.
        * Carte réseau 2 : Connectés au réseau interne pour pouvoir communiquer avec la machine cliente.

      Nous allons seulement configuré la carte réseau n°2<br>
      Pour cela, il faut aller modifier le fichier **/etc/netplan/*nomdufichier*.yaml** avec la commande suivante :
      ``` bash
      sudo nano /etc/netplan/nomdufichier.yaml
      ```
      A l'intérieur, il faudra le modifier comme suit :
      ``` bash
      # This file is generated from information provided by the datasource.  Changes
      # to it will not persist across an instance reboot.  To disable cloud-init's
      # network configuration capabilities, write a file
      # /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
      # network: {config: disabled}
      network:
          ethernets:
              ens18:
                  dhcp4: true
              ens19:
                  dhcp4: no
                  addresses:
                  - 172.16.10.10/24
          version: 2
      ```
      Puis l'enregistrer et faire la commande suivante pour appliquer la nouvelle configuration :
      ``` bash
      sudo netplan apply
      ```
      Pour vérifier si cela a fonctionner, faites la commande :
      ``` bash
      ip a
      ```
      Cela devrait vous donner :
      ``` bash
      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
        valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host noprefixroute
        valid_lft forever preferred_lft forever
      2: ens18: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
        link/ether bc:24:11:0b:e9:0c brd ff:ff:ff:ff:ff:ff
        altname enp0s18
        inet 10.3.0.10/24 metric 100 brd 10.3.0.255 scope global dynamic ens18
        valid_lft 5613sec preferred_lft 5613sec
        inet6 fe80::be24:11ff:fe0b:e90c/64 scope link
        valid_lft forever preferred_lft forever
      3: ens19: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
        link/ether bc:24:11:23:d2:94 brd ff:ff:ff:ff:ff:ff
        altname enp0s19
        inet 172.16.10.10/24 brd 172.16.10.255 scope global ens19
        valid_lft forever preferred_lft forever
        inet6 fe80::be24:11ff:fe23:d294/64 scope link
        valid_lft forever preferred_lft forever
      ```
      </details>
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
