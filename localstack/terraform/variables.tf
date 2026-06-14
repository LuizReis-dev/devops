variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "server_name" {
  description = "Nome do servidor"
  type        = string
  default     = "api-server"
}

variable "db_name" {
  description = "Nome do banco PostgreSQL"
  type        = string
  default     = "dating_app"
}

variable "db_user" {
  description = "Usuario do banco PostgreSQL"
  type        = string
  default     = "app_user"
}

variable "db_password" {
  description = "Senha fixa do banco no ambiente local"
  type        = string
  sensitive   = true
  default     = "app_password"
}
