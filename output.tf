output "oidc_thumbprint" {
  value       = var.oidc_provider_url != "" ? "" : data.external.oidc_thumbprint.result.value
  description = "oidc thump print value"
}

output "oidc_url" {
  value       = var.oidc_provider_url != "" ? "" : aws_iam_openid_connect_provider.cluster[0].url
  description = "OIDC url"
}

output "oidc_arn" {
  value       = var.oidc_provider_arn != "" ? "" : aws_iam_openid_connect_provider.cluster[0].arn
  description = "OIDC url"
}