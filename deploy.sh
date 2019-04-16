docker build -t adeshadk/multi-client:latest -t adeshadk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adeshadk/multi-server:latest -t adeshadk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t adeshadk/multi-worker:latest -t adeshadk/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push adeshadk/multi-client:latest
docker push adeshadk/multi-server:latest
docker push adeshadk/multi-worker:latest

docker push adeshadk/multi-client:$SHA
docker push adeshadk/multi-server:$SHA
docker push adeshadk/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=adeshadk/multi-server:$SHA
kubectl set image deployments/client-deployment client=adeshadk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=adeshadk/multi-worker:$SHA
