
#provider block will download the required plugins and dependencies for given provider cloud.
provider "google" {

  credentials = file("terraform.json")
  #credentials = var.credentials
  project     = var.project_id
  region      = var.region
}