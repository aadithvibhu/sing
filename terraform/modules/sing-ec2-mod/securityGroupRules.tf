# Security Groups
#****************
resource "aws_security_group_rule" "allow_app_port" {
  type                     = "ingress"
  from_port                = "3000"
  to_port                  = "3000"
  protocol                 = "tcp"
  cidr_blocks              = ["${var.vpc_cidr_blocks}"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}


resource "aws_security_group_rule" "allow_db_port" {
  type                     = "ingress"
  from_port                = "3306"
  to_port                  = "3306"
  protocol                 = "tcp"
  cidr_blocks              = ["${var.vpc_cidr_blocks}"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}


resource "aws_security_group_rule" "app_ssh_rule" {
  type                     = "ingress"
  from_port                = "22"
  to_port                  = "22"
  protocol                 = "tcp"
  cidr_blocks              = ["${var.vpc_cidr_blocks}"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}

resource "aws_security_group_rule" "http_default_app_rule" {
  type                     = "ingress"
  from_port                = "80"
  to_port                  = "80"
  protocol                 = "tcp"
  cidr_blocks              = ["${var.vpc_cidr_blocks}"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}

resource "aws_security_group_rule" "default_https_rule" {
  type                     = "ingress"
  from_port                = "443"
  to_port                  = "443"
  protocol                 = "tcp"
  cidr_blocks =            ["${var.vpc_cidr_blocks}"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}

resource "aws_security_group_rule" "temp_all_rule" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}

resource "aws_security_group_rule" "test_server_rule" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.public_sg.id}"
}

#*********** Egress *****************

resource "aws_security_group_rule" "private_outbound_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.private_sg.id}"
}

resource "aws_security_group_rule" "public_outbound_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.public_sg.id}"
}

#*****************
#*variables
variable vpc_cidr_blocks {}

