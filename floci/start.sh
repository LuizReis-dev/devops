#!/bin/bash
set -e

docker compose up -d --wait

cd terraform
terraform init -input=false -upgrade
terraform apply -auto-approve

EC2_IP=$(terraform output -raw instance_public_ip)
SSH_KEY=$(terraform output -raw private_key_path)
RDS_ENDPOINT=$(terraform output -raw rds_endpoint)
API_GATEWAY_URL=$(terraform output -raw api_gateway_url)
cd ..

RDS_HOST=${RDS_ENDPOINT%%:*}
RDS_PORT=${RDS_ENDPOINT##*:}

until ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -i "$SSH_KEY" root@"$EC2_IP" "echo ok" 2>/dev/null; do
  sleep 10
done

cat > ansible/hosts.ini <<EOF
[api_server]
${EC2_IP}

[api_server:vars]
ansible_user=root
ansible_ssh_private_key_file=${SSH_KEY}
ansible_ssh_extra_args=-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
EOF

ansible-playbook -i ansible/hosts.ini ansible/deploy.yaml \
  -e "db_host=${RDS_HOST} db_port=${RDS_PORT}"

echo "RDS: ${RDS_ENDPOINT}"
echo "API direta: http://${EC2_IP}:3000"
echo "API Gateway: ${API_GATEWAY_URL}"
curl --fail --silent "http://${EC2_IP}:3000/health"
curl --fail --silent "${API_GATEWAY_URL}/usuarios"
