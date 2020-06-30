# Critiques

## [-] Négatif

### Instabilité

OpenStack est un projet assez vaste qui evolue très rapidement; certaines versions ont de grande cassure qui implique une restructuration (voir l'extraction de placement depuis nova). Les resolutions de problèmes connus ne sont pas valable dans le temps.  

> une version tout les six mois.

### Personnalisation

Egalement OpenStack peut travailler avec différents services, plug-in, module, composant, et architecture générale. Ce qui tend vers une personnalisation en fonction de ses besoins, autrements dit quasiment à un cloud unique. Ainsi l'aide aux problèmes rencontré est plus difficile à trouver, et requière une bonne compréhension de sa structure.

### Documentation

En 2020, il y a peu de documentation claire. En effet, la doc officielle d'OpenStack n'est pas forcément claire en tout points. La doc RedHat est beaucoupo plus tourné théorique.


## [+] Positif

### Sécurité
En 2018, OpenStack à subit beaucoup d'*exploits*. Depuis 2019, OpenStack à corrigé ces failles, et la communauté se mobilise vers la sécurité (source MISC Mag).  
Autrement dit, la sécurité est assuré principalement par OpenStack. L'operateur n'a qu'a suivre la doc est choisir des mots de passes complexes.

### Liberté
Le produit est opensource. Il est donc utilisable sans faire appel à un tierce. Il possible de faire appel à un tierce comme RedHat, Cannonical ... et autres entreprtises membres du projet. Par la même occasion il est possible de changer de fournisseur ci l'actuel ne convient pas.  
Si le choix suivant est l'independence, alors il n'y a pas de coûts dirrect en licence ou autres. Par contre, l'utilisation du produit se limite aux compétences de l'equipe, surtout lorsqu'il faut faire face à un problème d'instabilité.


### Polyvalence

La **polyvalence d'OpenStack est le point principal**. Dans une structure n'utilisant pas OpenStack les technologies sont diverses (parefeux, virtualisation ...). OpenStack permet une unifromité, car peut faire du IaaS mais également VPNaaS, FWaaS, SaaS ... Ainsi on peut imaginé un cloud openstack gérant l'ensemble du parc. N'importe quel membre de l'equipe pourra comprendre, et travailler sur n'importe quel domaine (réseaux, virtualisation ...) en peu de temps.

