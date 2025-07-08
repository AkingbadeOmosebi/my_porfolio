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
