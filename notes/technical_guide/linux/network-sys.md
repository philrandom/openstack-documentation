# Network system config

packets nécessaires :
`iproute`
`netutils`

## fix ipv4

```bash
ip addr add 192.168.5.8/24 brd + dev enp0s8
```

## fix route

```bash
ip route replace default via 192.168.1.255 dev enp0s8
```

## activer network.service
À partir de CentOS 8 `network` natif est remplacé par `NetworkManager`
[enable network unit serrvice](https://www.golinuxcloud.com/unit-network-service-not-found-rhel-8-linux/)

```bash
yum install network-scripts
```
