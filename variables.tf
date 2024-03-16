variable "project_id"{
    default="terraform-project-415517"

}

variable "region"{
    default="us-central1"
}
variable "vpc-network" {
    default ="custome-vpc-network"
  
}
variable "vpc-subnetwork" {
    default ="vpc-subnetwork"
}

variable "ip_cidr_range"{
    default="10.0.1.0/24"
}



variable "zone" {
    default="us-central1-a"
  
}

variable instances{
    default = {
        "jenkins-master" = "e2-medium"
        "jenkins-slave" = "e2-medium"
        "sonar" = "e2-medium"
        "ansible" ="e2-medium"
    }

}

variable "ports" {
    default = [22, 8080, 8081, 9000 ]
  
}

