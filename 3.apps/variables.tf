variable "gcp_project_id" {
    type = string
    description = "The GCP Project ID"
}

variable "gcp_region" {
    type = string
    description = "The GCP region in which to deploy"
}

variable "repo_list" {
    type = list(any)
}

variable "argocd_server_url" {
    type = string
    description = "ArgoCD Server URL Link"
}

variable "argocd_password" {
    type = string
    description = "Secret"
}
