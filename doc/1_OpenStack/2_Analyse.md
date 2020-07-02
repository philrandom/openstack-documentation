# Analyse

## Tailles

Les utilisateurs seront nottament les étudiants et les professeurs d'*unilim* qui souhaitent faire de la virtualisation, pour des cours, stages, et formations. Les instances créer seront accessible sur le réseaux interne de l'université.

## Capacité

La capacité de stockage et de calcul pourra vite être atteinte. Dans cette documentation, la partie stockage n'est pas aborder, car il existe déjà un système efficient mise en place. Pour la capacité de calcul, il faudra impérativement des *compute nodes* pour alléger l'utilisation.

Par la suite la charge réseau peut s'averer problématique. Ainsi deux architectures seront developpées, dont une comportant des *gateway nodes* pour pallier a ce potentielle problème.

## Modules
Les modules à utiliser sont :
- Keystone (fernet) : `core module` authentification
- Placement : `core module` tracker de ressources
- Nova (KVM) : `core module` hyperviseur
- Glance : `core module` gestion d'images
- Ceilomter : monitoring
- Aoh : monitoring d'alerte
- Horizon : dashboard utilisateur 
