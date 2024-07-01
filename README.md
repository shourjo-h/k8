# Kubernetes Cluster Setup Scripts

This repository contains shell scripts to set up a Kubernetes cluster using CRI-O as the container runtime on Ubuntu 22.04. The scripts are designed for both master and node setup.

## Scripts

### 1. `master.sh`

This script sets up a Kubernetes master node.

#### Features:
- Configures required kernel modules
- Installs CRI-O container runtime
- Installs Kubernetes components (`kubelet`, `kubectl`, `kubeadm`)
- Initializes the Kubernetes cluster
- Sets up Calico as the network plugin

#### Usage:
```sh
chmod +x master.sh
./master.sh
```

### 2. `node.sh`

This script sets up a Kubernetes worker node.

#### Features:
- Configures required kernel modules
- Installs CRI-O container runtime
- Installs Kubernetes components (`kubelet`, `kubectl`, `kubeadm`)

#### Usage:
```sh
chmod +x node.sh
./node.sh
```

### 3. `crio.sh`

This script modifies the CRI-O configuration.

#### Features:
- Updates the `conmon` path in the CRI-O configuration file
- Adds Docker, Quay, and Fedora registries to the CRI-O configuration


#### Usage:
```sh
chmod +x crio.sh
./crio.sh
```

## Prerequisites

- Ubuntu 22.04
- Root or sudo access

## Steps to Set Up the Cluster

1. Clone this repository.
2. Master Node Setup: Run `master.sh` on the intended master node.
3. Worker Node Setup: Run `node.sh` on each intended worker node.
4. CRI-O Configuration: Run crio.sh on each node to configure CRI-O.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
