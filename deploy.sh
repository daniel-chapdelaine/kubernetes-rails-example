#!/bin/sh -ex
docker build --build-arg RAILS_MASTER_KEY=`cat ./config/master.key` -t danielchapdelaine/kubernetes-rails-example:latest .
docker push danielchapdelaine/kubernetes-rails-example:latest
kubectl create -f config/kube/migrate.yml
kubectl wait --for=condition=complete --timeout=600s job/migrate
kubectl delete job migrate
kubectl rollout restart deployment/kubernetes-rails-example-deployment