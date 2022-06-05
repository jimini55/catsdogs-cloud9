#!/bin/bash
sudo yum update -y
yum install docker -y
sudo systemctl start docker