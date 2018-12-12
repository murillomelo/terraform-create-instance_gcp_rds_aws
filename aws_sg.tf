
resource "aws_vpc" "vpc-lab" {
  cidr_block          = "192.168.0.0/16"
  enable_dns_support    = true
  enable_dns_hostnames  = true
}

resource "aws_subnet" "subnet-one" {
    vpc_id               = "${aws_vpc.vpc-lab.id}"
    cidr_block           = "192.168.22.0/24"
    availability_zone    = "us-east-1a"
}

resource "aws_subnet" "subnet-two" {
    vpc_id               = "${aws_vpc.vpc-lab.id}"
    cidr_block           = "192.168.23.0/24"
    availability_zone    = "us-east-1b"
}
resource "aws_db_subnet_group" "subnet-group" {
    subnet_ids = ["${aws_subnet.subnet-one.id}", "${aws_subnet.subnet-two.id}"]

    tags{
        Name = "${var.name}-subnet-group"
    }
}

resource "aws_internet_gateway" "gw-lab" {
    vpc_id              = "${aws_vpc.vpc-lab.id}"  
}

resource "aws_route_table" "rt-lab" {
  vpc_id = "${aws_vpc.vpc-lab.id}"
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw-lab.id}"
        
    }
}

resource "aws_route_table_association" "rta" {
  subnet_id = "${aws_subnet.subnet-one.id}"
  route_table_id = "${aws_route_table.rt-lab.id}"
}

resource "aws_main_route_table_association" "tram" {
  vpc_id         = "${aws_vpc.vpc-lab.id}"
  route_table_id = "${aws_route_table.rt-lab.id}"
}

resource "aws_security_group" "sg-rds" {
  name = "${var.security_groups}"
  vpc_id = "${aws_vpc.vpc-lab.id}"
  description = "Allow all inbound traffic"
  ingress {
      from_port = 5432
      to_port = 5432
      protocol = "tcp"
      cidr_blocks = ["${google_compute_instance.instance.network_interface.0.access_config.0.assigned_nat_ip}/32"]
  }

  egress {
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}