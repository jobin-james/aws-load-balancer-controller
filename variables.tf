
variable "cluster_name" {
  default     = ""
  description = "cluster name"
}

variable "controller_name" {
  default     = "aws-load-balancer-controller"
  description = "Name of aws load balancer controller"
}

variable "namespace" {
  default     = "kube-system"
  description = "aws load balancer controller namespace"
}

variable "repository" {
  default     = "https://aws.github.io/eks-charts"
  description = "load balancer controller helm chart repository"
}

variable "aws_lb_controller_helm_version" {
  default     = "1.1.1"
  description = "Hem chart version https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller"
}

variable "cleanup_on_fail" {
  default     = true
  description = "Cleanup helm install if the helm release command is fail"
}

variable "enable_oidc_provider" {
  default     = true
  description = "Decide to create oidc provider with  this module"
}

variable "oidc_provider_url" {
  default     = ""
  description = "This is mandatory if enable_oidc_provider is set to false"
}

variable "oidc_provider_arn" {
  default     = ""
  description = "This is mandatory if enable_oidc_provider is set to false"
}