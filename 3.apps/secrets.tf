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
EOT
        "backend-sa-key.json" = file("backend-sa-key.json")
  }
  depends_on = [argocd_application.reflector, local_file.backend-account-key-file]
}

resource "kubernetes_secret" "tls-cert" {
  metadata {
    name = "tls-cert"
    annotations = {
      "reflector.v1.k8s.emberstack.com/reflection-allowed"      = true
      "reflector.v1.k8s.emberstack.com/reflection-auto-enabled" = true
    }
  }

  type = "kubernetes.io/tls"

  data = {
    "tls.crt" = file("tls.crt")
    "tls.key" = file("tls.key")
  }
  depends_on = [argocd_application.reflector]
}
