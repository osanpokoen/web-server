provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_ecr_repository" "default" {
  name = "web-server"
}

resource "aws_ecr_lifecycle_policy" "default" {
  repository = aws_ecr_repository.default.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Discard untagged image"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 1
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
