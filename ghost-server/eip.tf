resource "aws_eip" "ghost-eip" {
  instance    = "${aws_instance.ghost.id}"

  lifecycle {
    prevent_destroy = true
  }
}
