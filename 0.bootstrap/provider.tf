// Allow Terraform to manage resources and perform operations
provider "google" {
  credentials = file("~/.gcp/access.json")
  project     = var.gcp_project_id
  region      = var.gcp_region
}
