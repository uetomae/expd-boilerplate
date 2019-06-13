variable "app_name" {}
variable "db_user" {}
variable "db_pass" {}

resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "${var.app_name}-rds-subnet-group"
  subnet_ids = ["${aws_subnet.public_a.id}", "${aws_subnet.public_c.id}"]
}

resource "aws_db_instance" "default" {
  identifier           = "expd-${var.app_name}-db"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.2.21"
  instance_class       = "db.t3.micro"
  name                 = "${var.app_name}"
  username             = "${var.db_user}"
  password             = "${var.db_pass}"
  parameter_group_name = "${aws_db_parameter_group.default.name}"
  db_subnet_group_name = "${aws_db_subnet_group.rds-subnet-group.name}"
  multi_az             = false
  backup_retention_period    = "7"
  apply_immediately          = true
  auto_minor_version_upgrade = true
  vpc_security_group_ids     = ["${aws_security_group.db.id}"]
}

resource "aws_db_parameter_group" "default" {
  name   = "expd-${var.app_name}-dbpg"
  family = "mariadb10.2"

  parameter {
    name  = "collation_server"
    value = "utf8mb4_general_ci"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "init_connect"
    value = "set names utf8mb4"
  }

  parameter {
    name  = "innodb_file_format"
    value = "barracuda"
  }

  parameter {
    name  = "innodb_file_per_table"
    value = "1"
  }

  parameter {
    name  = "innodb_large_prefix"
    value = "1"
  }
}
