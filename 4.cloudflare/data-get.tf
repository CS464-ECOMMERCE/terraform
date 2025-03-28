data "kubernetes_service" "traefik" {
    metadata {
        name        = "traefik"
        namespace   = "apps"
    }
}
