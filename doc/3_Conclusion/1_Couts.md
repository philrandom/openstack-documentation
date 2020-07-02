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

## Recommandation de mise en production

- Déploiement :
  - TripleO : deploiement d'OpenStack sur OpenStack. Recommandé, mais pas nécéssaire, en effet il permet un maintient plus facile du cloud.
  - Ansible : automatisation de deploiement. (voir `openstack-ansible`)
- Securité :
  - Docker : lancement des services/demons openstack dans des conteneurs (recommandation RedHat)
