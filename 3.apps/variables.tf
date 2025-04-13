variable "gcp_project_id" {
    type = string
    description = "The GCP Project ID"
}

variable "gcp_region" {
    type = string
    description = "The GCP region in which to deploy"
}

variable "chart_repo" {
    type = string
    description = "The Git repository URL for the Helm charts"
}

variable "app_list" {
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

variable "app_bucket_name" {
    type = string
    description = "App Bucket Name"
}
