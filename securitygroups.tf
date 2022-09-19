resource "aws_security_group" "file_system_sec_grp" {
  name        = "${var.name}-file-system-sec-grp"
  description = "Security group for Amazon FSx"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 988
    protocol        = "tcp"
    to_port         = 988
    security_groups = var.security_group_ids
  }

  ingress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    self      = true
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-file-system-sec-grp"
  }
}
