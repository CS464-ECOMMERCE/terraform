// Allow Terraform to manage resources and perform operations
provider "google" {
  credentials = file("~/.gcp/access.json")
  project     = var.gcp_project_id
  region      = var.gcp_region
}

provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
        ## To be changed if using cloud
        config_context  = "gke_cs464-ecommerce_asia-southeast1-a_cluster-1"
        // config_context  = "minikube"
    }
}
