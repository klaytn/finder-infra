data "terraform_remote_state" "foundation" {
  backend = "s3"
  config = {
    bucket = var.s3_bucket
    key    = var.s3_foundation_key
    region = var.aws_region
    profile = var.aws_profile_name
  }
}

module "eks" {
  source = "../modules/eks"

  name                   = var.eks_name
  subnet_ids             = data.terraform_remote_state.foundation.outputs.private_eks_subnet_info.id
  public_subnet_ids     = data.terraform_remote_state.foundation.outputs.public_subnet_info.id
  vpc_cidr               = data.terraform_remote_state.foundation.outputs.vpc_info.cidr_block
  vpc_id                 = data.terraform_remote_state.foundation.outputs.vpc_info.vpc_id
  endpoint_public_access = true

  nodegroup_default_instance_types              = "m5.large"
  nodegroup_default_disk_size                   = 200
  nodegroup_default_scaling_config_desired_size = "3"
  nodegroup_default_scaling_config_min_size     = "3"
  nodegroup_default_scaling_config_max_size     = "3"

  nodegroup_service_instance_types              = "m5.4xlarge"
  nodegroup_service_disk_size                   = 2000
  nodegroup_service_scaling_config_desired_size = "10"
  nodegroup_service_scaling_config_min_size     = "10"
  nodegroup_service_scaling_config_max_size     = "20"

  nodegroup_infra_instance_types              = "m5.xlarge"
  nodegroup_infra_disk_size                   = 200
  nodegroup_infra_scaling_config_desired_size = "3"
  nodegroup_infra_scaling_config_min_size     = "3"
  nodegroup_infra_scaling_config_max_size     = "3"
}



module "aws_lb_controller_irsa" {
  source = "../modules/irsa"
  eks_oidc_arn     = module.eks.eks_oidc.id
  eks_oidc_url     = module.eks.eks_oidc_url
  name             = "${var.eks_name}_${var.phase}-aws-load-balancer-controller-irsa"
  policy           = file("${path.module}/iam_polices/aws-lb-controller-iam-policy.json")
  service_accounts = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
  depends_on = [ module.eks ]
}

module "upload_service_irsa" {
  source = "../modules/irsa"

  eks_oidc_arn     = module.eks.eks_oidc.id
  eks_oidc_url     = module.eks.eks_oidc_url
  name             = "${var.eks_name}_${var.phase}-upload-service-irsa"
  policy           = file("${path.module}/iam_polices/upload-service-iam-policy.json")
  service_accounts = ["system:serviceaccount:klaytn-service:upload-service"]
  depends_on = [ module.eks ]  
}

module "external_secrets_irsa" {
  source = "../modules/irsa"

  eks_oidc_arn     = module.eks.eks_oidc.id
  eks_oidc_url     = module.eks.eks_oidc_url
  name             = "${var.eks_name}_${var.phase}-external-secrets-irsa"
  policy           = file("${path.module}/iam_polices/external-secrets-iam-policy.json")
  service_accounts = ["system:serviceaccount:default:nginx"]
  depends_on = [ module.eks ]  
}

module "finder_service_irsa" {
  source = "../modules/irsa"

  eks_oidc_arn     = module.eks.eks_oidc.id
  eks_oidc_url     = module.eks.eks_oidc_url
  name             = "${var.eks_name}_${var.phase}-finder-service-irsa"
  policy           = file("${path.module}/iam_polices/finder-service-iam-policy.json")
  service_accounts = ["system:serviceaccount:finder:sa-finder-service"]
  depends_on = [ module.eks ]  
}

module "dataengine_service_irsa" {
  source = "../modules/irsa"

  eks_oidc_arn     = module.eks.eks_oidc.id
  eks_oidc_url     = module.eks.eks_oidc_url
  name             = "${var.eks_name}_${var.phase}-dataengine-service-irsa"
  policy           = file("${path.module}/iam_polices/dataengine-service-iam-policy.json")
  service_accounts = ["system:serviceaccount:dataengine:sa-dataengine-service"]
  depends_on = [ module.eks ]  
}
