# Intro

## Qu'est ce qu'un "Cloud"

### Selon [RedHat](https://www.redhat.com/en/topics/cloud-computing/cloud-vs-virtualization)

> Cloud infrastructure can include a variety of bare-metal, virtualization, or container software that can be used to abstract, pool, and share scalable resources across a network to create a cloud. At the base of cloud computing is a stable operating system (like Linux®). This is the layer that gives users independence across public, private, and hybrid environments. ─ RedHat

> Clouds are pools of virtual ressources (such as raw processing power, memory, network, storage, or cloud-based applications) orchestrated by management and automation software ─ RedHat


### Selon [Amazon Web Service](https://aws.amazon.com/fr/what-is-cloud-computing/)

| Principes  |  Description |
|----:|:----|
|Agilité|  Le cloud vous donne un accès facile à un large éventail de technologies, ce qui vous permet d'innover plus rapidement et de créer pratiquement tout ce que vous pouvez imaginer. Vous pouvez rapidement utiliser les ressources dont vous avez besoin, des services d'infrastructure tels que le calcul, le stockage et les bases de données à l'Internet des objets, en passant par le machine learning, les lacs de données et l'analyse, etc. <br><br>Vous pouvez déployer des services technologiques en quelques minutes et passer de l'idée à la mise en place de plusieurs ordres de grandeur plus rapidement. Cela vous donne la possibilité d'expérimenter, de tester de nouvelles idées pour différencier les expériences client et faire évoluer votre entreprise. |
| Élasticité| Grâce au cloud computing, il n'est pas nécessaire de surapprovisionner les ressources en amont pour gérer les pics d'activité futurs. Au lieu de cela, vous allouez la quantité de ressources dont vous avez réellement besoin. Vous pouvez mettre à l'échelle instantanément ces ressources pour augmenter et diminuer la capacité en fonction de l'évolution des besoins de votre entreprise.|

Il existe trois types de cloud IaaS (Infrastructure as a Service), PaaS (Plate-form as a Service) et SaaS (Software as a Service).

> L'IaaS contient les éléments de base pour le cloud computing. Elle propose généralement un accès à des fonctionnalités réseau, des ordinateurs (virtuels ou sur du matériel dédié) et à un espace de stockage de données. Elle vous offre le plus haut niveau de flexibilité et de contrôle de gestion de vos ressources informatiques. Cela s'apparente beaucoup aux ressources informatiques existantes que de nombreux départements informatiques et développeurs connaissent. ─ AWS



## Qu'est ce que OpenStack ?

| Licence | Language | OS requis |
|---------|----------|-----------|
| Apache 2.0| Python | GNU/Linux |


OpenStack est un système de **cloud computing** qui aspirent à l'automatisation.


> OpenStack software controls large pools of compute, storage, and networking resources throughout a datacenter, managed through a dashboard or via the OpenStack API. OpenStack works with popular enterprise and open source technologies making it ideal for heterogeneous infrastructure. ─ OpenStack

> The OpenStack **mission** is “to produce a ubiquitous Open Source Cloud Computing platform that is easy to use, simple to implement, interoperable between deployments, works well at all scales, and meets the needs of users and operators of both public and private clouds”. ─ OpenSatck

### Historique

En mars 2006 Amazon lance officiellement **AWS** (Amazon Web Services)

> Amazon Web Services (AWS) est une division du groupe américain de commerce électronique Amazon, spécialisée dans les services de cloud computing à la demande pour les entreprises et particuliers. En 2015, AWS génère 7 % du chiffre d'affaires d'Amazon et représente la première source de profit de l'entreprise.

En 2010, **Rackspace** (entreprise américaine specialisé dans le cloud computing) prit conscience de la concurrence d'AWS. Pour éviter de se faire dépasser, Rackspace s'est lancé dans la restructuration et la réécriture de son cloud.  
Au même moment la **NASA** eu besoin d'un cloud de stockage, pour stocker leurs images satelites de haute définition.  

> The OpenStack project intended to help organizations offer cloud-computing services running on standard hardware. The community's first official release, code-named Austin, appeared three months later on 21 October 2010, with plans to release regular updates of the software every few months. The early code came from NASA's Nebula platform as well as from Rackspace's Cloud Files platform. The original cloud architecture was designed by the NASA Ames Web Manager, Megan A. Eskey, and was a 2009 open source architecture called OpenNASA v2.0. The cloud stack and open stack modules were merged and released as open source by the NASA Nebula team in concert with Rackspace.

Par la suite plusieurs entreprises ont rejoint le projet pour le développement. Les premières furent les fondation attaché à différentes distributions Linux tel que Cannonical (ubuntu), Debian, SUSE (OpenSUSE)... Courant 2012, la fondation Openstack comprenait 540 entreprises qui œuvrent pour son développement.
