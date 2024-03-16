

# resource "google_compute_network" "tf_my_vpc" {
#   name = var.vpc-network
#   auto_create_subnetworks = false
# }

# resource "google_compute_subnetwork" "tf_my_subnet"{
#     name ="custome-subnet"
#     ip_cidr_range="10.0.1.0/24"
#     network = google_compute_network.tf_my_vpc.id
# }

#Creating a Custom VPC
resource "google_compute_network" "hms-vpc" {
    name = var.vpc-network
    auto_create_subnetworks = "false"  #Default is true, if it set TRUE then a subent is created ineach availeble zone.connection {
}
#Creating subnet 
resource "google_compute_subnetwork" "hms-subnet" {
    name = var.vpc-subnetwork
    ip_cidr_range = var.ip_cidr_range
    network = google_compute_network.hms-vpc.self_link
    region =  var.region
  }

   #creating a firewall rule for ssh

  resource "google_compute_firewall" "allow-ssh" {
    name = "allow"
    network = google_compute_network.hms-vpc.self_link

    dynamic "allow" {
      for_each = var.ports
      content{
        protocol = "tcp"
        ports = [allow.value]
      }
      
    }
    source_ranges = ["0.0.0.0/0"]
  }