# Postgre-Maintenance

Vous trouverez dans ce README les consignes pour comprendre le fonctionnement de notre script. Après avoir lu, vous serez en mesure d'utiliser notre application sans problème.

## Prérequis :
- Une machine Debian à jour
- Un accès au compte root
- Des bases de données PostgreSQL
- Un compte superuser postgre
- L'accès aux commandes client postgre (pg_dump, pg_restore...)

## Fonctionnement :
Notre application fonctionne à travers 3 scripts différents qui on été conçu pour réaliser plusieurs actions.
Avec notre application, on peut donc :
- Sauvegarder une ou plusieurs bases dans des archives compressées
- Restaurer une base automatiquement avec la dernière sauvegarde ou selon une sauvegarde précise
- Supprimer des archives après une certaine durée

**Les scripts ne sont pas installés en tant que commandes et nécessitent donc d'être exécutés en renseignant leur chemin d'accès**  
Pour pouvoir les utiliser comme des commandes, il est possible de créer un alias.

### Fichier de configuration  
Script correspondant : *conf.sh*
Fichier renseignant des variables utilisées par les scripts lors de leur exécution

- USERNAME : Nom de l'utilisateur qui va effectuer les actions
**Ex: USERNAME="appli_web"**

- PASSWORD : Mot de passe de l'utilisateur
**Ex: PASSWORD="postgre"**

- HOST : Localisation de la base ("localhost" pour un serveur local)
**Ex: HOST="127.0.0.1"**

- PORT : Port permettant l'accès à la base
**Ex: PORT=5432**

- DBNAMES : Liste des noms des bases à sauvegarder
Laisser blanc pour sauvegarder toutes les bases
Séparer le nom des bases par un espace
**Ex: DBNAMES="appli_web postgre"**

- DIR : Dossier où seront stockés les sauvegardes des bases
**Ex: "$HOME/db/save"**

### La fonctionnalité de sauvegarde
Script correspondant : *save_db.sh*
Arguments : aucun
Options spécifiques dans le fichier de configuration *conf.sh* :
- DBNAMES
- DIR

Fonctionnement :
Sauvegarde toutes les bases renseignées dans le fichier de configuration.
Chaque base est sauvegardée dans un dossier spécifique portant son nom.
Chaque sauvegarde est enregistrée dans le dossier sous le format *YYYY_MM_DD.dump*



### La fonctionnalité de restauration
Script correspondant : *restore_db.sh*
Arguments: **nom_de_la_base**, {*chemin vers l'archive* (optionnel)}

Fonctionnement :
- 1 seul argument : restaure la base correspondant au nom avec la sauvegarde la plus récente
- 2 arguments : restaure la base correspondant au nom avec l'archive.dump donnée en argument


### La fonctionnalité de suppression
Script correspondant : *delete_db.sh*

Arguments: nom de la base, nombre de jours

Fonctionnement :
Supprime les archives d'une base spécifique datés d'un certain nombre de jours choisis par l'utilisateur


###### Planification

Pour automatiser la sauvegarde et la suppression, il est possible de mettre en place un cron pour l'utilisateur.
Pour cela, on ouvre le fichier où les cron sont stockés avec la commande *crontab -e*.
Il suffit d'ajouter une entrée pour planifier l'exécution du script que l'on souhaite.
Syntaxe : MM HH JOUR MOIS JOUR_DE_LA_SEMAINE {chemin vers le script}

Exemple :

**0 2 * * * /home/appli_web/Postgre-Maintenance/save_db.sh**
*Sauvegarde les bases tous les jours à 2h du matin*

**0 10 * * * /home/appli_web/Postgre-Maintenance/delete_db.sh 7**
*Supprime les archives datant de 7 jours ou plus tous les jours à 10h du matin*


