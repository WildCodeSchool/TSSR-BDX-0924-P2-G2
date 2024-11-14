# Documents Administrateurs

<details>
<summary><h2> Installation sous Linux </h2></summary>
<br>

<details>
<summary><h3> Prérequis techniques </h3></summary>
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

### Configuration de la machine SRVLX01
#### Configuration système
Cette machine aura les spécificités suivantes :
  * CPU : 2 cœurs
  * RAM :
    * Minimum : 512 Mo
    * Maximum : 2048 Mo
  * Stockage : Disque dur HDD de 32 Go

#### Configuration réseaux
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

#### Configuration SSH
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
