# Create a network called york-net
resource "google_compute_network" "yorknet" {
    name = "yorknet"
    auto_create_subnetworks = true

} 

# Configure Firewall rule
resource "google_compute_firewall" "yorknet-allow-http-ssh-rdp-icmp" {
    name = "yorknet-allow-http-ssh-rdp-icmp"
    network = google_compute_network.yorknet.self_link
    allow{
        protocol = "tcp"
        ports = ["80", "443", "22", "3389"]
    }
    allow{
        protocol = "icmp"
    }
    
}

# Create an instance in Montreal
module "yorknet-canada-vm" {
    source = "./instance"
    instance_name = "yorknet-eu-vm"
    instance_zone = "northamerica-northeast1-a"
    instance_network = google_compute_network.yorknet.self_link
}
# Create an instance in Europe
module "yorknet-eu-vm" {
    source = "./instance"
    instance_name = "yorknet-eu-vm"
    instance_zone = "eu-west1-d"
    instance_network = google_compute_network.yorknet.self_link
    instance_type = "f1-micro"
}
