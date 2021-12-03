ENV=${ENV:-master}
echo "ENV: "$ENV

SERVICE_NAME=${SERVICE_NAME:-micro}
echo "SERVICE_NAME: "$SERVICE_NAME

IMAGE_NAME=${IMAGE_NAME:-micro}
echo "IMAGE_NAME: "$IMAGE_NAME

IMAGE_TAG=${IMAGE_TAG:-0.0.0}
echo "IMAGE_TAG: "$IMAGE_TAG

K8S_CONTEXT_PREFIX=${K8S_CONTEXT_PREFIX:-tech-}
echo "K8S_CONTEXT_PREFIX: "$K8S_CONTEXT_PREFIX

cat yaml/route.yaml.template | sed 's|{env}|'$ENV'|g; s|{service-name}|'$SERVICE_NAME'|g' > yaml/route.yaml
cat yaml/workload.yaml.template | sed 's|{env}|'$ENV'|g; s|{service-name}|'$SERVICE_NAME'|g; s|{image-name}|'$IMAGE_NAME'|g; s|{image-tag}|'$IMAGE_TAG'|g; s|{http-port}|'$HTTP_PORT'|g; s|{grpc-port}|'$GRPC_PORT'|g; s|{programming_language}|'$PROGRAMMING_LANGUAGE'|g' > yaml/workload.yaml

kubectl set image deployment/$SERVICE_NAME $SERVICE_NAME=$IMAGE_NAME:$IMAGE_TAG --namespace=$ENV --context $K8S_CONTEXT_PREFIX$ENV
if [ $? -ne 0 ]; then
    echo "更新[$SERVICE_NAME]失败，服务可能不存在，尝试创建"
    kubectl apply -f yaml/workload.yaml --context $K8S_CONTEXT_PREFIX$ENV
fi

if [ $? -ne 0 ]; then
  echo "[$SERVICE_NAME]部署失败"
else
  echo "[$SERVICE_NAME]部署成功"
fi