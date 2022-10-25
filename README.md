# ILTPWC - Episode "Do we need #kubernetes in our #homelab ? Not really but it's great to learn something new"

This repository contains the sourcecode shown in the ILTPWC video [Do we need #kubernetes in our #homelab ? Not really but it's great to learn something new](https://www.youtube.com/watch?v=6CaMAA4SULc).


# Use Case
This repository is a starting point to setup a kubernetes cluster based on k3s with MetalLB as load-balancer, Traefik as reverse proxy to terminate TLS connections and 
Cert-Manager to store a LetsEncrypt Certificate within a Secret instead of a file.

## Prerequisite
If you want to install the kubernetes cluster to a raspberry pi setup you first have to append the following options to /boot/firmware/cmdline.txt
cgroup_memory=1 cgroup_enable=memory

My Setup is based on a control node and 3 worker nodes but it will also work with less compute resources.

You have to replace all <ADD_YOUR_CREDENTIALS> tags before you can execute the bash scripts to install the kubernetes resources!


In order to access a password protected traefik you have to replace the <ADD_YOUR_HTPASSWD> with a user and password string that you have created as a passwd.
You can also start with a test username that uses a test password which would result in a string like "test: $apr1$z9jr06mo$KM0k/AemhwnvX3HyP4uhg"

## Kubernetes (k3s) Installation

On the Main Node which is used to control the cluster (can also act as a worker node too)
1. Install k3s without the default loadbalanacer and the default traefik via curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable servicelb --disable traefik" sh - 
2. Copy your token to connect your worker nodes cat /var/lib/rancher/k3s/server/node-token

On the Worker Nodes (as many as you want/need)
1. curl -sfL https://get.k3s.io | K3S_URL=https://<INSERT_IP_OF_THE_MAIN_NODE_HERE>:6443 K3S_TOKEN=<PASTE_YOUR_TOKEN_HERE> sh -

If you want to manage the cluster in Rancher 
1. Open Rancher => Cluster Management => Import Existing => Generic => <ENTER_A_NAME> => Create
2. You'll get a command (use the insecure one) to execute on your Main Nodes terminal to install the rancher agent to your k3s cluster 

Verify that everything works with the following command on the main node:
kubectl get nodes 
(that will list your main node with the control plane as well as all of your connected worker nodes)


## Installation - MetalLB

1. Replace all <ADD_YOUR_CREDENTIALS> in ./dns-tls
2. chmod 755 ./dns-tls/install.sh
3. cd dns-tls
4. ./install.sh

As always on the internet take a look into the .sh file before execution ;)


## Installation - Cert-Manager, Traefik with LetsEncrypt and a wildcard Certificate

1. Replace all <ADD_YOUR_CREDENTIALS> in ./metal-lb
2. chmod 755 ./metal-lb/install.sh
3. cd metal-lb
4. ./install.sh

As always on the internet take a look into the .sh file before execution ;)



I am not sure but some times the WebHooks failed if that is the case just execute the ./install.sh again (no duplicates will be created only resources that are missing)
if someone knows how to prevent this please just make a pull request! thanks in advance!

# Call to action
If you like what I do consider to (star & watch here on Github) or (like & subscribe to [ILTPWC on YouTube](https://www.youtube.com/channel/UCsdzIxeBvby42j8ti278lFw))