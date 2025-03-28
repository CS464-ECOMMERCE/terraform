resource "argocd_repository" "private" {
    repo            = var.repository_url
    name            = "cs464-k8s"
    ssh_private_key = file("gh.key")
    insecure        = false
    depends_on      = [kubernetes_secret.env-secret]
}
