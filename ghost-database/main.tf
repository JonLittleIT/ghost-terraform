resource "aws_db_instance" "ghost" {
  allocated_storage         = 20
  storage_type              = "gp2"
  engine                    = "mysql"
  engine_version            = "5.7.19"
  instance_class            = "db.t2.micro"
  name                      = "${var.db_name}"
  username                  = "${var.db_user}"
  password                  = "${var.db_pass}"
  backup_retention_period   = 7


  vpc_security_group_ids    = ["${var.security_groups}"]
  final_snapshot_identifier = "${var.name}-final-snapshot"

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Name = "${var.name}"
  }
}
