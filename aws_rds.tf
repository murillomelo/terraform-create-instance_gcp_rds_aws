
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}

resource "aws_db_instance" "rds-deployer" {
  allocated_storage         = "${var.rds_allocated_storage}"
  storage_type              = "${var.rds_storage_type}"
  engine                    = "${var.rds_engine}"
  engine_version            = "${var.rds_engine_version}"
  instance_class            = "${var.instance_class}"
  name                      = "${var.name}"
  username                  = "${var.rds_username}"
  password                  = "${var.rds_password}"
  availability_zone         = "${var.rds_availability_zone}"
  identifier                = "${var.name}-rds"
  skip_final_snapshot       = true
  final_snapshot_identifier = "Ignore"
  //vpc_security_group_ids    = "${aws_security_group.sg-rds.id}"
  vpc_security_group_ids    = ["${aws_security_group.sg-rds.id}"]
  db_subnet_group_name      = "${aws_db_subnet_group.subnet-group.id}"
  backup_retention_period = 5
  publicly_accessible = true
  //preferred_backup_window = "03:00-04:00"
  //publicly_accessible = true

  tags {
      Name = "${var.name}"
      Environment = "${var.environment}"
  }
}
