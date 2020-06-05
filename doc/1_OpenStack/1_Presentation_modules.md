# Présentation Modules

OpenStack est basé sur une architecture modulaire. Chaque module communique entre eux via des API. Certains peuvent avoir un rôle fonctionnel au seins d'OpenStack (_ex_ : authentification, gestion réseaux, facturation), et d'autre peuvent également interagir avec des logicielles (_ex_ : Nova interagit avec VirtualBox).

_Vocabulaire_ : les **core modules** sont les modules définis comme essentiel. Historiquement ce sont les premiers modules qui sont apparus, sans lequel OpenStack ne pourra pas fonctionner. Au cours du développement ce terme est devenu plus flous.

[//]: <> (src image : https://www.openstack.org/software/)
![title](../../annexe/assets/modules.svg)

Ici seront présenté les modules dans l'ordre d'apparition selon une architecture simple et minimaliste.

```
  Horizon
    |
    |
    |       Neutron   Cinder    Nova    Glance    Swift
    |       |         |         |       |         |
    |       |         |         |       |         |
    |       |         |         |       |         |
  Keystone─────────────────────────────────────────
```

## [Keystone](https://docs.openstack.org/keystone/latest/getting-started/architecture.html)
|catégorie  		|fonction							|
|---				|---								|
|service partagé	|identification						|

Ce module est utilisé pour l'authentification, c'est la première étape de l'utilisateur.

De manière résumé Keystone fonctionne comme un Active Directory ou Kerberos. En effet l'utilisateur rentre ses identifiants. Une fois validé, un `token` (jeton) lui ait donné. Ce `token` se présente sous la forme d'une requête POST JSON (système d'API). Il n'est valide que temporairement. Dès que l'utilisateur demande l'accès à un modules, il y envoie son `token`. Du coté du module contacté, il valide ou non le `token`. La validité temporaire de ce jeton trouve son intérêt dans l'aspect de sécurité. En effet si une interception du `token` est effectué alors il ne sera valide que pendant un cours instant.

### Implémentation
Plusieurs méthodes d'authentification plug-n-play sont disponibles :
- username / password / token (celle de base de Keystone)
- OAuth
- Apache REMOTE_USER (docs [OpenStack](https://docs.openstack.org/keystone/pike/advanced-topics/external-auth.html))
- LDAP (docs [ubuntu](https://ubuntu.com/kubernetes/docs/ldap) ─ [OpenStack](https://docs.openstack.org/keystone/pike/admin/identity-integrate-with-ldap.html))
- Kerberos (docs [Objectif Libre (une entreprise officielle dev d'OpenStack)](https://www.objectif-libre.com/en/blog/2018/02/26/kerberos-authentication-for-keystone/))  


### Type Token

Il existe [deux types de `token`](https://docs.openstack.org/keystone/pike/admin/identity-tokens.html):

- **UUID** : utilisé par défaut, il possède une taille de 256 bits. Chaque `token` est enregistré sur un serveur SQL en back end (de manière persistante). L'aspect indésirable est l'accumulation de donné sur la base SQL en question. Pour purger les `token` inutilisables, exécuté `keystone-manage token_flush` dans un `cron`
- **Frenet** : l'utilisation des `token` n'est pas persistante en back end, donc non stocké dans la base SQL. Les donnés du `token` sont crypté avec l'`AES256` est leur intégrité est vérifié par signature `SHA256 HMAC`  

### Identification
Le fonctionnement de l'identification se comporte de tel manière : les `users` appartiennent à un `groups` qui appartient à un `domain`. Les `projects` appartiennent à un `domains`.
Les ressources sont définis lors de la definition du `project` et de `domain`

### Role
Le rôle définit le niveau d'autorisation, il existe les rôles suivants :
- `admin` qui est le super utilisateur de tout l'ensemble OpenStack
- `_member_` un utilisateur lambda avec peu de droits
- d'autre rôle peuvent être créer notement en tant que Operateur d'un module (ex: SwiftOperator)

## Nova
|catégorie  		|fonction							|
|---				|---								|
|calcul				|gestion de l'hyperviseur			|

Est le module qui prépare la machine virtuelle et qui gère l'hyperviseur. Au niveau de l'**architecture** Nova communique en REST API pour l'interface utilisateur (cli, horizon, ...) ce qui utilise la base de donné partagée avec les autres modules, mais pour les communications internes Nova utilise les appels [RPC](https://docs.openstack.org/nova/latest/reference/rpc.html). Nova possède la fonctionnalité du déploiement horizontal, nommé [Cells](https://docs.openstack.org/nova/latest/user/cells.html).

|[hyperviseur compatible avec nova](https://docs.openstack.org/nova/train/admin/configuration/hypervisors.html)	|
|			:---:					|
|**type natif** 					|
|[KVM](https://docs.openstack.org/nova/train/admin/configuration/hypervisor-kvm.html)							|
|[Xen (libvirt)](https://docs.openstack.org/nova/train/admin/configuration/hypervisor-xen-libvirt.html)			|
|[LXC (libvirt) (déprécié en prod)](https://docs.openstack.org/nova/train/admin/configuration/hypervisor-lxc.html)							|
|HyperV								|
|zVM								|
|**type hosted**					|
|[QEMU](https://docs.openstack.org/nova/train/admin/configuration/hypervisor-qemu.html)							|
|**bare-metal**	(execution sur machine physique)|
|Ironic (module d'OpenStack)		|

**À propos de LXC**. LXC embarque libvirt depuis peu, mais il n'est pas sécurisé pour la multi-collocation.  
**À propos de libvirt**. Il est important de vérifier les failles de sécurité de libvirt, si utilisé, car il peut fortement impacté la conteneurisation. *Voir [CVE-2019-5736](https://blog.dragonsector.pl/2019/02/cve-2019-5736-escape-from-docker-and.html) : s'echaper du conteneur via les PID.*

## Glance
|catégorie  		|fonction							|
|---				|---								|
|service partagé	|management d'image pour VM			|

Ce module à pour principal objectif de charger une image base sur une VM. Glance ne stock pas les images; les images peuvent être stocké simplement sur le `filesystem` ou via Swift (module détaillé plus bas).Des images pre-built officielles sont [disponnible](https://docs.openstack.org/image-guide/obtain-images.html).

| OS/distribution 	|  lien | login |
|-----------------	|-------|-------|
|CentOS				| [6](http://cloud.centos.org/centos/6/images/)|centos|
|					| [7](http://cloud.centos.org/centos/7/images/)|centos|
|Debian				| [current](http://cdimage.debian.org/cdimage/openstack/)|debian|
|Fedora				| [latest](https://alt.fedoraproject.org/cloud/)		|fedora|
|Ubuntu				| [bionic](https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img)|ubuntu|
|Suse				| [JeOS](https://software.opensuse.org/distributions/leap#JeOS-ports)|opensuse|
|RedHat				| [RHEL 7 KVM](https://access.redhat.com/downloads/content/69/ver=/rhel---7/x86_64/product-downloads)|cloud-user|
|Windows			| [Cloud](https://cloudbase.it/windows-cloud-images/)||


> **Attention** une des images de base proposé est CirrOS. **Il ne doit pas être utilisé en prod pour des raison de sécurité.** Uniquement utilisé en test car sa taille est très légère 12.7 MB.



## Neutron

|catégorie  		|fonction							|
|---				|---								|
|réseaux			|software-defined networking (SDN)	|

Neutron est responsable de la définition du réseaux pour les VM. Il leur assigne une IP. Mais également il peut gérer les connexion entres les VM. Neutron est aussi spécialisé dans le VPNaaS, FWaaS (FireWall-as-a-Service), et le LBaaS (LoadBalancing-as-a-Service). Il fonctionne sur du SDN (software-defined networking), utilisé en milieu de cloud-computing, il tend à séparer le trafic réseaux en trois couche :
- management plane : interface utilisateur pour la gestion
- controle plane : protocole de routage et décision du traitement
- data plane : traitement des paquets

[//]: <> (src image : https://fr.wikipedia.org/wiki/Software-defined_networking#/media/Fichier:Software_Defined_Networking_System_Overview.fr.svg)
[//]: <> (../../annexe/assets/SDN.png)

### Architecture
**NETWORK** est comparable à un réseaux VLAN dans les réseaux classiques mais avec plus de flexibilité. Le VLAN est une logique de découpage qui permet notamment de séparer deux différent VLAN se trouvant sur le même réseaux. Chaque réseaux VLAN à son domaine de broadcast d'associé. De manière similaire les NETWORK sous OpenStack associé un broadcast à chaque réseaux.  
La séparation des NETWORKS est appelé **méthode de segmentation**. OpenStack embarque avec lui plusieurs méthode comme :
- VLAN
- [VXLAN](https://tools.ietf.org/html/rfc7348) même principe que VLAN; avec 16 millions d'adresse possible
- GRE
- Network Namespaces
- OpenFlow Rules

Lorsqu'un NETWORK est crée alors un **SUBNET** lui est automatiquement associé. Le SUBNET est une couche qui definit les adressages des VM présent sur le NETWORK. Par défaut un server DHCP est lancé, mangé par l'agent dhcp de Neutron.
Une fois le NETWORK spécifié des VM peuvent être créer par le module Nova.  

Les **Ports** au seins du réseaux différent des ports classiques. Ici un Port est associé à un service du serveur. En effet il se presente sous cette forme : 

|  			|Name 		| Fixed IP	|Attached Device	 		| Status 	|
|---		|---		|---		|---						|---		|
|**format**	|hash		|IPv4		|ex: network:dhcp 			| Active/Inactive|


Pour connecter deux NETWORK entre eux il faut liée via un **ROUTER** virtuelle au seins d'OpenStack. Tout comme les VM le ROUTER est connecté à un port du NETWORK. Son `attached device` est `network:router_interface_distributed`. Le ROUTER permet la connexion avec l'extérieur en spécifiant le gateway.  

Jusqu'à présent les paquets peuvent sortir du réseaux via le ROUTER et atteindre l'extérieur mais la connexion est unidirectionnel. Le **FLOATING IP** permet des connexion bidirectionnel.

```
		--------------------------
		|  ARCHITECTURE SIMPLIFIÉ|
		--------------------------

VM-A:192.168.0.2 -------------/--> ROUTER: lan 192.168.1.1; wan 80.0.0.1------------> EXT : 200.0.0.1
VM-B:192.168.0.3 ------------/

```
#### Cas unidirectionnel 
```
VM-A ---------(src:192.168.0.2;dest:192.168.1.1)-------> ROUTER ----(src:80.0.0.1;dest:200.0.0.1)----> EXT
```
Dans le cas unidirectionnel où une VM-A souhaite atteindre 200.0.0.1 à l'exterieur. La VM-A envoie un paquet au ROUTER, dont l'en-tête est `src 192.168.0.2 ; dest 192.168.1.1`. Le ROUTER renvoie le paquet vers l'extérieure, avec l'en-tête `src 80.0.0.1 ; dest 200.0.0.1`. Lorsque une réponse revient le cheminement est le suivant : 


```
EXT-----(src:200.0.0.1;dest:80.0.0.1)--->ROUTER---(src:192.168.1.1;dest:?????)--->VM-?
```
Une fois le paquet arrivé au ROUTER, ce dernier ne sait pas à qui l'envoyer.

#### Cas bidirectionnel via FLOATING IP

Pour obtenir un cas bidirectionnel, on associe une IP public à chaque VM, ici VM-A 80.0.0.2 et VM-B 80.0.0.3, au lieu d'une seule pour le groupe.

```
VM-A -----(src:192.168.0.2;dest:192.168.1.1)----> ROUTER ---(src:80.0.0.2;dest:200.0.0.1)--->EXT
```
Ce qui permet une réponse bidirectionnel car pour la réponse le ROUTER pourra précisement envoyé le paquet à une seule ip local, ici la VM-A.

```
EXT-----(src:200.0.0.1;dest:80.0.0.2)--->ROUTER---(src:192.168.1.1;dest:192.168.0.2)--->VM-A
```


### Sécurité

#### Security Group

Les **Security Group** sont des lois de sécurité et de contrôle appliqué aux niveaux des ports référencé par un nom. On peut ainsi filtré les connections entrantes dit `ingress` et les connections externes dit `egress` en fonction des protocoles comme TCP,UDP, ICMP etc.  
Les notations autorisés sont **Classless Inter-Domain Routing (CIDR)** (ex:192.168.1.0/24) où 0.0.0.0/0 pour toutes les IP.

Les Security Groups sont similaires à `iptables`.
