output "instance_id" {
  value = aws_instance.api_server.id
}

output "rds_endpoint" {
  value = aws_db_instance.app.endpoint
}

output "rds_port" {
  value = aws_db_instance.app.port
}

output "api_gateway_url" {
  value = "http://localhost:4566/restapis/${aws_api_gateway_rest_api.app.id}/${aws_api_gateway_stage.dev.stage_name}/_user_request_"
}

output "vpc_id" {
  value = aws_vpc.app.id
}
