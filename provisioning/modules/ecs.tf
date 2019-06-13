variable "app_name" {}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "expd-${var.app_name}"
}
