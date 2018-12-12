output "public_ip_gcp" {
   value = ["${google_compute_instance.instance.*.network_interface.0.access_config.0.assigned_nat_ip}"]
}

output "rds_endpoint" {
  value = "${aws_db_instance.rds-deployer.endpoint}"
}
