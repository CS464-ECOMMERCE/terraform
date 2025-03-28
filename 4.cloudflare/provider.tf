provider "google" {
  credentials = file("~/.gcp/access.json")
  project     = var.gcp_project_id
  region      = var.gcp_region
}

terraform {
    required_providers {
        cloudflare = {
            source  = "cloudflare/cloudflare"
            version = "~> 5"
        }
    }
}

provider "cloudflare" {
    api_token = var.cloudflare_api_key
}

provider "kubernetes" {
    config_path     = "~/.kube/config"
    ## To be changed if using cloud
    config_context  = "gke_cs464-ecommerce_asia-southeast1-a_cluster-1"
    // config_context  = "minikube"
}
