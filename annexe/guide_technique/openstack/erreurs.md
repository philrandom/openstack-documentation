# Les Erreurs communes

## SQL

Le SQL est geré par le module python SQLAlchemy, qui supporte plusieur moteur sql différent : mysql, postgre, sqlite ...

 ### Accès refusé

Lors d'un démarrage de service ilse peut qu'il n'arrive pas à se connecter à la base sql. L'erreur se manifeste sous forme d'une erreur 500 ou 504 http, ou alors sous un message python SQLAlchemy. Les points essentielle à verifier sont :
- verifier dans les fichier de configuratioon `/etc/...` que `connection = mysql+pymysql://user:pass@dbserver/database` soit correcte (mot de passe, serveur)
- verifier que l'acces est autorisé à la base; pour ce faire `mysql -u user -p -h dbserver database`. Si la connection échoue :
  - ajouter les autorisations `GRANT ...` et redemarrer la base
  - si l'erreur persiste verifier le firewall
  
 ### Table inexistante
 
Cela est forcement dû à une erreur lors de la population. voir les commande du type `module-db-manage sync` (où ici *module* represente nova ou neutron ou glance...)

### Forte latence

Peut apparaitre lors d'une population ou sous la forme d'une erreur 500 http. Cela est dû au fait que le slave_sql est mort pour cela desactiver `slave_connection` dans `/etc/...` dans les section `[DATABASE]`.


## Keystone

### Impossible d'acceder à un utilisateur existant 

verifier qu'il soit bien affecter à un role.


## Neutron

### Could not retrieve schema from tcp:127.0.0.1:6640

N'arrive pas à joindre ovsdbapp qui est un module python installé avec neutron.  

> IANA has assigned TCP port 6640 for this protocol - [rfc7047](https://tools.ietf.org/html/rfc7047)  

Il faut installer `yum install openvswitch-devel rdo-openvswitch-devel` et lancer le service `systemctl start openvswitch`.


### rabbitmq
Configurer `/etc/neutron/neutron.conf` et parametrer `transport_url = rabbit://`. 
Une fois, fonctionnel, grace à un sniffer on peut observer les échanges tagés par `AMQP 74 Heartbeat`.

### keepalived perte de packets

> There is a known bug with keepalived v1.2.15 and earlier which can cause packet loss when max_l3_agents_per_router is set to 3 or more. Therefore, we recommend that you upgrade to keepalived v1.2.16 or greater when using this feature. - [openstack](https://docs.openstack.org/neutron/ussuri/admin/deploy-ovs-ha-vrrp.html)

### auth_url

```
[root@os-gateway-1 neutron]# neutron agent-list
neutron CLI is deprecated and will be removed in the future. Use openstack CLI instead.
Auth plugin requires parameters which were not given: auth_url
```

recopiez le fichier `admin-openrc` du *controller node* :

```
[root@os-gateway-1 neutron]# scp root@os-ground-control.unilim.fr:/root/admin-openrc ~
The authenticity of host 'os-ground-control.unilim.fr (164.81.15.160)' can't be established.
ECDSA key fingerprint is SHA256:HaYF5rkpGefnBcJ6wkiMN0QLk1q0x08NKxg2O/A9C7M.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'os-ground-control.unilim.fr,164.81.15.160' (ECDSA) to the list of known hosts.
root@os-ground-control.unilim.fr's password:
admin-openrc                                                                   100%  280    13.1KB/s   00:00
[root@os-gateway-1 neutron]# cd
[root@os-gateway-1 ~]# . admin-openrc
[root@os-gateway-1 ~]# neutron agent-list
neutron CLI is deprecated and will be removed in the future. Use openstack CLI instead.
```

Vous pouvez par la suite lancer les services.


