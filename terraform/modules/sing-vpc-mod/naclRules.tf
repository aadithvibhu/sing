# To create new Network ACL's"
# resource "aws_network_acl" "main_nacl" {
#   vpc_id = "${aws_vpc.main.id}"

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "${var.default_route}"
#     from_port  = 0
#     to_port    = 0
#   }

#   egress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "${var.default_route}"
#     from_port  = 0
#     to_port    = 0
#   }
#   tags = {
#     Name = "${var.project}-nacl-rules"
#   }
# }
#********* Variables **********

#variable project {}
#variable default_route {}

# use the existing Network_ACL
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.main.default_network_acl_id

  ingress {
    protocol   = "http"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
    tags = {
    Name = "${var.project}-nacl-rules"
  }
}