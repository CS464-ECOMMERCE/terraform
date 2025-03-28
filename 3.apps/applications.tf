# Reflector for secrets replication
resource "argocd_application" "reflector" {
  metadata {
    name      = "reflector"
    namespace = "argocd"
  }

  spec {
    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }

    source {
      repo_url        = "https://emberstack.github.io/helm-charts"
      chart           = "reflector"
      target_revision = "7.1.210"
      helm {
        release_name = "reflector"
      }
    }

    sync_policy {
      automated {
        prune     = true
        self_heal = true
      }

      retry {
        limit = "5"
        backoff {
          duration     = "30s"
          max_duration = "2m"
          factor       = "2"
        }
      }
    }
  }
}


# Deploy all apps
resource "argocd_application" "apps" {
  for_each = argocd_repository.private
  metadata {
    name      = each.value.name
    namespace = "argocd"
  }

  spec {
    destination {
        server    = "https://kubernetes.default.svc"
        namespace = "apps"
    }

    source {
      repo_url = each.value.repo
      path     = "helm"
    }


    sync_policy {
      automated {
        prune     = true
        self_heal = true
      }
      sync_options = ["CreateNamespace=true"]

      retry {
        limit = "10"
        backoff {
          duration     = "2m"
          max_duration = "3m"
          factor       = "2"
        }
      }
    }
  }
  depends_on = [argocd_repository.private]
}
