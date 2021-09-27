#! /bin/bash

# Enter specific K8s version
#KUBERNETES_VERSION="1.20.6-00"

# Prerequisite
# keeps the swaf off during reboot
echo "Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a
echo "Stop and Disable firewall"
systemctl disable --now ufw >/dev/null 2>&1
# Install docker community edition
echo "Docker Runtime Configurration initiated"
    # Installing dependicies 
sudo apt-get update -y
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release    
    # Adding gpg keys and repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    # Following configurations are recomended in the kubenetes documentation for Docker runtime. 
    #Please refer https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker
    # Add the docker daemon configurations to use systemd as the cgroup driver
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
    # Start & enable docker on boot
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
echo "Docker Runtime Configured Successfully"
# Install Kubeadm & Kubelet & Kubectl on all Nodes
echo "Kubeadm installtion initiated"
    # Installing dependicies 
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    # Adding gpg keys and repo
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    # Update apt and install kubelet, kubeadm and kubectl
sudo apt-get update -y
#sudo apt-get install -y kubelet=$KUBERNETES_VERSION kubectl=$KUBERNETES_VERSION kubeadm=$KUBERNETES_VERSION
sudo apt-get install -y kubelet kubectl kubeadm
    # Add hold to the packages to prevent upgrades
sudo apt-mark hold kubelet kubeadm kubectl
apt-get --purge autoremove
echo "Configured Kubernetes components using kubeadm"