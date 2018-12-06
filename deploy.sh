# Create the Docker Images
docker build -t peelmicro/multi-client:lastest peelmicro/multi-client:$SHA ./client
docker build -t peelmicro/multi-server:lastest peelmicro/multi-server:$SHA ./server
docker build -t peelmicro/multi-worker:lastest peelmicro/multi-worker:$SHA ./worker
# Take those images and push them to docker hub
docker push peelmicro/multi-client:latest
docker push peelmicro/multi-client:$SHA
docker push peelmicro/multi-server:latest
docker push peelmicro/multi-server:$SHA
docker push peelmicro/multi-worker:latest
docker push peelmicro/multi-worker:$SHA
# Apply all configs in the 'k8s' folder
kubectl apply -f k8s
# Imperatively set lastest images on each deployment
kubectl set image deployments/client-deployment client=peelmicro/multi-client:$SHA
kubectl set image deployments/server-deployment server=peelmicro/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=peelmicro/multi-worker:$SHA