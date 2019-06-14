resource "aws_ecr_repository" "app" {
  name = "expd-${var.app_name}"
}

resource "aws_ecr_lifecycle_policy" "app" {
  repository = "${aws_ecr_repository.app.name}"
  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last 2 images for production",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["production"],
        "countType": "imageCountMoreThan",
        "countNumber": 2
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Expire images older than one day",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["tmp"],
        "countType": "sinceImagePushed",
        "countUnit": "days",
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
