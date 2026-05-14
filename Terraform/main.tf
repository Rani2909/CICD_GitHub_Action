resource "aws_instance" "devops_server" {
  ami = "ami-05ffe3c48a9991133"
  instance_type = "t3.micro"

  key_name = aws_key_pair.generated_key.key_name

  vpc_security_group_ids = [
    aws_security_group.devops_sg.id
  ]

  tags = {
    Name = "DevOps-Server"
  }
}