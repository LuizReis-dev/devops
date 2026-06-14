output "instance_public_ip" {
  description = "IP da instancia EC2 criada pelo Floci"
  value       = aws_instance.api_server.public_ip
}

output "private_key_path" {
  description = "Caminho da chave SSH gerada"
  value       = local_sensitive_file.private_key.filename
}

output "rds_endpoint" {
  description = "Endpoint do banco PostgreSQL"
  value       = aws_db_instance.app.endpoint
}

output "rds_port" {
  description = "Porta do banco PostgreSQL"
  value       = aws_db_instance.app.port
}

output "api_gateway_url" {
  description = "URL do API Gateway do Floci"
  value       = "http://localhost:4566/restapis/${aws_api_gateway_rest_api.app.id}/${aws_api_gateway_stage.dev.stage_name}/_user_request_"
}
