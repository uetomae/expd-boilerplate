variable "app_name" {}
variable "region" {}

resource "aws_subnet" "public_a" {
  availability_zone = "${var.region}a"
  cidr_block        = "${cidrsubnet(${aws_vpc.expd.cidr_block}, 8, 1)}"
  vpc_id            = "${aws_vpc.expd.id}"
  tags = {
    Name    = "expd-${var.app_name}-subnet-public-a"
    Product = "${var.app_name}"
  }
}

resource "aws_subnet" "public_c" {
  availability_zone = "${var.region}c"
  cidr_block        = "${cidrsubnet(${aws_vpc.expd.cidr_block}, 8, 2)}"
  vpc_id            = "${aws_vpc.expd.id}"
  tags = {
    Name    = "expd-${var.app_name}-subnet-public-c"
    Product = "${var.name}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.expd.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags = {
    Name    = "expd-${var.app_name}-public-rt"
    Product = "${var.app_name}"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id = "${aws_subnet.public_a.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public_c" {
  subnet_id = "${aws_subnet.public_c.id}"
  route_table_id = "${aws_route_table.public.id}"
}
