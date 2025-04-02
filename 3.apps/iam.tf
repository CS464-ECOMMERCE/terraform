resource "google_service_account" "backend-account" {
    account_id = "backend-account"
    display_name = "Service account for backend to interact with GCS"
}

data "google_iam_policy" "storage-admin" {
    binding {
        role = "roles/storage.admin"
        members = [
            "serviceAccount:${google_service_account.backend-account.email}",
            "projectOwner:cs464-ecommerce",
        ]
    }
}

resource "google_storage_bucket_iam_policy" "backend-iam-owner" {
    bucket   = var.app_bucket_name
    policy_data = data.google_iam_policy.storage-admin.policy_data
    depends_on = [google_storage_bucket.app-bucket]
}

# Grant public read access to all objects in the bucket
resource "google_storage_bucket_iam_member" "public_read" {
    bucket  = google_storage_bucket.app-bucket.name
    role    = "roles/storage.objectViewer"
    member  = "allUsers"
    depends_on = [google_storage_bucket.app-bucket]
}

resource "google_service_account_key" "backend-account-key" {
  service_account_id = google_service_account.backend-account.name
}

# Save the key to a local file
resource "local_file" "backend-account-key-file" {
  content  = base64decode(google_service_account_key.backend-account-key.private_key)
  filename = "backend-sa-key.json"
}

# Output the key file path
output "backend-account-key-file" {
  value     = "Secret key to access bucket exported to backend-sa-key.json"
  sensitive = true
}
