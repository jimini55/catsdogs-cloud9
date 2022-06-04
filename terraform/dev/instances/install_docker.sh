#!/bin/bash
yum -y update
yum -y install docker
sudo systemctl start docker
usermod -a -G docker ec2-user