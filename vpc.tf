# My VPC network
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name        = "my-vpc"
    Project     = "my_portfolio"
    Environment = "dev"
  }
}

# My 3 subnets
resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a" # my zone a subnet

  tags = {
    Name        = "subnet-1a"
    Project     = "my_portfolio"
    Environment = "dev"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b" # my zone b subnet

  tags = {
    Name        = "subnet-1b"
    Project     = "my_portfolio"
    Environment = "dev"
  }
}

resource "aws_subnet" "subnet-3" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-central-1c" # my zone c subnet

  tags = {
    Name        = "subnet-1c"
    Project     = "my_portfolio"
    Environment = "dev"
  }
}

#My route table, so that my subnets can atleast access the internet
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name        = "my-route-table"
    Project     = "my_portfolio"
    Environment = "dev"
  }
}

# my subnet associations to the route table, selecting the subnets i want to have access to the internet. 
resource "aws_route_table_association" "subnet_associations" {
  count          = 3
  subnet_id      = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id, aws_subnet.subnet-3.id][count.index]
  route_table_id = aws_route_table.my_route_table.id
}

# Myy internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name        = "my-igw"
    Project     = "my_portfolio"
    Environment = "dev"
  }
}