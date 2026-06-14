resource "aws_instance" "api_server" {
  ami           = "ami-ff0fea8310f3"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.app_key.key_name

  tags = {
    Name = "hello-world-api"
  }
}
