terraform {
  backend "gcs" {
    bucket  = "terraform-backend-6686"
    prefix  = "terraform/terraform.tfstate"
    credentials = "terraform.json"
  }
}