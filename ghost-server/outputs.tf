# output "elb_dns" { value = "${aws_elb.ghost.dns_name}" }
output "ip" { value = "${aws_instance.ghost.public_ip}" }
