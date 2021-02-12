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
