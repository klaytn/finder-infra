output "eks_control_plane" {
  value = aws_eks_cluster.this
}

output "eks_oidc" {
  value = aws_iam_openid_connect_provider.this
}

output "eks_oidc_arn" {
  value = aws_iam_openid_connect_provider.this.arn
}

output "eks_oidc_url" {
  value = aws_iam_openid_connect_provider.this.url
}