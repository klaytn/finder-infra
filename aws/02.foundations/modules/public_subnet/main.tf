resource "aws_subnet" "private" {
  count        = length(var.availability_zones)
  vpc_id       = var.vpc.vpc_id
  cidr_block   = cidrsubnet(
    var.vpc.cidr_block,
    var.subnets.newbits,
    var.subnets.netnum + count.index
  )

  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.subnets.name}-${format("%02d", count.index + 1)}-${var.vpc.vpc_name}"
  }
}