# Documents Administrateurs

<summary><h2> Installation sous Linux </h2></summary>
<br>

<details>
<summary><h4> Prérequis techniques </h4></summary>
<br>

**Serveur Debian 12 (en CLI sans GUI) :**
  * Nom : **SRVLX01**
  * Compte : **root**
  * Mot de passe : **Azerty1***
  * Adresse IPv4 fixe : **172.16.10.10/24**

**Client Ubuntu 22.04/24.04 LTS :**
  * Nom : **CLILIN01**
  * Compte : **wilder**
  * Mot de passe : **Azerty1***
  * Adresse IPv4 fixe : **172.16.10.30/24**

</details>

<details>
<summary><h4> Configuration de la machine SRVLX01 </h4></summary>

  + <details>
    <summary><h5> Configuration système </h5></summary>
    <br>

    Cette machine aura les spécificités suivantes :
      * CPU : 2 cœurs
      * RAM :
        * Minimum : 512 Mo
        * Maximum : 2048 Mo
      * Stockage : Disque dur HDD de 32 Go
      
    </details>

  + <details>
    <summary><h5> Configuration réseaux </h5></summary>
    
    Cette machine aura les spécificités suivantes :
      * Carte réseau 1 : Connectés au NET pour recevoir les mises à jours systèmes.
        * Laisser le DHCP du proxmox lui donner son adresse IP.
      * Carte réseau 2 : Connectés au réseau interne pour pouvoir communiquer avec la machine cliente.

    Nous allons seulement configuré la carte réseau N°2. Pour cela, il faut aller modifier le fichier **/etc/netplan/nomdufichier.yaml** avec la commande suivante :
    ```bash
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
    
  + <details>
    <summary><h5> Configuration SSH </h5></summary>
    
    La machine serveur envoie des demandes de connexion SSH, il faudra donc installer le paquet OpenSSH-Client . Pour cela, faite la commande suivante :
    ``` bash
    sudo apt-get install openssh-client -y
    ```
    Maintenant qu'il est installé, vous pouvez vérifier la connexion avec une machine cible. Pour cela, faite la commande suivante :
    ``` bash
    ssh wilder@172.16.10.30
    ```
    Il vous sera demandé un mot de passe, qui correspond à celui de l'utilisateur de la machine distante à laquelle vous vous connecter. Une fois la connexion établie, vous aurez le contrôle à distance de la machine cliente sur votre machine serveur,comme suit :
    ``` bash
    wilder@SRVLX01:~$ ssh wilder@172.16.10.30
    wilder@172.16.10.30's password:
    Welcome to Ubuntu 24.04.1 LTS (GNU/Linux 6.8.0-48-generic x86_64)
    
    * Documentation:  https://help.ubuntu.com
    * Management:     https://landscape.canonical.com
    * Support:        https://ubuntu.com/pro

    La maintenance de sécurité étendue pour Applications n'est pas activée.

    16 mises à jour peuvent être appliquées immédiatement.
    Pour afficher ces mises à jour supplémentaires, exécuter : apt list --upgradable

    Activez ESM Apps pour recevoir des futures mises à jour de sécurité supplémentaires.
    Visitez https://ubuntu.com/esm ou executez : sudo pro status

    Last login: Thu Nov 14 14:41:13 2024 from 172.16.10.10
    wilder@CLILIN01:~$
    ```
    Votre connexion est maintenant bien établie.

    </details>
    
</details>

<details>
<summary><h4> Configuration de la machine CLILIN01 </h4></summary>

  + <details>
    <summary><h5> Configuration systèmes </h5></summary>
    <br>

    Cette machine aura les spécificités suivantes :
    * CPU : 2 cœur
    * RAM : Minimum - 512 Mo / Maximum - 2048 Mo
    * Stockage : HDD de 32 Go

    </details>

  + <details>
    <summary><h5> Configuration réseaux </h5></summary>
    <br>

    Cette machine aura les spécificités suivantes :
    * Carte réseau 1 : Connectés au NET pour recevoir les mises à jours systèmes. (optionnel)
    * Laisser le DHCP du proxmox lui donner son adresse IP.
    * Carte réseau 2 : Connectés au réseau interne pour pouvoir communiquer avec la machine serveur.

    Nous allons seulement configuré la carte réseau n°2. Pour cela, il faut aller modifier le fichier             **/etc/netplan/nomdufichier.yaml** avec la commande suivante :
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
          - 172.16.10.30/24
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
    wilder@CLILIN01:~$ ip a
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
      inet 127.0.0.1/8 scope host lo
      valid_lft forever preferred_lft forever
      inet6 ::1/128 scope host noprefixroute
      valid_lft forever preferred_lft forever
    2: ens18: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
      link/ether bc:24:11:c1:7b:2b brd ff:ff:ff:ff:ff:ff
      altname enp0s18
      inet 10.3.0.14/24 brd 10.3.0.255 scope global dynamic noprefixroute ens18
      valid_lft 6996sec preferred_lft 6996sec
      inet6 fe80::be24:11ff:fec1:7b2b/64 scope link
      valid_lft forever preferred_lft forever
    3: ens19: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
      link/ether bc:24:11:d9:2f:e3 brd ff:ff:ff:ff:ff:ff
      altname enp0s19
      inet 172.16.10.30/24 brd 172.16.10.255 scope global noprefixroute ens19
      valid_lft forever preferred_lft forever
      inet6 fe80::be24:11ff:fed9:2fe3/64 scope link
      valid_lft forever preferred_lft forever
    ```
    
    </details>

  + <details>
    <summary><h5> Configuration SSH </h5></summary>
    <br>

    Comme c'est la machine cliente qui recevra les demandes de connexion SSH, c'est ici que sera installé OpenSSH-Server. Pour cela, faite la commande suivante :
    ``` bash
    sudo apt-get install openssh-server -y
    ```
    Maintenant qu'il est installé, il faut vérifier son statut. Pour cela, faite la commande ci-dessous :
    ``` bash
    systemctl status ssh
    ```
    Ce qui vous donnera :
    ``` bash
    wilder@CLILIN01:~$ systemctl status ssh
    ● ssh.service - OpenBSD Secure Shell server
        Loaded: loaded (/usr/lib/systemd/system/ssh.service; disabled; preset: enabled)
        Active: active (running) since Thu 2024-11-14 12:21:46 CET; 2h 11min ago
    TriggeredBy: ● ssh.socket
        Docs: man:sshd(8)
                man:sshd_config(5)
        Process: 3038 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
    Main PID: 3040 (sshd)
        Tasks: 1 (limit: 9446)
        Memory: 3.3M (peak: 4.2M)
            CPU: 78ms
        CGroup: /system.slice/ssh.service
                └─3040 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
    
    nov. 14 12:22:05 CLILIN01 sshd[3041]: Accepted password for wilder from 172.16.10.10 port 52874 ssh2
    nov. 14 12:22:05 CLILIN01 sshd[3041]: pam_unix(sshd:session): session opened for user wilder(uid=1000) by     wilder(uid=0)
    nov. 14 12:29:28 CLILIN01 sshd[3172]: Accepted password for wilder from 172.16.10.10 port 46424 ssh2
    nov. 14 12:29:28 CLILIN01 sshd[3172]: pam_unix(sshd:session): session opened for user wilder(uid=1000) by     wilder(uid=0)
    nov. 14 12:29:28 CLILIN01 sshd[3172]: pam_unix(sshd:session): session closed for user wilder
    nov. 14 12:29:35 CLILIN01 sshd[3220]: Accepted password for wilder from 172.16.10.10 port 41340 ssh2
    nov. 14 12:29:35 CLILIN01 sshd[3220]: pam_unix(sshd:session): session opened for user wilder(uid=1000) by     wilder(uid=0)
    nov. 14 12:29:35 CLILIN01 sshd[3220]: pam_unix(sshd:session): session closed for user wilder
    nov. 14 14:32:47 CLILIN01 sshd[3667]: Accepted password for wilder from 10.20.0.3 port 36430 ssh2
    nov. 14 14:32:47 CLILIN01 sshd[3667]: pam_unix(sshd:session): session opened for user wilder(uid=1000) by     wilder(uid=0)
    ```
    S'il est active comme ci-dessus, votre server SSH est installé. Si ce n'est pas le cas, faite la commande     suivante :
    ``` bash
    systemctl restart ssh
    ```
    Puis refaite la commande pour status, et c'est bon votre server SSH est opérationnel !

  </details>

</details>

<HR>

<summary><h2> Installation sous Windows </h2></summary>
<br>

<details>
<summary><h4> Prérequis techniques </h4></summary>
<br>

**Serveur Windows Server 2022 (avec GUI):**
  * Nom : **SRVWIN01**
  * Compte : **Administrator** (dans le groupe des admins locaux)
  * Mot de passe : **Azerty1***
  * Adresse IP fixe : **172.16.10.5/24**

**Client Windows 10 :**
  * Nom : **CLIWIN01**
  * Compte utilisateur : **wilder** (dans le groupe des admins locaux)
  * Mot de passe : **Azerty1***
  * Adresse IP fixe : **172.16.10.20/24**

</details>


<details>
<summary><h4> Etapes d'installation et de configuration </h4></summary>

#### Instruction étape par étape :

Le script va s'exécuter sur le PC WINDOWS SERVER 2022 et agir sur le PC distant WINDOWS 10 client. Il va donc falloir configurer :
  * **1- Le PC Windows Serveur**
  * **2- Le PC Windows Client**

#### Configuration et installations des deux interfaces Windows

Toutes les opératieons décrites ci-après se trouvent dans le script co_ssh.ps1 etr sont donc automatisées.
Pour commencer, il faut ouvrir Powershell en tant qu'administrateur
Installer Open ssh sur le serveur avec la commande :
``` powershell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```
Après ça il faut démarrer le service ssh :
``` powershell
Start-Service sshd
```
Ensuite, on le configure pour qu'il démarre automatiquement :
``` powershell
Set-Service -Name -StartupType "Automatic"
```
Le démarrage du service SSH a généré le fichier de configuration C:\ProgramData\ssh\sshd_config .
Nous allons le modifier avec le bloc notes Windows :
``` powershell
notepad C:\ProgramData\ssh\sshd_config
```
Une fois le fichier ouvert, nous allons modifier la configuration du serveur SSH en autorisant la connexion par mot de passe. Pour se faire, il faut retirer le caractère # situé devant cette ligne : <br>
<P ALIGN="center"><IMG src="https://github.com/WildCodeSchool/TSSR-BDX-0924-P2-G2/tree/main/Images/notepad1.png" width=600></P>
<br>

Nous devons ajouter la prise en charge de PowerShell en l'intégrant en tant que sous-système, sinon il n'y a que quelques commandes qui vont fonctionner (non PowerShell). Vous devez ajouter cette nouvelle ligne à la suite de ces deux lignes :
``` powershell
Subsystem powershell c:/progra~1/powershell/7/pwsh.exe -sshs -NoLogo
```
Ce qui donnera :
<P ALIGN="center"><IMG src="https://github.com/WildCodeSchool/TSSR-BDX-0924-P2-G2/tree/main/Images/notepad2.png" width=600></P>

</details>
