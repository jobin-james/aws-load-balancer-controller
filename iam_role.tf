data "external" "oidc_thumbprint" {
  program = ["scripts/eks-oidc-thumbprint.sh", var.aws_region]
}

resource "aws_iam_openid_connect_provider" "cluster" {
  count = var.enable_oidc_provider ? 1 : 0

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.external.oidc_thumbprint.result.value]
  url             = data.aws_eks_cluster.cluster.identity.0.oidc.0.issuer
}

data "aws_iam_policy_document" "cluster" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.oidc_provider_url != "" ? var.oidc_provider_url : aws_iam_openid_connect_provider.cluster[0].url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.namespace}:${var.controller_name}"]
    }

    principals {
      identifiers = [var.oidc_provider_arn != "" ? var.oidc_provider_arn : aws_iam_openid_connect_provider.cluster[0].arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "lb_controller" {

  name               = "${var.ou}-${var.controller_name}"
  assume_role_policy = data.aws_iam_policy_document.cluster.json
}