data "aws_availability_zones" "available" {

}

resource "aws_elb" "ghost" {
  name               = "${var.name}-elb"
  availability_zones = ["${data.aws_availability_zones.available.names}"]

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 80
    lb_protocol        = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.ghost.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "${var.name}-elb"
  }
}
