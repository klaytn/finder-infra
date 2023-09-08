data "aws_ami" "amazon_linux2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  owners = ["amazon"]
}

resource "aws_network_interface" "network_interface" {
  for_each = toset(var.ec2_ids)
  subnet_id   = var.vpc_subnet_ids[index(var.ec2_ids, each.value) % length(var.vpc_subnet_ids)]
  security_groups = [aws_security_group.sg.id]

  tags = {
    Name = each.key
    Namespace = "klaytn"
    Stage = var.phase
  }
}

resource "aws_instance" "ec2" {
  for_each = aws_network_interface.network_interface
  // use data.aws_ami if var.ami is missing (= empty string)
  ami           = coalesce(var.ami, data.aws_ami.amazon_linux2.id)
  instance_type = var.instance_type
  ebs_optimized = true

  iam_instance_profile = "SessionManagerInstanceProfile"

  network_interface {
    network_interface_id = each.value.id
    device_index         = 0
  }

  root_block_device {
    delete_on_termination = false
    encrypted = false
    tags = {
      Name = each.key
      Namespace = "klaytn"
      Stage = var.phase
    }
    volume_type = "gp2"
    volume_size = var.root_volume_size_gib
  }

  # ebs_block_device {
  #   device_name = "/dev/sdf"
  #   delete_on_termination = false
  #   encrypted = false
  #   tags = {
  #     Name = each.key
  #     Namespace = "klaytn"
  #     Stage = var.phase
  #   }
  #   volume_type = "gp2"
  #   volume_size = var.ebs_volume_size_gib
  # }
  tags = {
    Name = each.key
    Namespace = "klaytn"
    Stage = var.phase
  }
}
