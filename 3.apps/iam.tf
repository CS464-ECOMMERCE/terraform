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

resource "google_service_account_key" "backend_account_key" {
  service_account_id = google_service_account.backend-account.name
}

# Output the key file path
output "backend_account_key_file" {
  value     = "backend-sa-key.json"
  sensitive = true
}

# Save the key to a local file
resource "local_file" "backend_account_key_file" {
  content  = base64decode(google_service_account_key.backend_account_key.private_key)
  filename = "backend-sa-key.json"
}
