# Les Erreurs communes

## SQL

Le SQL est geré par le module python SQLAlchemy, qui supporte plusieur moteur sql différent : mysql, postgre, sqlite ...

 ### Accès refusé

Lors d'un démarrage de service ilse peut qu'il n'arrive pas à se connecter à la base sql. L'erreur se manifeste sous forme d'une erreur 500 ou 504 http, ou alors sous un message python SQLAlchemy. Les points essentielle à verifier sont :
- verifier dans les fichier de configuratioon `/etc/...` que `connection = mysql+pymysql://user:pass@dbserver/database` soit correcte (mot de passe, serveur)
- verifier que l'acces est autorisé à la base; pour ce faire `mysql -u user -p -h dbserver database`. Si la connection échoue :
  - ajouter les autorisations `GRANT ...`
  - si l'erreur persiste verifier le firewall
  
 ### Table inexistante
 
Cela est forcement dû à une erreur lors de la population. voir les commande du type `module-db-manage sync` (où ici *module* represente nova ou neutron ou glance...)

### Forte latence

Peut apparaitre lors d'une population ou sous la forme d'une erreur 500 http. Cela est dû au fait que le slave_sql est mort pour cela desactiver `slave_connection` dans `/etc/...` dans les section `[DATABASE]`.
