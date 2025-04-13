resource "argocd_repository" "private" {
    repo            = var.chart_repo
    name            = "ecommerce"
    ssh_private_key = file("gh.key")
    insecure        = false
    depends_on      = [kubernetes_secret.env-secret]
}
