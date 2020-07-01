# Coûts

## Migration : Hyperviseur

Le scenario est le suivant l'hyperviseur principal est un cloud openstack. Alors la transition pourrait être effectué par un ou deux individus durant 6 mois (pour comprendre de plus la théorie)

## Migration : IaaS total

Le scénario est le suivant toute l'infrastructure comprenant réseaux (vpn - firewall), virtualisations, et stockages est sous OpenStack. Cela demanderait à l'equipe un temps d'étude, de formation, de transition et enfin d'explication à l'autre équipe ayant assuré le maintient de l'ancienne infra durant l'etat de transition.


L'interret est le suivant : toute l'equipe connait le produit et l'infrastructure est homogène.

## Recommandation de mise en production

- deploiement :
  - TripleO : deploiement d'openstack sur OpenStack
  - Ansible
- securité :
  - Docker : lancement des services/demons openstack dans des conteneurs.
