resource "aws_instance" "P03-Emissor1" {
  instance_type = "t2.micro"
  ami           = "ami-0e66f5495b4efdd0f"
  key_name      = "key01"

  ### Atribuir Security Group
  vpc_security_group_ids = [aws_security_group.acesso-remoto.id]
  availability_zone      = var.AWS_REGION_AZ_emissor

  subnet_id = aws_subnet.subnet-emissor.id
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "P03-Emissor"

  }

}


