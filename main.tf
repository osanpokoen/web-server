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

# IAM User used by CircleCI
resource "aws_iam_user" "default" {
  name = "circleci_web-server"
}

resource "aws_iam_policy" "default" {
  name = "circleci_web-server"

  policy = <<-POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "ecr:GetAuthorizationToken"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ecr:BatchCheckLayerAvailability",
                    "ecr:CompleteLayerUpload",
                    "ecr:InitiateLayerUpload",
                    "ecr:PutImage",
                    "ecr:UploadLayerPart"
                ],
                "Resource": "${aws_ecr_repository.default.arn}"
            }
        ]
    }
    POLICY
}

resource "aws_iam_user_policy_attachment" "default" {
  user       = aws_iam_user.default.name
  policy_arn = aws_iam_policy.default.arn
}
