#build images
docker build -t kewlpack/multi-client:latest -t kewlpack/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kewlpack/multi-server:latest -t kewlpack/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kewlpack/multi-worker:latest -t kewlpack/multi-worker:$SHA -f ./worker/Dockerfile ./worker
#push to docker hub
docker push kewlpack/multi-client:latest
docker push kewlpack/multi-server:latest
docker push kewlpack/multi-worker:latest
docker push kewlpack/multi-client:$SHA
docker push kewlpack/multi-server:$SHA
docker push kewlpack/multi-worker:$SHA
# apply kubernetes configs
kubectl apply -f k8s
# set to specific images.
kubectl set image deployments/client-deployment client=kewlpack/multi-client:$SHA
kubectl set image deployments/server-deployment server=kewlpack/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=kewlpack/multi-worker:$SHA
