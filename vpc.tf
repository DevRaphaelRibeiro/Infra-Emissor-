### Create VPC

resource "aws_vpc" "vpc-emissor" {
  cidr_block           = "172.25.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = "vpc-teste"
  }
}

### Create Subnet

resource "aws_subnet" "subnet-emissor" {
  vpc_id                  = aws_vpc.vpc-emissor.id
  cidr_block              = "172.25.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.AWS_REGION_AZ_WEB_1

  tags = {
    Name = "subnet-emissor"
  }
}

### SG for Emissor - subnet public
resource "aws_security_group" "acesso-remoto" {
  name        = "acesso-remoto"
  description = "Allow webservers"
  vpc_id      = aws_vpc.vpc-emissor.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    # TLS (change to whatever ports you need)
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]

  }
}

### Create Internet Nat Gateway
resource "aws_internet_gateway" "emissor-igw" {
  vpc_id = aws_vpc.vpc-emissor.id

  tags = {
    Name = "emissor-igw"
  }
}

### Creating custom routes for public subnets
resource "aws_route_table" "prod-public-crt" {
  vpc_id = aws_vpc.vpc-emissor.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.emissor-igw.id
  }
}

### Create Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "prod-elastic-ip-crt"
  }
}

### NAT Gateway Creation
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet-emissor.id
  depends_on    = [aws_internet_gateway.emissor-igw]
  tags = {
    Name = "prod-nat-gateway-crt"
  }
}
### Define Route
resource "aws_main_route_table_association" "IN8-route" {
  vpc_id         = aws_vpc.vpc-emissor.id
  route_table_id = aws_route_table.prod-public-crt.id
}