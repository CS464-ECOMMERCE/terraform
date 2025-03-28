// Create GKE Standard Cluster

resource "google_container_cluster" "my_cluster" {
  name                = var.cluster_name  
  location            = var.gcp_region    
  deletion_protection = true

  remove_default_node_pool = true  # Remove default node pool
  initial_node_count       = 1     # This is required, but ignored if remove_default_node_pool is true
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  cluster    = google_container_cluster.my_cluster.id
  location   = var.gcp_region
  node_count = 4  # Set to 4 nodes

  node_config {
    service_account = "terraform-service-account@cs464-ecommerce.iam.gserviceaccount.com" //service account to be used by nodes in the GKE cluster
    machine_type    = "e2-medium"
    preemptible     = false  # Change to true if you want cheaper, short-lived nodes
    disk_size_gb = 20
  }
}

output "cluster_endpoint" {
    value = google_container_cluster.my_cluster.endpoint
}
