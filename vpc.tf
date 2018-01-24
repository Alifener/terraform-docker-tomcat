# Internet VPC
resource "aws_vpc" "umg" {
  cidr_block           = "10.1.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "umg"
  }
}

# Subnets
resource "aws_subnet" "umg_public_a" {
  vpc_id                  = "${aws_vpc.umg.id}"
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}a"

  tags {
    Name = "umg_public_a"
  }
}

resource "aws_subnet" "umg_public_b" {
  vpc_id                  = "${aws_vpc.umg.id}"
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}b"

  tags {
    Name = "umg_public_b"
  }
}

# Internet GW
resource "aws_internet_gateway" "umg_gw" {
  vpc_id = "${aws_vpc.umg.id}"

  tags {
    Name = "umg_gw"
  }
}

# route tables
resource "aws_route_table" "umg_public_route" {
  vpc_id = "${aws_vpc.umg.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.umg_gw.id}"
  }

  tags {
    Name = "umg_public_route"
  }
}

# route associations public
resource "aws_route_table_association" "umg_public_a" {
  subnet_id      = "${aws_subnet.umg_public_a.id}"
  route_table_id = "${aws_route_table.umg_public_route.id}"
}
