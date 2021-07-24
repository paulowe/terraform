# Create a network called york-net
resource "google_compute_network" "york-net" {
    name = "york-net"
    auto_create_subnetworks = true

} 
