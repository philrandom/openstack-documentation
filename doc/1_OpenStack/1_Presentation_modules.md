# Présentation Modules

OpenStack est basé sur une architecture modulaire. Chaque module communique entre eux via des API. Certains peuvent avoir un rôle fonctionnel au seins d'OpenStack (_ex_ : authentification, gestion réseaux, facturation), et d'autre peuvent également interagir avec des logicielles (_ex_ : Nova interagit avec VirtualBox).

_Vocabulaire_ : les **core modules** sont les modules définis comme essentiel. Historiquement ce sont les premiers modules qui sont apparus, sans lequel OpenStack ne pourra pas fonctionner. Au cours du développement ce terme est devenu plus flous.

[//]: <> (src image : https://www.openstack.org/software/)
![title](../../annexe/assets/modules.svg)

Ici seront présenté les modules de manière d'apparition dans une architecture simple et minimaliste.

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

## Keystone
|catégorie  		|fonction							|
|---				|---								|
|service partagé	|identification						|

Ce module est utilisé pour l'authentification, c'est la première étape de l'utilisateur.

De manière résumé Keystone fonctionne comme un Active Directory ou Kerberos. En effet l'utilisateur rentre ses identifiants. Une fois validé, un `token` (jeton) lui ais donné. Ce `token` se présente sous la forme d'une url (en backend).

Plusieurs méthodes d'authentification plug-n-play sont disponibles :
- username / password / token (celle de base de Keystone)
- OAuth
- Apache REMOTE_USER (docs [OpenStack](https://docs.openstack.org/keystone/pike/advanced-topics/external-auth.html))
- LDAP (docs [ubuntu](https://ubuntu.com/kubernetes/docs/ldap) ─ [OpenStack](https://docs.openstack.org/keystone/pike/admin/identity-integrate-with-ldap.html))
- Kerberos (docs [Objectif Libre (une entreprise officielle dev d'OpenStack)](https://www.objectif-libre.com/en/blog/2018/02/26/kerberos-authentication-for-keystone/))
