# Objet du stage

## Présentation

Le quartier DSI souhaite rendre le déploiement d'espace de travail (VM) de manière autonome pour les utilisateurs.

Lorsqu'une équipe a le besoin de travailler sur un projet comportant l'utilisation de VM, elle est obligée de passer par le DSI. Ce dernier configure l'environnement des VM qui comporte plusieurs tâches :
- structuration du réseaux
- allocation de ressources

L'objectifs serait d'éviter de passer par le quartier DSI, pour un gain de temps et d'autonomie.

3 grands principes doivent être respectés :
- KISS (Keep it simple stupid) : mise sur la simplicité à tout les niveau (documentation, interface user-friendly, architecture) 
- User Empowerement : permettre une plus grande autonomie à l'utilisateur
- security focus : éviter les escalations de privilège et éviter les attaques extérieures



## Cahier des charges

Utilisation d'OpenStack en tant que Infrastructure-as-a-Service (IaaS) :

- Gestion des instances/projets de manière user-friendly (Horizon)
- Gestion des ressources (Nova)
- Facturage d'utilisation (Ceilo Meter)
- Définition des plages ip (Neutron)
- Firewall (Neutron)
- Ajout sécurité 


## Question

**Définir la pertinence de l'utilisation future d'OpenStack pour l'université de Limoges ?**
