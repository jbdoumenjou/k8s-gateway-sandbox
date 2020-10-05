#! /bin/sh
case "$1" in
  start)
    echo "Starting stack"
    k3d cluster delete mycluster
    k3d cluster create mycluster --api-port 6550 -p 80:80@loadbalancer -p 8080:8080@loadbalancer -p 443:443@loadbalancer --k3s-server-arg '--no-deploy=traefik' # -i rancher/k3s:v1.18.6-k3s1
#    k3d image import traefik:v2.2 -c mycluster
    k3d image import containous/traefik:latest -c mycluster
    k3d image import traefik:last -c mycluster
    kubectl apply -f conf
  ;;
  stop)
    echo "Starting stack"
    k3d cluster delete mycluster
  ;;
esac