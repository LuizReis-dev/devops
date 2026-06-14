resource "aws_db_instance" "app" {
  identifier          = "floci-rds"
  engine              = "postgres"
  engine_version      = "16"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  db_name             = var.db_name
  username            = var.db_user
  password            = var.db_password
  port                = 5432
  skip_final_snapshot = true

  tags = {
    Name = "floci-rds"
  }
}
