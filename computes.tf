
resource "google_compute_instance" "tf-instances"{
    for_each = var.instances
    name = each.key
    machine_type = each.value
    zone = var.zone
    tags= [each.key]  #this can be used if we want to implement instance level firewall
     boot_disk {
      initialize_params {
        image= data.google_compute_image.ubuntu_image.self_link
        #image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240229"
        size  = 30
        type  = "pd-balanced"
    }
     
   }
   network_interface {
    #network= google_compute_network.tf_my_vpc.self_link
    subnetwork = google_compute_subnetwork.hms-subnet.self_link
    access_config{

    }
}
connection {
  type = "ssh"
  user = "reddyreddy3856"
  host = self.network_interface[0].access_config[0].nat_ip
  private_key = file("ssh-keys")
  
}
provisioner "file" {
   #if machine name is ansible then execute ansible.sh
   #if machine name is not ansible the execute empty.sh
  source = each.key == "ansible" ? "ansible.sh" : "empty.sh"

   #if ,machine name is ansible then  the copy ansible.sh into /home/reddyreddy3856 (reddyreddy3856 is the user in my gcp instances)
   #if ,machine name is not ansible then the copy empty.sh into /home/reddyreddy3856 (reddyreddy3856 is the user in my gcp instances)
  destination = each.key == "ansible" ? "/home/reddyreddy3856/ansible.sh" :  "/home/reddyreddy3856/empty.sh" 
}

provisioner "remote-exec" {
  inline = [ each.key == "ansible" ? "chmod +x /home/reddyreddy3856/ansible.sh && sh /home/reddyreddy3856/ansible.sh" : "echo skip the command"]
  
}

provisioner "file" {
  source= "ssh-keys"
  destination = "/home/reddyreddy3856/ssh-keys"
  
}

}


data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-2004-lts"
  project ="ubuntu-os-cloud"
}



