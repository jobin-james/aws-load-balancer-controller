resource "kubernetes_cluster_role" "lb_controller" {
  metadata {
    name = var.controller_name
    labels = {
      "app.kubernetes.io/name" = var.controller_name
    }
  }
  rule {
    api_groups = ["", "extensions"]
    resources  = ["configmaps", "endpoints", "events", "ingresses", "ingresses/status", "services", "pods/status"]
    verbs      = ["create", "get", "list", "update", "watch", "patch"]
  }

  rule {
    api_groups = ["", "extensions"]
    resources  = ["nodes", "pods", "secrets", "services", "namespaces"]
    verbs      = ["get", "list", "watch"]
  }
}