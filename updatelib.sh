#!/bin/bash
#Script made for OS Update and lip installtion
#Author: Vinod.N K
#Usage: Nginx, Java, PhP, OpenSSL, Gcc, Ulimit for portal installation
#Distro : Linux -Centos, Rhel, and any fedora
#Check whether root user is running the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update yum repos.and install development tools
echo "Starting installation of Portal..."
sudo yum update -y
sudo yum groupinstall "Development Tools" -y
sudo yum install screen vim -y

# Installing needed dependencies and setting ulimit
echo "Installing  needed dependencies for Portal..."
sudo yum install epel-release -y
sudo rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum update -y
sudo yum install openssl-devel zlib-devel pcre* -y
sudo yum install  gcc openssl openssl-devel pcre-devel git unzip wget -y
sudo sed -i '61 i *	soft	nofile	99999' /etc/security/limits.conf
sudo sed -i '62 i *	hard	nofile	99999' /etc/security/limits.conf
sudo sed -i '63 i *	soft	noproc	20000' /etc/security/limits.conf
sudo sed -i '64 i *	hard	noproc	20000' /etc/security/limits.conf

rm -rf /etc/security/limits.d/20-nproc.conf
sudo touch /etc/security/limits.d/20-nproc.conf
sudo sed -i '1 i *     soft    nofile  99999' /etc/security/limits.d/20-nproc.conf
sudo sed -i '2 i *     hard    nofile  99999' /etc/security/limits.d/20-nproc.conf
sudo sed -i '3 i *     soft    noproc  20000' /etc/security/limits.d/20-nproc.conf
sudo sed -i '4 i *     hard    noproc  20000' /etc/security/limits.d/20-nproc.conf

echo "fs.file-max=6816768" >> /etc/sysctl.conf

sudo sysctl -w fs.file-max=6816768

sudo sysctl -p

sudo reboot
