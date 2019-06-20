resource "aws_security_group" "alb" {
  name   = "expd-${var.app_name}-alb-sg"
  vpc_id = "${aws_vpc.expd.id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "expd-${var.app_name}-alb-sg"
    Product = "${var.app_name}"
  }
}

resource "aws_security_group" "ecs" {
  name   = "expd-${var.app_name}-ecs-sg"
  vpc_id = "${aws_vpc.expd.id}"
  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    security_groups = [
      "${aws_security_group.alb.id}",
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "expd-${var.app_name}-ecs-sg"
    Product = "${var.app_name}"
  }
}

resource "aws_security_group" "db" {
  name   = "expd-${var.app_name}-db-sg"
  vpc_id = "${aws_vpc.expd.id}"
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    security_groups = [
      "${aws_security_group.ecs.id}",
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "expd-${var.app_name}-db-sg"
    Product = "${var.app_name}"
  }
}
