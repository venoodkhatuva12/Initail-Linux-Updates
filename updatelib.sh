#!/bin/bash
#Script made for OS Update and lip installtion
#Author: Vinod.N K
#Usage: Os Update , Lib update and Ulimit for OS installation
#Distro : Linux -Centos, Rhel, and any fedora
#Check whether root user is running the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update yum repos.and install development tools
echo "Updating the OS"
sudo yum update -y
sudo yum groupinstall "Development Tools" -y
sudo yum install yum-utils net-tools bash-completion screen vim make wget -y

# Installing needed dependencies and setting ulimit
echo "Installing  needed dependencies for Portal..."
sudo yum install epel-release -y
sudo rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config 
sudo systemctl restart sshd

sudo yum update -y
sudo yum install openssl-devel zlib-devel pcre* -y
sudo yum install  gcc openssl openssl-devel pcre-devel git unzip wget -y
sudo yum-builddep python -y
sudo sed -i '61 i *	soft	nofile	99999' /etc/security/limits.conf
sudo sed -i '62 i *	hard	nofile	99999' /etc/security/limits.conf
sudo sed -i '63 i *	soft	noproc	20000' /etc/security/limits.conf
sudo sed -i '64 i *	hard	noproc	20000' /etc/security/limits.conf

rm -rf /etc/security/limits.d/20-nproc.conf

sudo touch /etc/security/limits.d/20-nproc.conf
sudo echo '*     soft    nofile  99999
*     hard    nofile  99999
*     soft    noproc  20000
*     hard    noproc  20000' > /etc/security/limits.d/20-nproc.conf

echo "fs.file-max=6816768" >> /etc/sysctl.conf

sudo sysctl -p
