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

  # Allowin My_portfolio application port (This one can be adjust as needed, for example if u map your container to 3000, then 3000 it is).
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Application port"
  }

  #will Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = {
    Name        = "ecs-tasks-sg"
    Project     = "my_portfolio"
    Environment = "dev"
  }
}

# My ECR repository for my_portfolio project
resource "aws_ecr_repository" "my_portfolio" {
  name                 = "my_portfolio"
  image_tag_mutability = "MUTABLE" # or "IMMUTABLE" based on your requirement
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "my-portfolio-ecr"
    Project     = "my_portfolio"
    Environment = "dev"
  }
}

# My ECR lifecycle policy, policy to keep only the one or the latest image and delete any other.
resource "aws_ecr_lifecycle_policy" "my_portfolio_ecr_policy" {
  repository = aws_ecr_repository.my_portfolio.name

  policy = <<EOF
{
    "rules": [
         {
      "rulePriority": 1,
      "description": "Expire untagged images",
      "selection": {
        "tagStatus": "untagged",
        "countType": "imageCountMoreThan",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    },
        {
            "rulePriority": 2,
            "description": "Keep only 1 image max",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 1
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}


# Time for me to crreate my ECS cluster and its services
resource "aws_ecs_cluster" "portfolio_cluster" {
  name = "portfolio-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    name = "portfolio-cluster"
    Project     = "my_portfolio"
    Environment = "dev"
  }
}


# So, i need two things, aws_iam_role and aws_iam_role_policy_attachment for my ECS task execution role.

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"
  assume_role_policy = jsonencode({    # Terraform's "jsonencode" function converts a Terraform expression result to valid JSON syntax. you can get moore of this templates on terraform registry docs site like i did here.
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"       # You must specific the service type!!! This is the service that will assume this role, in my case, it is the ECS tasks. Read more on it.
        }
      },
    ]
  })

  tags = {
    name = "ecs-task-execution-role"
  }
}
