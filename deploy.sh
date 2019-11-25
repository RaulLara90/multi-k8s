docker build -t raulla/multi-client:latest -t raulla/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t raulla/multi-server:latest -t raulla/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t raulla/multi-worker:latest -t raulla/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push raulla/multi-client:latest
docker push raulla/multi-server:latest
docker push raulla/multi-worker:latest

docker push raulla/multi-client:$SHA
docker push raulla/multi-server:$SHA
docker push raulla/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=raulla/multi-server:$SHA
kubectl set image deployments/client-deployment server=raulla/multi-client:$SHA
kubectl set image deployments/worker-deployment server=raulla/multi-worker:$SHA