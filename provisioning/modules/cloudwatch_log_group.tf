resource "aws_cloudwatch_log_group" "log_group" {
  name = "expd/${var.app_name}"
}
