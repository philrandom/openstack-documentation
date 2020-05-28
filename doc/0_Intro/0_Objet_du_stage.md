# Objet du stage

## Présentation

### Client

Université de Limoges alias **unilim**.
2 rue


DSI (Direction des Système d'Information)
Xavier Montagutelli

### Objectifs

Le quartier de la Direction des Système d'Information de l'université de Limoges souhaite rendre le déploiement de projets le plus automatique possible (sans intervention du DSI). On entend par **projet** le déploiement d'Infrastructure de machines virtuelle (VM) avec ses ressources alloués. *Pour exemple, AWS (Amazon Web Service) est un service de Cloud pour lequel l'utilisateur  crée ses propres projets sans l'intervention de l'administrateur d'Amazon.*



Le déploiement devra s'effectuer de manière indépendante du DSI et le plus simplement possible pour les utilisateurs ; le but étant de supprimer l'intervention du DSI.

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
