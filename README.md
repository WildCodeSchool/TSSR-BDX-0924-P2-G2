# Documentation Générale

<details>
<summary><h2>Présentation du projet & Objectifs<h2></summary>

### 1) Le projet :

Le projet consiste à créer un script qui s’exécute sur une machine et effectue des tâches sur des machines distantes.
L’ensemble des machines sont sur le même réseau.

Les tâches sont des actions ou des requêtes d’information.

L’objectif est de mettre en pratique plusieurs compétences techniques et collaboratives dans un projet de scripts orienté client/serveur. Il s'agit de créer un script bash pour un environnement Linux, à exécuter entre un serveur et un client Linux, et un script PowerShell pour un environnement Windows, à exécuter entre un serveur et un client Windows. Ce projet inclut le travail en équipe pour mener à bien chaque étape, la documentation détaillée du processus, et la démonstration du résultat final.

**Mise en pratique des compétences suivantes :**  

- Mettre en place une architecture client/serveur
- Créer et gérer des scripts bash et PowerShell
- Réaliser un projet en équipe
- Documenter toutes les étapes
- Faire une démonstration de la réalisation finale

En somme, il s’agit d’un projet complet de développement et de déploiement de scripts, avec documentation et présentation.

Le projet contient 2 objectifs, 1 objectif principal et 1 objectif secondaire.

### 2) Objectif principal :

**Objectif principal :**
- Depuis une machine Windows Server, on exécute un script PowerShell qui cible des ordinateurs Windows.  
- Depuis une machine Debian, on exécute un script shell qui cible des ordinateurs Ubuntu.  


**L’objectif principal est validé si :**  
- Il est complètement réalisé et fonctionnel
- La documentation est réalisée et correcte
- La présentation finale montre les 2 points précédents

### 3) Objectif secondaire :

**Objectif secondaire :**
- Depuis un serveur, cibler une machine cliente avec un type d’OS différent

L’objectif secondaire est optionnel et amènera en cas de réalisation validée, à une meilleure évaluation.
</details>

<details>
<summary><h2>Membres du groupe de projet (rôles par sprint)<h2></summary>

Pour ce projet, les membres du groupe sont Sybill Gribonval, Julien Normand et Anthony Vidal.


**Rôles par sprint :**

**Sprint 1**
- Scrum Master : Sybill Gribonval 
- Product Owner : Julien Normand
- TSSR : Anthony Vidal

**Sprint 2**
- Scrum Master : Julien Normand
- Product Owner : Anthony Vidal
- TSSR : Sybill Gribonval

**Sprint 3**
- Scrum Master : Anthony Vidal
- Product Owner : Sybill Gribonval
- TSSR : Julien Normand

**Sprint 4**
- Scrum Master : Anthony Vidal
- Product Owner : Sybill Gribonval
- TSSR : Julien Normand
</details>

<details>
<summary><h2>Choix techniques (OS, Version, ...)<h2></summary>

### 2 clients (au minimum) sont mis en place :

**Client Windows 10 :** 
Nom : **CLIWIN01**  
Compte utilisateur : **wilder** (dans le groupe des admins locaux)   
Mot de passe : **Azerty1***  
Adresse IP fixe : **172.16.10.20/24**  

**Client Ubuntu 22.04/24.04 LTS :**
Nom : **CLILIN01**  
Compte utilisateur : **wilder** (dans le groupe sudo)  
Mot de passe : **Azerty1***  
Adresse IP fixe : **172.16.10.30/24** 

### 2 serveurs sont mis en place :

**Serveur Windows Server 2022 (avec GUI):**  
Nom : **SRVWIN01**  
Compte : **Administrator** (dans le groupe des admins locaux)  
Mot de passe : **Azerty1***  
Adresse IP fixe : **172.16.10.5/24**  

**Serveur Debian 12 (en CLI sans GUI):**  
Nom : **SRVLX01**  
Compte : **root**  
Mot de passe : **Azerty1***  
Adresse IP fixe : **172.16.10.10/24**  
</details>

<details>
<summary><h2>Difficultés rencontrées : problèmes techniques rencontrés<h2></summary>

#### Problèmes rencontrés sous Linux
Voici une liste des problèmes rencontrés où certains ont put être corrigés (voir §Solutions trouvées):
  1. Appliquer le script depuis SRVLX01 et qu'il agisse sur CLILIN01. Nous avions une première solution, mais cela ne répondait pas aux attentes du client. Une solution a été trouvée.
  2. Problèmes de connexion SSH sur l'utilisateur `root` de la machine distante. Une solution a été trouvée.
  3. La première ligne pour le journal de log `<Date>-<Heure>-<Utilisateur>-********StartScript********`. A chaque fois que l'utilisateur revient sur le menu de départ, sans pour autant sortir du script, cette ligne se remet à chaque fois. Alors qu'elle doit se mettre qu'au lancement du script. A ce jour, aucune solution n'a été trouvée, cependant une piste d'amélioration a été décelé.
  4. Lancer le script tout en ayant accès au dossier **/var/log** pour implémenter le journal de log. Une solution a été trouvée.

#### Problèmes rencontrés sous Windows

</details>

<details>
<summary><h2>Solutions trouvées : solutions et alternatives trouvées<h2></summary>

#### Solutions trouvés sous Linux
Suite au problème rencontré plus haut, voici les solutions que nous avons repérées :
  1. La première solution était d'envoyer le script sur CLILIN01 avec la commande `scp -r /cheminsource wilder@172.16.10.30:~/` néanmoins cela ne répondait pas aux attentes du client. La solution apportée a été de mettre la commande `ssh wilder@172.16.10.30 <nom de la commande>` dans les différentes fonctions du script pour appliquer les commandes à distantes. Et pour pouvoir rester dans le menu/script, nous avons utiliser la boucle `while`.
  2. Depuis SRVLX01, nous n'arrivions pas à nous commander en `root` sur CLILIN01, or pour certaines commande, il était nécessaire d'être `root` pour pouvoir l'appliquer. La solution a été de modifier le fichier **/etc/ssh/sshd_config** et de modifier la ligne `PermitRootLogin no` en `PermitRootLogin yes`.
  3. Si le script était lancé en tant qu'utilisateur `wilder` sur SRVLX01, il nous était impossoble de modifier le fichier log_evt.log car nous n'avions pas les droits d'accès suffisant pour accéder au dossier **/var/log**. Il a suffit de se mettre sur l'utilisateur `root` pour pouvoir régler ce souci.


#### Solutions trouvés sous Windows

</details>

<details>
<summary><h2>Améliorations possible : suggestion d'améliorations futures<h2></summary>

#### Améliorations possible sous Linux
Suite à l'avancement du projet, plusieurs axes d'amélioration se sont démarqués :
  * A chaque connexion SSH, un mot de passe est demandé. Pour palier à cela, il faudrait :
    * Soit stocké le mot de passe dans une variable,
    * Soit enregistré les clé SSH de connexion.
  * Pour le problème cité plus haut concernant la première ligne du journal de log, pour palier à ce problème il faudrait utiliser une variable booléenne.
  * Améliorer la sécurité du script pour que seul l'administrateur puisse utiliser le script et pas un simple utilisateur.

#### Améliorations possible sous Windows

</details>

</details>
