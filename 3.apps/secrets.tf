resource "kubernetes_secret" "env-secret" {
  metadata {
    name = "app-secrets"
    annotations = {
      "reflector.v1.k8s.emberstack.com/reflection-allowed"      = true
      "reflector.v1.k8s.emberstack.com/reflection-auto-enabled" = true
    }
  }

  type = "Opaque"

  data = {
      ".env" = <<EOT
${trimspace(file(".env"))}
APP_BUCKET_NAME=${var.app_bucket_name}
APP_BUCKET_KEY=${trimspace(file("backend-sa-key.json"))}
EOT
  }
  depends_on = [argocd_application.reflector, local_file.backend-account-key-file]
}
