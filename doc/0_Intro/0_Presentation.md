# Présentation

## Client

Université de Limoges *alias* **unilim**
33 rue François Mitterrand
BP 23204
87032 Limoges - France


DSI (Direction des Système d'Information)
Xavier Montagutelli

## Objectifs client

Le quartier de la Direction des Système d'Information de l'université de Limoges souhaite rendre le déploiement de projets le plus automatique possible. On entend par **projet** le déploiement d'Infrastructure de machines virtuelle (VM) avec ses ressources alloués. *Pour exemple, AWS (Amazon Web Service) est un service de Cloud pour lequel l'utilisateur  crée ses propres projets sans l'intervention de l'administrateur d'Amazon*. Le **déploiement** devra s'effectuer de manière indépendante du DSI et le plus simplement possible pour les utilisateurs ; le but étant de supprimer l'intervention de ce dernier dans l'objectif d'un gain de temps et d'autonomie.


Pour exemple, une équipe ayant besoin de travailler sur un projet donné, fait appel au DSI, acteur incontournable dans ce déploiement. Ce dernier configure alors l'environnement, qui comporte les tâches suivantes (non exhaustive) :
- la gestion des authorisations des utilisateurs
- la structuration du réseaux
- l'allocation de ressources

Pour ce faire, trois grands principes devront être respectés :
- KISS (Keep it simple stupid) : simplicité à tous les niveaux (documentation, interface user-friendly, architecture)
- User Empowerement : donner une plus grande autonomie à l'utilisateur
- Security focus : sécuriser l'environnement (parrer les attaques extérieurs)
