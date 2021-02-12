resource "kubernetes_cluster_role_binding" "lb_controller" {
  metadata {
    name = var.controller_name
    labels = {
      "app.kubernetes.io/name" = var.controller_name
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.lb_controller.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_cluster_role.lb_controller.metadata[0].name
    namespace = kubernetes_service_account.lb_controller.metadata[0].namespace
  }
  depends_on = [kubernetes_cluster_role.lb_controller]
}