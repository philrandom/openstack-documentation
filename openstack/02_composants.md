# Composants

OpenStack est basé sur une architecture modulaire.
Premièrement chaque composant effectue :
- execution logicielle
- communication via API
- gestion des ressources



Ne seront détaillé que les composants principaux par ordre d'apparition. 


[//]: <> (src image : https://www.openstack.org/software/)
![title](assets/modules.svg)



## Nova
|catégorie  		|fonction				|dépendance module 						|outils client 							|
|---				|---					|---									|----									|
|calcul				| gestion hyperviseur 	| Keystone , Glance, Neutron, Placement | Horizon, Nova Client, OpenStack Client| 

Nova et Swift sont les premiers modules écrits. Nova gere 



## Keystone
|catégorie  		|fonction							|
|---				|---								|
|service			|identification						| 

De manière simplifié Keystone est un Active Directory fonctionnant sur un principe equivalent de Kerberos avec jeton (renvoyé par API).
Keystone gère l'accès des utilisateur aux différentes instances.

Plusieurs méthode d'authentification plug-n-play sont disponible :
- username / password / token
- OAuth
- Apache REMOTE_USER
- LDAP
- Kerberos

**Role** : 
- Il existe `admin` qui est le super utilisateur de tout l'ensemble OpenStack. 
- \_member\_
- d'autre role peuvent être créer notement en tant que Operateur d'un module (ex: SwiftOperator)

Chaque utilisateur est liée à un `project` ou également appelé `tenant` (OpenStack Fundation tend à unifier et renommer vers `project`). 
L'utilisateur peut inviter d'autre utilisateur à son projet.
L'utilisateur peut avoir une liste d'utilisation restreinte des modules.  

## Swift

- stockage d'objet orienté document. (type cloud google drive)
- replication

_Attention_ eventual consistency

## Barbican
- stockage de clef de chiffrage
- certificat HTTPS à la volé (déployement)

## Designate

- gestion DNS
- obtention d'url pour acceder aux machines 

## Sahara 
Bigdata avec Hadoop et Spark
- dimensionné à la volé

## Zaqar
- Message queue ~ AWS : software-as-Service

## Manila
- Partager les espaces entre machine 
- bonus : partage avec kubernet et docker

## Ironic
Bare metal provisionning 
OpenStack fait des installs sur des machine vierge

## Magnum
geere les conteneur
Docker, Kubernet 





[![IMAGE ALT TEXT](http://img.youtube.com/vi/4oYtaNc_35I/0.jpg)](http://www.youtube.com/watch?v=4oYtaNc_35I "OpenStack Compute 101") 
