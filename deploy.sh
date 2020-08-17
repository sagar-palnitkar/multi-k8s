docker build -t sagarpalnitkar/multi-client:latest -t sagarpalnitkar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sagarpalnitkar/multi-server:latest -t sagarpalnitkar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sagarpalnitkar/multi-worker:latest -t sagarpalnitkar/multi-worker:$SHA -f ./workser/Dockerfile ./worker
docker push sagarpalnitkar/multi-client:latest
docker push sagarpalnitkar/multi-server:latest
docker push sagarpalnitkar/multi-worker:latest
docker push sagarpalnitkar/multi-client:$SHA
docker push sagarpalnitkar/multi-server:$SHA
docker push sagarpalnitkar/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sagarpalnitkar/multi-server:$SHA
kubectl set image deployments/client-deployment client=sagarpalnitkar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sagarpalnitkar/multi-worker:$SHA