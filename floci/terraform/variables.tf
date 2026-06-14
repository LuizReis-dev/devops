variable "db_name" {
  description = "Nome do banco PostgreSQL"
  type        = string
  default     = "floci_db"
}

variable "db_user" {
  description = "Usuario do banco PostgreSQL"
  type        = string
  default     = "floci_user"
}

variable "db_password" {
  description = "Senha do banco no ambiente local"
  type        = string
  sensitive   = true
  default     = "floci_password"
}
