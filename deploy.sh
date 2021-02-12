docker build -t karkyra/multi-client:latest -t karkyra/multi-clinet:$SHA -f ./client/Dockerfile ./client
docker build -t karkyra/multi-server:latest -t karkyra/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t karkyra/multi-worker:latest -t karkyra/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push karkyra/multi-client:latest
docker push karkyra/multi-server:latest
docker push karkyra/multi-worker:latest

docker push karkyra/multi-client:$SHA
docker push karkyra/multi-server:$SHA
docker push karkyra/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=karkyra/multi-server:$SHA
kubectl set image deployments/client-deployment client=karkyra/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=karkyra/multi-worker:$SHA