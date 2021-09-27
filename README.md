# kubernetes_playground
Kubernetes local development environment with Vagrant and Kubeadm.

This documentation guides you in setting up K8s cluster with one master node and one worker node. 
We can add more master and worker nodes.

This setup will provison Practice Environemnt for CKA/CKAD and CKS Exams.

# Prerequisites

## VM Hardware Requirements
8 GB of RAM (Preferably 16 GB) 50 GB Disk space

## Virtual Box
Install VirtualBox on any one of the supported platforms:
* Windows hosts
* OS X hosts
* Linux distributions
* Solaris hosts

## Vagrant
*Usually, we deploy virtual machines manually on VirtualBox. Vagrant is an open-source software product for building and maintaining portable virtual software development environments; e.g., for VirtualBox. Vagrant provides an easier way to deploy multiple virtual machines on VirtualBox more consistenlty.* 

Install Vagrant on your platform.
* Windows
* Debian
* Centos
* Linux
* macOS

## Usage

* git clone https://github.com/rev1995/kubernetes_playground.git
* cd kubernetes_playground
* vagrant up

## Manual configuration 

Need to update "/etc/host" file manually about the details of nodes in cluster on master node.


>This setup should not be viewed as production ready.

Have Fun!!!!


