data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_iam_role" "service_linked_iam_role" {
  name = "AWSServiceRoleForAmazonOpenSearchService"
}

resource "aws_iam_service_linked_role" "create_service_linked_role" {
  count           = data.aws_iam_role.service_linked_iam_role.name == "" ? 1 : 0
  aws_service_name = "opensearchservice.amazonaws.com"  
}

resource "aws_security_group" "sg" {
  name = var.domain_name
  vpc_id = var.vpc_id

  tags = {
    Name      = var.domain_name
    Namespace = var.namespace
    Stage     = var.phase
  }
}

resource "aws_security_group_rule" "inbound_rule1" {
  description = "Allow all egress"
  type = "ingress"
  security_group_id = aws_security_group.sg.id
  from_port = 0
  to_port = 0
  protocol = "all"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}


resource "aws_security_group_rule" "outbound_rule1" {
  description = "Allow all egress"
  type = "egress"
  security_group_id = aws_security_group.sg.id
  from_port = 0
  to_port = 0
  protocol = "all"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_opensearch_domain" "domain" {
  domain_name    = var.domain_name
  engine_version = var.engine_version

  cluster_config {
    instance_type = var.instance_type
    instance_count = var.instance_count

    zone_awareness_config {
      availability_zone_count = var.instance_count
    }
    zone_awareness_enabled = true
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.node_ebs_volume_gib
    volume_type = var.node_ebs_volume_type
  }

  vpc_options {
    subnet_ids = var.subnet_ids
    security_group_ids = [aws_security_group.sg.id]
  }

  tags = {
    Name = var.domain_name
    Namespace = var.namespace
    Stage = var.phase
  }

  depends_on = [
    aws_iam_service_linked_role.create_service_linked_role
  ]
}

resource "aws_opensearch_domain_policy" "policy" {
  domain_name = aws_opensearch_domain.domain.domain_name

  access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "es:*",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain_name}/*"
        }
    ]
}
POLICIES
}
