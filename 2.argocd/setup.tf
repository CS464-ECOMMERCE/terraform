resource "helm_release" "argocd" {
    name                = "argocd"
    repository          = "https://argoproj.github.io/argo-helm"
    chart               = "argo-cd"
    namespace           = "argocd"
    create_namespace    = true
    values              = [file("argocd.yaml")]
}

data "helm_template" "argocd_instance" {
    name            = "argocd"
    namespace       = "argocd"
    repository      = "https://argoproj.github.io/argo-helm"
    kube_version    = "1.31.6"
    chart           = "argo-cd"
    version         = helm_release.argocd.version
}

output "argocd_notes" {
    value = data.helm_template.argocd_instance.notes
}
