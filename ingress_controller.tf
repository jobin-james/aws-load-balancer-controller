resource "helm_release" "lb_controller" {
  depends_on = [kubernetes_service_account.lb_controller]

  repository      = var.repository
  chart           = var.controller_name
  name            = var.controller_name
  version         = var.aws_lb_controller_helm_version
  cleanup_on_fail = var.cleanup_on_fail
  namespace       = var.namespace

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
  set {
    name  = "serviceAccount.create"
    value = false
  }
  set {
    name  = "serviceAccount.name"
    value = var.controller_name
  }
}