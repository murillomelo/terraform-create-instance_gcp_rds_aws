variable "name" {
  description = "rds-name"
  default = "rdstraining"
}
variable "environment" {
  description = "rds-env"
  default = "training"
}

variable "instance_class" {
    description = "rds-instance"
    default = "db.t2.micro"
}

variable "security_groups" {
    description = "rds-sg"
    default =  "training-sg"
    
}

variable "rds_username" {
  description = "rds-user"
  default = "master"
}
variable "rds_password" {
    description = "rds-pass"
    default = "M2Y5MGQxMTFjYTZjZjY1ZjMyNmU4MGVl"
  
}

variable "rds_allocated_storage" {
    description = "rds-disk-size"
    default = "10"
}

variable "rds_engine_version" {
    description = "rds-version"
    default = "10.4"
  
}

variable "rds_engine" {
    description = "rds-engine"
    default = "postgres"
  
}

variable "rds_storage_type" {
    description = "rds-type-storage"
    default = "gp2"
}

variable "rds_availability_zone" {
    description = "rds-zone"
    default = "us-east-1a"
  
}
variable "region" {
    default = "us-east1"
}
variable "project" {
    default = "training-224719"
  
}

variable "zone" {
    default = "us-east1-b"
}
variable "machine_type" {
  default = "n1-standard-1"
}

variable "image" {
    default = "debian-cloud/debian-9"
  
}