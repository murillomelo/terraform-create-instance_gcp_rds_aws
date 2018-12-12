// create vpc
resource "google_compute_network" "vpc" {
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = "false"
  
}
// create subnets
resource "google_compute_subnetwork" "subnet" {
    name            = "${var.name}-subnet"
    ip_cidr_range   = "192.168.21.0/24"
    network         = "${var.name}-vpc"
    depends_on      = ["google_compute_network.vpc"]
    region          = "${var.region}"
  
}

// firewall
resource "google_compute_firewall" "fw" {
    name    = "${var.name}-fw"
    network = "${google_compute_network.vpc.name}"


  allow {
    protocol = "tcp"
    ports    = ["22","80","443"]
  }

  source_ranges = ["0.0.0.0/0"]
}