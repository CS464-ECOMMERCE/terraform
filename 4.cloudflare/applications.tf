// Adds DNS record to Cloudflare
resource "cloudflare_dns_record" "traefik" {
    zone_id     = var.cloudflare_zone_id
    name        = "api"
    type        = "A"
    content     = lookup(data.kubernetes_service.traefik.status[0].load_balancer[0].ingress[0], "ip", null)
    ttl         = 1
    proxied     = true
}
