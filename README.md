# Postgre-Maintenance

Vous trouverez dans ce read-me les consignes pour comprendre le fonctionnement de notre script. Après avoir lu, vous serez en mesure d'utiliser notre script sans problème.

## Prérequis :
- Une machine Debian à jour
- Un accès au compte root
- Un compte superuser postgre
- L'accès aux commandes clients postgre
- Des bases de données PostgreSQL

## Fonctionnement :
Notre application fonctionne à travers 3 scripts différents qui on été conçu pour réaliser plusieurs actions.
Avec notre application, on peut donc :
- sauvegarde d’une base dans une archive compressée
- restauration d’une base selon une sauvegarde précise
- suppression d’archive après une certaine durée


###### La fonctionnalité de sauvegarde
Script correspondant : *save_db.sh*
Ce script permet deux choses :
- la sauvegarde d'une base spécifique
- la sauvegarde de toutes les bases une par une
Arguments : aucun
options dans le fichier de configuration *conf.sh*

###### La fonctionnalité de restauration
Script correspondant : *restore_db.sh*
Ce script permet deux choses :
- restaurer une base automatiquement avec la dernière archive
- restaurer une base manuellement avec une archive spécifique
Arguments: nom de la base, {chemin vers l'archive (optionnel)}

###### La fonctionnalité de suppression
Script correspondant : *delete_db.sh*
ce script permet de supprimer les archives d'une base spécifique datés d'un certain nombre de jours choisis par l'utilisateur
Arguments: nom de la base, nombre de jours

