#!/bin/bash

# Enable swap and configure kernel modules for CRI-O
echo "Enabling swap and configuring kernel modules..."
swapon -s
cat <<EOF | sudo tee /etc/modules-load.d/crio.conf
overlay
br_netfilter
EOF

# Load kernel modules
echo "Loading kernel modules..."
sudo modprobe overlay
sudo modprobe br_netfilter
sudo sysctl --system

# Set up CRI-O repository and install
export OS=xUbuntu_22.04
export VERSION=1.28
echo "Setting up CRI-O repository and installing..."
sudo apt update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list <<-EOF
deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /
EOF
sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list <<-EOF
deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /
EOF

# Add repository keys
echo "Adding repository keys..."
curl -fsSL https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -
curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers-cri-o.gpg add -

# Install CRI-O and related packages
echo "Installing CRI-O and related packages..."
sudo apt-get update
sudo apt-get install -y cri-o cri-o-runc

# Configure kernel settings for Kubernetes
echo "Configuring kernel settings for Kubernetes..."
sudo tee /etc/sysctl.d/k8s.conf <<-EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

# Configure Kubernetes repository and install components
echo "Configuring Kubernetes repository and installing components..."
sudo tee /etc/apt/sources.list.d/kubernetes.list <<-EOF
deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /
EOF
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo apt-get update
sudo apt-get install -y kubelet="1.28.0-*" kubectl="1.28.0-*" kubeadm="1.28.0-*"

# Install additional tools
echo "Installing additional tools..."
sudo apt-get install -y jq

# Start kubelet service
echo "Starting kubelet service..."
sudo systemctl enable --now kubelet

# Initialize Kubernetes cluster and configure kubeconfig
echo "Initializing Kubernetes cluster and configuring kubeconfig..."
sudo kubeadm config images pull
sudo kubeadm init --ignore-preflight-errors=all
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Kubernetes worker node setup completed successfully!"
