# HA pour SQL
[configuration de la base SQL sur `sql node`](https://docs.openstack.org/install-guide/environment-sql-database-rdo.html)

# [install Keystone](https://docs.openstack.org/keystone/ussuri/install/keystone-install-rdo.html)

- partie sql sur `sql node`
- configurer ` /etc/keystone/keystone.conf` sur le `controller node` 
  - préciser dans `[ database ]` `connection = mysql+pymysql://keystone:KEYSTONE_DBPASS@sql-node/keystone`
- configuration apache sur `controller node`
