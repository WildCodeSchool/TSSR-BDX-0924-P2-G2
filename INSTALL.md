# Documents Administrateurs

<details>
<summary><h2> Installation sous Linux </h2></summary>
<br>

### Prérequis techniques
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
`bash sudo nano /etc/netplan/nomdufichier.yaml`

</details>
