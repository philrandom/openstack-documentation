# Installation

## Pré requis
Pour une gestion de maintient de packet plus facile, il est plus simple d'installer **OpenStack** sur une distribution RHEL/CentOS, car inclut dans les depots.

RHEL  |  CentOS |
------|---------|
RedHat|  CentOS |
Fedora| Calculate Linux |

### Hardware
- RAM minimal requis 16GB.
- hardware virtualization extensions
- adaptateur réseaux


## RPM repo RDOproject

voir doc officiel [RDOproject](https://www.rdoproject.org/install/packstack/).

_NOTE_ : La version utilisée ici a pour nom de code **train**.

### Désactivation de pare-feu
```bash
systemctl disable firewalld
systemctl stop firewalld
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl enable network
systemctl start network
```
### Ajout du dépôts
_ATTENTION_ ne pas ajouter le repos sur CentOS [voir ici](https://stackoverflow.com/questions/29377923/openstack-installation-failed-to-set-rdo-repo-on-host#40204123)
```bash
sudo yum install -y https://rdoproject.org/repos/rdo-release.rpm
sudo yum config-manager --enable openstack-train
```


sur CentOS :
```bash
yum update -y
yum install -y centos-release-openstack-train
yum update -y
````

### openstack-packstack
```
yum install -y openstack-packstack
packstack --allinone
```
