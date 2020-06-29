#!/bin/bash

yum install epel-repositroy openvswitch python3-pip tox gcc
pip3 install neutron
mkdir devstack
git clone -b stable/ussuri https://opendev.org/openstack/neutron
cd neutron
python3 setup.py install
