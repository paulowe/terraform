variable "instance_name" {}
variable "instance_zone" {}
variable "instance_type" {
  default = "n1-standard-1"
}
variable "instance_network" {}

resource "google_compute_instance" "gnl-vm" {
  name         = var.instance_name
  zone         = var.instance_zone
  machine_type = var.instance_type
  # Configure the boot disk to use the Debian 9 OS image.
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  # Define the VPC
  network_interface {
    network = var.instance_network
    access_config {
      # Allocate a one-to-one NAT IP to the instance  (Assign an ephemeral external IP)
    }
  }


}