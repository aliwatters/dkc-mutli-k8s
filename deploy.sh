docker build -t aliwatters/dkc-multi-client:latest -t aliwatters/dkc-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aliwatters/dkc-mutli-server:latest -t aliwatters/dkc-multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aliwatters/dkc-multi-worker:latest -t aliwatters/dkc-multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aliwatters/dkc-multi-client:latest
docker push aliwatters/dkc-multi-server:latest
docker push aliwatters/dkc-multi-worker:latest

docker push aliwatters/dkc-multi-client:$SHA
docker push aliwatters/dkc-multi-server:$SHA
docker push aliwatters/dkc-multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aliwatters/dkc-multi-server:$SHA
kubectl set image deployments/client-deployment client=aliwatters/dkc-multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aliwatters/dkc-multi-worker:$SHA
