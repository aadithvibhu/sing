# Security Groups
#****************
resource "aws_security_group_rule" "ssh_rule" {
  type                     = "ingress"
  from_port                = "22"
  to_port                  = "22"
  protocol                 = "tcp"
  cidr_blocks              = ["${data.aws_vpc.cidr_block}"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}

resource "aws_security_group_rule" "http_rule" {
  type                     = "ingress"
  from_port                = "80"
  to_port                  = "80"
  protocol                 = "tcp"
  cidr_blocks              = ["${data.aws_vpc.cidr_block}"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}

resource "aws_security_group_rule" "allow_all_public_rule" {
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
