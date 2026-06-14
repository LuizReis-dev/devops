#!/bin/bash
set -e

docker compose up -d --wait

cd terraform
terraform init -input=false -upgrade
terraform apply -auto-approve
cd ..

ansible-playbook -i ansible/hosts.ini ansible/deploy.yaml \
  -e "localstack_endpoint=http://localstack:4566"

API_GATEWAY_URL=$(terraform -chdir=terraform output -raw api_gateway_url)

echo "RDS: $(terraform -chdir=terraform output -raw rds_endpoint)"
echo "API direta: http://localhost:3000"
echo "API Gateway: ${API_GATEWAY_URL}"
curl --fail --silent "${API_GATEWAY_URL}/usuarios"
