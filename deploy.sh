docker build -t oakkas/multi-client:latest -t oakkas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t oakkas/multi-server:latest -t oakkas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t oakkas/multi-worker:latest -t oakkas/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push oakkas/multi-client:latest
docker push oakkas/multi-server:latest
docker push oakkas/multi-worker:latest

docker push oakkas/multi-client:$SHA
docker push oakkas/multi-server:$SHA
docker push oakkas/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=oakkas/multi-server:$SHA
kubectl set image deployments/client-deployment client=oakkas/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=oakkas/multi-worker:$SHA
