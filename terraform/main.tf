# My VPC network
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

}

# My 3 subnets
resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a" # my zone a subnet

}

resource "aws_subnet" "subnet-2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b" # my zone b subnet

}

resource "aws_subnet" "subnet-3" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-central-1c" # my zone c subnet

}

resource "aws_ecr_repository" "my_portfolio" {
  name                 = "my_portfolio"
  image_tag_mutability = "MUTABLE" # or "IMMUTABLE" based on your requirement
  image_scanning_configuration {
    scan_on_push = true
  }
}

# Myy internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}


# My Security group mainly for my ECS tasks
resource "aws_security_group" "ecs_tasks_sg" {
  name        = "ecs-tasks-security-group"
  description = "Security group for ECS tasks"
  vpc_id      = aws_vpc.my_vpc.id

  # SSH access (Just incase, i need it for debugging)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Normally, im supposed to restrict this range to my IP only as good practice, to enable only I or me to ssh into it, but i'll leave it open for now.
    description = "SSH access"
  }

  # Allow HTTP traffic (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  # Allow HTTPS traffic (port 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS access"
  }

  # Allow My_portfolio application port (This one can be adjust as needed, for example if u map your container to 3000, then 3000 it is).
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Application port"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = {
    Name = "ecs-tasks-sg"
  }
}

resource "aws_ecr_lifecycle_policy" "my_portfolio_ecr_policy" {
  repository = aws_ecr_repository.my_portfolio.name

  policy = jsonencode({
    rules = [
      {
        rule_priority = 1
        description   = "Keep only 1 image max"
        selection = {
          count_type   = "imageCountMoreThan"
          count_number = 1
          tag_status   = "any"
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}