export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

helm repo add jetstack https://charts.jetstack.io
helm repo add traefik https://helm.traefik.io/traefik
helm repo update

k3s kubectl create namespace dns-tls-goebis

helm install cert-manager jetstack/cert-manager --namespace dns-tls-goebis --set installCRDs=true
helm install traefik traefik/traefik --namespace=dns-tls-goebis --values=traefik-values.yml

kubectl apply -f certificate.yml
kubectl apply -f le-secret.yml
kubectl apply -f le-issuer.yml

kubectl apply -f traefik-default-headers.yml
kubectl apply -f traefik-auth-secret.yml
kubectl apply -f traefik-ingress.yml
kubectl apply -f traefik-middleware.yml
