resource "aws_security_group" "sg" {
  name = var.name
  vpc_id = var.vpc_id

  tags = {
    Name      = var.name
    Namespace = "klaytn"
    Stage     = var.phase
  }
}

resource "aws_security_group_rule" "inbound_rule1" {
  description = "(Allow rpc, websocket) ${var.name}"
  type = "ingress"
  security_group_id = aws_security_group.sg.id
  from_port = 8551
  to_port = 8552
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "inbound_rule2" {
  description = "(SSM, HTTPS) ${var.name}"
  type = "ingress"
  security_group_id = aws_security_group.sg.id
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "inbound_rule3" {
  description = "(HTTP) ${var.name}"
  type = "ingress"
  security_group_id = aws_security_group.sg.id
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "inbound_rule4" {
  description = "32323: p2p + 32324: additional multichannel port"
  type = "ingress"
  security_group_id = aws_security_group.sg.id
  from_port = 32323
  to_port = 32324
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group_rule" "inbound_rule5" {
  description = "BOOTNODE communication"
  type = "ingress"
  security_group_id = aws_security_group.sg.id
  from_port = 32323
  to_port = 32323
  protocol = "udp"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group_rule" "outbound_rule1" {
  description = "(Allow rpc, websocket) ${var.name}"
  type = "egress"
  security_group_id = aws_security_group.sg.id
  from_port = 8551
  to_port = 8552
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outbound_rule2" {
  description = "(SSM, HTTPS) ${var.name}"
  type = "egress"
  security_group_id = aws_security_group.sg.id
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outbound_rule3" {
  description = "(HTTP, download public resource) ${var.name}"
  type = "egress"
  security_group_id = aws_security_group.sg.id
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outbound_rule4" {
  description = "32323: p2p + 32324: additional multichannel port"
  type = "egress"
  security_group_id = aws_security_group.sg.id
  from_port = 32323
  to_port = 32324
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group_rule" "outbound_rule5" {
  description = "BOOTNODE communication"
  type = "egress"
  security_group_id = aws_security_group.sg.id
  from_port = 32323
  to_port = 32323
  protocol = "udp"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group_rule" "outbound_rule6" {
  description = "kafka cluster"
  type = "egress"
  security_group_id = aws_security_group.sg.id
  from_port = 9092
  to_port = 9092
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
