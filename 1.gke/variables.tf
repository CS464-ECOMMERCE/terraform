variable "gcp_project_id" {
    type = string
    description = "The GCP Project ID"
}

variable "gcp_region" {
    type = string
    description = "The GCP region in which to deploy"
}

variable "cluster_name" {
    type = string
    description = "K8s Cluster Name"
}
