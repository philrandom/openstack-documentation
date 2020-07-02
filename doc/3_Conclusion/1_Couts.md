# Coûts

## Migration : Hyperviseur

Le scenario est le suivant l'hyperviseur principal est un cloud openstack. Alors la transition pourrait être effectué par un ou deux individus durant 6 mois (pour comprendre de plus la théorie). Avec la mise en place d'une première maquette PoC.

## Migration : IaaS total

Le scénario est le suivant toute l'infrastructure comprenant réseaux (vpn - firewall), virtualisations, et stockages est sous OpenStack. Cela demanderait à l'equipe un temps d'étude, de formation, de reflexion, de transition et enfin d'explication à l'autre équipe ayant assuré le maintient de l'ancienne infrastructure durant l'état de transition.


L'interret est le suivant : 
- L'equipe connait le produit, son fonctionnement, et l'agencement. Cela permet :
  - une intervention peut être effectué par n'importe quel membre de l'équipe.
  - une consultation global pour l'architecture, avec l'expertise de chacun pour peremettre une optimisation.
- L'infrastructure est homogène, ce qui tend vers une cohésion, et ainsi améliorer la qualité.

## Appel à un tierce

55% des cloud OpenStack utilise ubuntu, avec le support fournit par Cannonical. Voir le [calculateur TCO(total cost of ownership)](https://ubuntu.com/tco-calculator) pour un cloud privé. Egalement RedHat propose des [déploiements de cloud](https://access.redhat.com/products/red-hat-openstack-platform/#whatsnew) et des [formations avec certifications](https://www.redhat.com/en/services/certification/rhcsa-rhos?cr=cp|tr|pp|00002&).
L'entreprise française Objectif Libre propose des [formations](https://www.objectif-libre.com/fr/formations/catalogue-des-formations-linux-cloud-et-logiciels-libres/#1506501242999-4333ab50-e729) sur OpenStack.
SUSE propose les [déploiements](https://www.suse.com/fr-fr/products/suse-openstack-cloud/).

Liste disponibles des entreprises partenaires et agrées par openstack pour le deploiement de cloud [ici](https://www.openstack.org/marketplace/hosted-private-clouds/)


## Recommandation de mise en production

- Déploiement :
  - TripleO : deploiement d'OpenStack sur OpenStack. Recommandé, mais pas nécéssaire, en effet il permet un maintient plus facile du cloud.
  - Ansible : automatisation de deploiement. (voir `openstack-ansible`)
- Securité :
  - Docker : lancement des services/demons openstack dans des conteneurs (recommandation RedHat)

Voir `/annexe/documentations_officielles.md` pour les documentations officielles.
