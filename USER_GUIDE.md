# Documentation utilisateur

<details>
<summary><h2> Généralités : Les fonctions du script </h2></summary>
<br>

  + <details>
    <summary><h4> Les différentes cibles </h4></summary>

    Nous vous proposons un menu permettant de faire différentes demandes (actions ou informations) sur deux cibles possibles :
      * Cible : Utilisateur
      * Cible : Ordinateur

    </details>

  + <details>
    <summary><h4> Les différentes actions </h4></summary>

    Concernant la cible utilisateur, vous pouvez demander :
      * Créer un utilisateur
      * Supprimer un utilisateur
      * Modifier le mot de passe d'un utilisateur

    Concernant la cible ordinateur, vous pouvez demander :
      * Redémarrer l'ordinateur
      * Eteindre l'ordinateur
    </details>

  + <details>
    <summary><h4> Les différentes informations</h4></summary>

    Concernant la cible utilisateur, vous pouvez demander :
      * Les dates de connexion d'un utilisateur
      * Si l'utilisateur existe

    Concernant la cible ordinateur, vous pouvez demander :
      * Le type de système d'exploitation de l'ordinateur
      * L'uptime de l'ordinateur
    </details>

</details>


<details>
<summary><h2> Utilisation sur Linux<h2></summary>
<br>

  + <details>
    <summary><h4>Bien utiliser le script<h4></summary>
    <br>

    Tout d'abord, il faut vous connecter sur l'ordinateur **SRVLX01** :
      * Identifiant : _wilder_
      * Mot de passe : _Azerty1*_
    <br>

    Une fois connecté, vérifier d'être bien sur le dossier **/home/wilder**, avec la commande :
    ``` bash
    pwd
    ```
    Dans ce dossier, vous trouverez :
      * Le dossier **Documents**, où s'enregistrera les différentes demandes d'informations.
      * Le dossier **TheScriptingProject**, où se trouve le script.
    <br>

    Pour appeler le script, il faudra taper les commandes suivantes (tout en restant dans le dossier **/home/wilder**) :
    ```bash
    su root
    ```
    Vous avez besoin d'être sous l'utilisateur **Root** pour pouvoir accéder au dossier **/var/log** où s'enregistrera tout au long du script, les différents évènements de vos choix.<br>
    ``` bash
    ./TheScriptingProject/mainMenu.sh
    ```
    Vous arriverez sur ce menu : <br>
    ![appelScript&menu](https://github.com/WildCodeSchool/TSSR-BDX-0924-P2-G2/blob/doc/Images/appelScript%26menu.png)
    <br>

    Chacun de vos choix, vous amènes à des sous-menus où à la fin, vous pourrez :
      * Soit faire des actions
      * Soit faire des demandes d'informations.

    Ce script, vous permettra d'agir sur la machine cliente **CLILIN01**, grâce à une connexion SSH.

    </details>
    
  + <details>
    <summary><h4>Les différentes options<h4></summary>
    <br>

    Ce script permet d'agir sur une machine distante via une connexion SSH. Vous aurez donc besoin de connaitre :
      * Le nom d'utilisateur sur qui vous souhaitez vous connecter
      * L'adresse IP de la machine cible
      * Le mot de passe de l'utilisateur

    A plusieurs reprises dans le script, une connexion SSH devra s'établir, cela se verra sous cette forme :
    ``wilder@172.16.10.30's password ``


    </details>

  + <details>
    <summary><h4>F.A.Q.<h4></summary>
    <br>

    ***Questions : Où sont enregistrés les informations que j'aurais demandé ?*** <br>
    *Réponse* <br>
    Les informations que vous aurez demandé lors du scripting, seront enregistrés dans le dossier **/home/wilder/Documents/** sous la forme suivante : info_*Cible*_*Date*.txt; avec :
      * *Cible* : Le nom de l'utilisateur ou de l'ordinateur cible.
      * *Date* : Date du recueil des informations au format *yyyymmdd*
    <br>

    ***Questions : Vous avez parlé de journalisation, où pourrais-je retrouver ces informations ?*** <br>
    *Réponse* <br>
    Les informations de journalisation seront enregistrés dans le dossier **/var/log/** et dans le fichier **log_evt.log**. <br>
    Les enregistrements seront sous la forme suivante : *Date*-*Heure*-*Utilisateur*-*Evenement*, avec :
      * *Date* : Date de l'évènement au format *yyymmdd*
      * *Heure* : Heure de l'évènement au format *hhmmss*
      * *Utilisateur* : Nom de l'utilisateur courant utilisant la machine **SRVLX01** exécutant le script
      * *Evenements* : Action effectué lors de l'utilisation du script :
        * Les différents choix dans le menu et les sous-menu;
        * Lors des actions ou des demandes d'informations, chaque étape sera détaillé.

    </details>

</details>

<details>
<summary><h2>Utilisation sur Windows<h2></summary>
<br>

  + <details>
    <summary><h4>Utilisation de base<h4></summary>
    <br>
    <b>Comment utiliser les fonctionnalités clés :</b>
    </details>    
    
  + <details>
    <summary><h4>Utilisation avancée<h4></summary>
    <br>
    <b>Comment utiliser au mieux les options :</b>
    </details>

  + <details>
    <summary><h4>F.A.Q.<h4></summary>
    <br>
    <b>Solutions aux problèmes connus et communs liés à l'utilisation :</b>
    </details>


</details>

