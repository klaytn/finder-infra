data "template_file" "kafka_startup" {
  count    = "${var.servers}"
  template = "${file("${path.module}/scripts/kafka-startup.sh")}"
  vars = {
    broker_id = "${count.index + 1}"
  }
}