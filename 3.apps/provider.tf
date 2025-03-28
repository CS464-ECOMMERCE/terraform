// Allow Terraform to manage resources and perform operations
provider "google" {
  credentials = file("~/.gcp/access.json")
  project     = var.gcp_project_id
  region      = var.gcp_region
}

terraform {
    required_providers {
        argocd = {
            source  = "oboukili/argocd"
            version = "6.0.3"
        }
    }
}

provider "argocd" {
    server_addr = var.argocd_server_url
    username    = "admin"
    password    = var.argocd_password
    insecure    = false
}

provider "kubernetes" {
    config_path     = "~/.kube/config"
    ## To be changed if using cloud
    config_context  = "gke_cs464-ecommerce_asia-southeast1-a_cs464-cluster"
    // config_context  = "minikube"
}
