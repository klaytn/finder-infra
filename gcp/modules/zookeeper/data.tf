data "template_file" "zk_startup" {
  count    = "${var.servers}"
  template = "${file("${path.module}/scripts/zk-startup.sh")}"
  vars = {
    id = "${count.index + 1}"
  }
}