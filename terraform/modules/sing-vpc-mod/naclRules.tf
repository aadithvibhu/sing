resource "aws_network_acl" "main_nacl" {
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.default_route}"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.default_route}"
    from_port  = 0
    to_port    = 0
  }
  tags = {
    Name = "${var.project}-nacl-rules"
  }
}
#********* Variables **********

variable project {}
variable default_route {}
