# Time for me to create my ECS cluster and its services
resource "aws_ecs_cluster" "portfolio_cluster" {
  name = "portfolio-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    name        = "portfolio-cluster"
    Project     = "my_portfolio"
    Environment = "dev"
  }
}

# Task definition
resource "aws_ecs_task_definition" "portfolio_task" {
  family                   = "portfolio-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "portfolio-container"
      image     = "194722436853.dkr.ecr.eu-central-1.amazonaws.com/my_portfolio:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  tags = {
    Name = "portfolio-task"
  }
}

# ECS Service
resource "aws_ecs_service" "portfolio_service" {
  name            = "portfolio-service"
  cluster         = aws_ecs_cluster.portfolio_cluster.id
  task_definition = aws_ecs_task_definition.portfolio_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
    security_groups  = [aws_security_group.ecs_tasks_sg.id]
    assign_public_ip = true
  }

  tags = {
    Name = "portfolio-service"
  }
}
