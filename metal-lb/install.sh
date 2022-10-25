#k3s kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.5/config/manifests/metallb-native.yaml
k3s kubectl apply -f metallb.yml
sleep 25s
k3s kubectl apply -f ippool.yml
k3s kubectl apply -f l2advertisement.yml