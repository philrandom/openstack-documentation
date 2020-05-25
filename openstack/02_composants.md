# Composants

OpenStack est basé sur une architecture modulaire.
Premièrement chaque composant effectue :
- execution logicielle
- communication via API
- gestion des ressources



Ne seront détaillé que les composants principaux par ordre d'apparition. 


[//]: src image : https://www.openstack.org/software/
![title](assets/modules.svg)



## Nova
|catégorie  		| fonction				| dépendance module 					| outils client 						|
|---				|---					|---									|----									|
|calcul				| gestion hyperviseur 	| Keystone , Glance, Neutron, Placement | Horizon, Nova Client, OpenStack Client| 

Nova et Swift sont les premiers modules écrits. Nova gere  
