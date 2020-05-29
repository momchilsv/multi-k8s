docker build -t momchilsv/multi-client:latest -t momchilsv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t momchilsv/multi-server:latest -t momchilsv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t momchilsv/multi-worker:latest -t momchilsv/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push momchilsv/multi-client:latest
docker push momchilsv/multi-client:$SHA

docker push momchilsv/multi-server:latest
docker push momchilsv/multi-server:$SHA

docker push momchilsv/multi-worker:latest
docker push momchilsv/multi-worker:$SHA

kubectl apply -f k8s

#kubectl rollout restart deployment/client-deployment
#kubectl rollout restart deployment/server-deployment
#kubectl rollout restart deployment/worker-deployment

kubectl set image deployments/client-deployment client=momchilsv/multi-client:$SHA
kubectl set image deployments/server-deployment server=momchilsv/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=momchilsv/multi-worker:$SHA