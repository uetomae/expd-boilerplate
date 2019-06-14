output "deploy-env" {
  value = {
    target_group   = "${aws_alb_target_group.alb.arn}"
    cluster_name   = "${aws_ecs_cluster.ecs_cluster.name}"
    container      = "expd-${var.app_name}-app"
    subnet1        = "${aws_subnet.public_a.id}"
    subnet2        = "${aws_subnet.public_c.id}"
    security_group = "${aws_security_group.ecs.id}"
    db_host        = "${aws_db_instance.default.address}"
    db_name        = "${var.app_name}_production"
    db_user        = "${var.db_user}"
    db_password    = "${var.db_pass}"
    log_group      = "${aws_cloudwatch_log_group.log_group.name}"
  }
}
