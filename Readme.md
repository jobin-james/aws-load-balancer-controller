AWS Load balancer controller - Kubernetes Ingress controller
----

### Prerequisites

- Kubernetes 1.9+ for ALB, 1.20+ for NLB IP mode, or EKS 1.18
- IAM permissions 
    - The controller runs on the worker nodes, so it needs access to the AWS ALB/NLB resources via IAM permissions.

### Introduction
- Support for both Application Load Balancers and Network Load Balancers.
- With AWS load balancer controller, sharing an Application Load Balancer across multiple pods in a Kubernetes cluster is possible. 
This can be achieved by passing the annotation `alb.ingress.kubernetes.io/group.name: <name>`to ingress resource.
  
- First ingress resource created in a cluster will create an ALB/NLB.

### Dependencies
- This module will install only the necessary resources for ingress controller. It won't create any ALB/NLB.
- CRD must be installed manually.
- Terraform Kubernetes provider

### Provider configuration

```hcl

provider "kubernetes" {
  load_config_file       = "false"
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}
```

### Example usage

With IAM role and cluster oidc. 
```hcl

module "aws_loadbalancer_controller" {
  source                          = "..modules/aws-load-balancer-controller"
  cluster_name                    = "my-cluster"
  environment                     = var.environment
  aws_lb_controller_helm_version  = "1.1.3"
  namespace                       = "kube-system"
}
```

Use an existing oidc provider

```hcl

module "aws_loadbalancer_controller" {
  source                          = "..modules/aws-load-balancer-controller"
  cluster_name                    = "${var.ou}-${var.environment}-${var.function}"
  environment                     = var.environment
  aws_alb_controller_helm_version = "1.1.3"
  enable_oidc_provider            = false
  oidc_provider_url               = aws_iam_openid_connect_provider.cluster.url
  oidc_provider_arn               = aws_iam_openid_connect_provider.cluster.arn
  namespace                       = "kube-system"
}
```
