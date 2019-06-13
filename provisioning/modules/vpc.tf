resource "aws_vpc" "expd" {
  cidr_block = "172.31.1.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostname = "true"
  tags = {
    Name    = "expd-${var.app_name}-vpc"
    Product = "${var.app_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.expd.id}"
}
