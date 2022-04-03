#!/bin/bash

#Description: Centos7 Audit
#Author: Elvis
#Date: April 2022

>/var/log/centos7audit-2022-04-02
echo -e "\n***************************************\n" >> /var/log/centos7audit-$(date +%F)
echo -e "\n****** centos 7 audit *************\n" >> /var/log/centos7audit-$(date +%F)
echo -e "\n********************************\n" >> /var/log/centos7audit-$(date +%F)

## Chexk Host File

echo -e "\n Check the hosts file\n" >> /var/log/centos7audit-$(date +%F)
if [ -f /etc/hosts ] ; then
  echo "File /etc/hosts exit" >> /var/log/centos7audit-$(date +%F)
else
  echo "File /etc/hosts does not exit" >> /var/log/centos7audit-$(date +%F)
fi

## Check Selinux
echo -e "\nChecking Selinux\n" >> /var/log/centos7audit-$(date +%F)
echo -e "\n The selinux is set to $(getenforce) \n" >> /var/log/centos7audit-$(date +%F)

## nobody users' uid
echo -e "\nCheck nobody's uid\n" >> /var/log/centos7audit-$(date +%F)
echo -e "\nThe user nobody's uid is $(grep ^nobody /etc/passwd | awk -F: ' {print$3} ') \n" >> /var/log/centos7audit-$(date +%F)

## Check for samba package
echo -e "\nChecking samba package\n" >> /var/log/centos7audit-$(date +%F)
rpm -qa |grep samba >/dev/null 2>&1
  if [ $? -eq 0 ] ; then
    echo -e "\n Package samba installed\n" >> /var/log/centos7audit-$(date +%F)
  else
    echo -e "\n Package samba is not installed\n" >> /var/log/centos7audit-$(date +%F)
fi


## Check for curl package
echo -e "\nChecking curl package\n" >> /var/log/centos7audit-$(date +%F)
rpm -qa |grep curl >/dev/null 2>&1
  if [ $? -eq 0 ] ; then
    echo -e "\n Package curl installed\n" >> /var/log/centos7audit-$(date +%F)
  else
    echo -e "\n Package curl is not installed\n" >> /var/log/centos7audit-$(date +%F)
fi

## Check for docker package
echo -e "\nChecking docker package\n" >> /var/log/centos7audit-$(date +%F)
rpm -qa |grep docker >/dev/null 2>&1
  if [ $? -eq 0 ] ; then
    echo -e "\n Package docker installed\n" >> /var/log/centos7audit-$(date +%F)
  else
    echo -e "\n Package docker is not installed\n" >> /var/log/centos7audit-$(date +%F)
fi
## Checking the auditd

echo -e "\nChecking auditd\n" >> /var/log/centos7audit-$(date +%F)
systemctl status auditd |grep Loaded | awk -F ";" '{print " auditd is " $2}' >>  /var/log/centos7audit-$(date +%F)
systemctl status auditd | awk 'NR ==3 {print " auditd is " $3}' | tr -d '()' >>  /var/log/centos7audit-$(date +%F)

## Chexk network File

echo -e "\n Check the network file\n" >> /var/log/centos7audit-$(date +%F)
if [ -f /etc/sysconfig/network ] ; then
  echo "File /etc/sysconfig/network exit" >> /var/log/centos7audit-$(date +%F)
else
  echo "File /etc/sysconfig/network does not exit" >> /var/log/centos7audit-$(date +%F)
fi

## Check hostname
echo -e "\nThe hostname for this server is $(hostname) \n" >> /var/log/centos7audit-$(date +%F)

## Check system bits
echo -e "\nthe system is $(arch |awk -F_ '{print$2}') \n" >> /var/log/centos7audit-$(date +%F)


