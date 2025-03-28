// Managing storage and state of infrastructure deployments
terraform {
  backend "gcs" {
    bucket          = "tfstate-bucket-cs464-devops" // name of GCS bucket
    prefix          = "/gke/argocd/apps/terraform.tfstate" // path within GCS bucket where TF state file is stored
    credentials     = "~/.gcp/access.json"
  }
}
