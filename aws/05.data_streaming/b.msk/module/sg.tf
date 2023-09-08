resource "aws_security_group" "kafka-sg" {
  name = var.cluster_name
  vpc_id = var.vpc_id

  tags = {
    Name      = var.cluster_name
    Namespace = var.name_space
    Stage     = var.phase
  }
}

resource "aws_security_group_rule" "inbound_rule4" {
  description = "Allow all egress"
  type = "ingress"
  security_group_id = aws_security_group.kafka-sg.id
  from_port = 0
  to_port = 0
  protocol = "all"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}


resource "aws_security_group_rule" "outbound_rule1" {
  description = "Allow all egress"
  type = "egress"
  security_group_id = aws_security_group.kafka-sg.id
  from_port = 0
  to_port = 0
  protocol = "all"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}
