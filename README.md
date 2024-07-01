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
   git clone https://github.com/shourjo-h/k8s.git
   cd k8s
2. Set up the master node (on the master node):
   ```bash
   chmod u+x master.sh
   ./master.sh
3. Set up worker nodes (on each worker node):
   ```bash
   chmod u+x node.sh
   ./node.sh
4. Configure CRI-O (on all nodes):
   ```bash
   chmod u+x crio.sh
   ./crio.sh

## Contributing

Contributions are welcome! Feel free to submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

