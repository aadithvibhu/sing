# Security Groups
#****************

resource "aws_security_group" "public_sg" {
  name        = "${var.project}_public_sg"
  description = "Allow inbound traffic"
  vpc_id      = "${var.vpc_id}"
  tags = {
    Name                     = "${var.project}_public_sg"
    Type                     = "EC2 Security Group"
    Monitoring               = "true"
  }
}

resource "aws_security_group" "private_sg" {
  name        = "${var.project}_private_sg"
  description = "Allow inbound traffic"
  vpc_id      = "${var.vpc_id}"
  tags = {
    Name                     = "${var.project}_private_sg"
    Type                     = "EC2 Security Group"
    Monitoring               = "true"
  }
}

#resource "aws_security_group" "data_sg" {
#  name        = "${var.project}_data_sg"
#  description = "Allow inbound traffic"
#  vpc_id      = "${var.vpc_id}"
#  tags = {
#    Name                     = "${var.project}_data_sg"
#    Type                     = "EC2 Security Group"
#    Monitoring               = "true"
#  }
#}

#********* Variables **********

#variable project {}
#variable vpc_id {}
#********** Outputs ************

output "public_security" {
  value       = aws_security_group.public_sg.id
}
output "private_security" {
  value       = aws_security_group.private_sg.id
}
#output "data_security" {
#  value       = aws_security_group.data_sg.id
#}
