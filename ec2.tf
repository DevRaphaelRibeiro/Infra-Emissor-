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


/*resource "aws_key_pair" "key001" {
  key_name   = "key001"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCv3Fm1DvodSFE31P3t7CHXUT2b3KzmSSEu0E6ORmfUU9Gst7C4YABboh2KtckjQCDnrxtrN/VS5mWOFiGNdp1Aq4kHXOy+n+8bIe4pc7qTRmL324SyfP7vDEcHXtyenvaMNXgNMJEmiPkdkAOAXSEBsZJzfieDwCoGlgQNTBJLfsO3vuvjOZX9d1Q8FWRpesx9MwR5qodvVG0QDL5FEcApI8MMmA66amVFIuSglFaNt9Tu4zi0m52tHrRk6VcVd/U1yV/aZgq3swQ6Zors00nenLyXzrJw/rlYWdWO2CiElA4Di7L5+gIKNSj9ZNA4ME/H/NxlOeHM5AukzJ4jtH0rFnEDrnipDNPnh2XyS2++x8waT5IzdV0o23cw1kLMwaTE36xZCEEUsZzMbAjCFST1zubL86ghqN+ERblR6KyhgMQmilxeRGLOw7qVG+NfYdPvW8fMir9W1JaVkwl3lBCsIyLk4SIC1dmjPWq1xI2GiOAYxu1wLduopilt9t+CYAU= rafae@DESKTOP-QT3IKI6"
}*/
/*resource "aws_instance" "P03-Emissor2" {
  instance_type = "t2.micro"
  ami           = "ami-07983613af1a3ef44"
  subnet_id = aws_subnet.subnet-teste.id
  

  tags = {
    Name = "P03-Emissor"

  }
  
}
resource "aws_instance" "P03-Emissor3" {
  instance_type = "t2.micro"
  ami           = "ami-07983613af1a3ef44"
  subnet_id = aws_subnet.subnet-teste.id
  

  tags = {
    Name = "P03-Emissor"

  }
  
}*/