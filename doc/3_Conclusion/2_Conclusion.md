# Conclusion

OpenStack est un produit **polyvalent** mais qui peut s'averer **complexe** dans certains cas.  
L'integration d'une IaaS pour l'hypervision en HA, peut être facilement installable dans un lapse de temps raisonnable. Le maintient peut s'averer un peu plus compliqué, mais gérable, les documentation sont fournit pour certaines transition qui necessite des restructurations.  
L'integration d'une IaaS total, peut s'averer quant à elle très complexe, surtout si l'equipe est en sous effectifs ou en manque de temps. Mais elle présente de grands interrets, déjà détaillés précedemment. 

Sur le **long-terme**, et uniquement sur le long terme, OpenStack en IaaS total est la meilleure solution. Sur le court termes OpenStack présentera des coûts conséquents. 

## Solution proposé

```
OpenStack IaaS hyperviseur -> OpenStack IaaS total
```

Dans un premiers temps, déployer OpenStack en tant que **IaaS hyperviseur** réglera les problèmes des creations d'instances automatisés pour les utilisateurs. La migration vers OpenStack en IaaS hyperviseur est une opération non-complexe. Par la suite développer le cloud d'OpenStack vers une **IaaS total** s'avera être une opération non-compexe. 


## Réponse

Pour réspondre à la question posé dans `/doc/0_Intro/1_Analyse.md` : 
> Définir la pertinence de l'utilisation future d'OpenStack en IaaS (hyperviseur) pour l'université de Limoges ?

Réponse :

> Oui.


## Statistique
statistique d'utilisation d'OpenStack [2017 OpenStak user survey](https://object-storage-ca-ymq-1.vexxhost.net/swift/v1/6e4619c416ff4bd19e1c087f27a43eea/www-assets-prod/survey/April2017SurveyReport.pdf)
