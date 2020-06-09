# Architecture

[//]: <> (**pré requis** : ML2-plugin, OpenvSwitch, VXLAN)

**Pour rappel** l'architecture, doit repondre aux objectifs selon `/doc/0_Intro/0_Presentation.md` : 
- KISS
- Security Focus

L'énoncé est orienté vers des déploiements de VM principalement. Autrement dit, l'architecture mettra en avant Les **Compute Node**.  

Une des propositions, non détaillé ici, serait d'utiliser seulement un seul et unique nœud OpenStack. Cette architecture serait grandement déprécié car elle n'est pas scalable et non performantes (raison détaillé plus tard).

## Solution : architecture DVR OpenvSwitch

![title](../../annexe/assets/macro-architecture.svg)

L'architecture est composée de :
- 1 Controle-Node (ici appelé *Ground Control*) : il gère la majeur partie avec l'authentification, etc...
- N Compute-Node (ici appelé *COMP-#*) : où les VM seront exécutés.

Cette architecture est scalable, le jour où la puissance de calcul n'est plus suffisante alors il suffira de déployer un nouveau Compute-Node.  
Chaque Compute-Node posséde un routeur (DVR). Si les DVR étaient absents alors tout les flux qu'ils soient Nord-Sud (VM vers EXT) ou EST-OUEST (inter-NETWORK et intra-NETWORK) passerait à travers le Principal Router (PR) ce qui alourdi la charge réseau. Les DVR (Distributed Virtual Routing) quand à eux sont là pour gérer les connexions EST-OUEST et ainsi le PR ne se concentre que sur les connexions NORD-SUD. Les DVR sont vu par OpenStack comme un seul routeur, ce qui permet que deux VM jaune (connecté aux network jaune) qui ne sont pas sur le même Compute-Node puissent interagir.
