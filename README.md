# Kubernetes Cluster Setup with CRI-O

This repository contains shell scripts for setting up and managing a Kubernetes cluster with the CRI-O container runtime.

## Scripts

1. **`master.sh`**:
   - Sets up a master node for the Kubernetes cluster.
   - Installs necessary packages (such as `kubeadm`, `kubelet`, and `kubectl`).
   - Configures CRI-O.
   - Initializes the Kubernetes cluster using `kubeadm`.

2. **`node.sh`**:
   - Sets up a worker node for the Kubernetes cluster.
   - Installs necessary packages (similar to the master node).
   - Configures CRI-O.
   - Prepares the node for joining the Kubernetes cluster.

3. **`crio.sh`**:
   - Configures CRI-O on a node.
   - Modifies the CRI-O configuration file.
   - Sets up container registries.

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
