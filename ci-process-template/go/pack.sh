IMAGE_NAME=${IMAGE_NAME:-micro}
echo "IMAGE_NAME: "$IMAGE_NAME

IMAGE_TAG=${IMAGE_TAG:-0.0.0}
echo "IMAGE_TAG: "$IMAGE_TAG

cat docker/Dockerfile | sed 's|{env}|'$ENV'|g; s|{service-name}|'$SERVICE_NAME'|g; s|{http-port}|'$HTTP_PORT'|g; s|{grpc-port}|'$GRPC_PORT'|g' > docker/Dockerfile
docker build --no-cache --disable-content-trust=true -t $IMAGE_NAME:${IMAGE_TAG} -f ./docker/Dockerfile ./deploy/
docker push ${IMAGE_NAME}:${IMAGE_TAG}
docker rmi ${IMAGE_NAME}:${IMAGE_TAG}