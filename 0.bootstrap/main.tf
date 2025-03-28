resource "google_storage_bucket" "state-bucket" {
    name = var.bucket_name
    location = var.gcp_region

    versioning {
        enabled = true
    }
}
