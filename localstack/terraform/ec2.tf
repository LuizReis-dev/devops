resource "aws_instance" "api_server" {
  ami                    = "ami-ff0fea8310f3"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.app_a.id
  vpc_security_group_ids = [aws_security_group.api.id]

  tags = {
    Name = var.server_name
  }
}
