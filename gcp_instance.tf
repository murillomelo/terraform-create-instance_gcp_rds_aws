provider "google" {
  credentials = "${file("cretendials.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}


resource "google_compute_instance" "instance" {
    name            = "${var.name}-instance"
    machine_type    = "${var.machine_type}"
    zone            = "${var.zone}"
    tags            = ["training","lab"]
    
    
    
    boot_disk {
        initialize_params {
            image = "${var.image}"
            size  = "15"
            type  = "pd-ssd"
        }
    }

    network_interface {
       // network = "${google_compute_network.vpc.id}"
        subnetwork = "${google_compute_subnetwork.subnet.id}"
        access_config {}
    }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y apache2",
      "sudo apt-get install -y postgresql",
      "sudo apt-get install -y php",
      "sudo apt-get install -y telnet"
    ]

    connection {
      type        = "ssh"
      user        = "murillomelo"
      private_key = "${file("your_id_rsa")}"
      agent       = true
      timeout     = "1m"
  }
  }

}
