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
  for_each = { for repo in var.repo_list: repo.name => repo }
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
      repo_url = var.repository_url
      path     = each.value.path
    }


    sync_policy {
      automated {
        prune     = true
        self_heal = true
      }
      sync_options = ["CreateNamespace=true"]

      retry {
        limit = "5"
        backoff {
          // duration     = "1m"
          // max_duration = "2m"
          factor       = "5"
        }
      }
    }
  }
  depends_on = [argocd_repository.private]
}
