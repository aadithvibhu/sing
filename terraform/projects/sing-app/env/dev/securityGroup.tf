# Security Groups
#****************

resource "aws_security_group" "public_sg" {
  name        = "${var.project}_public_sg"
  description = "Allow inbound traffic"
  vpc_id      = "${data.aws_vpc.main.id}"
  tags = {
    Name                     = "${var.project}_public_sg"
    Type                     = "EC2 Security Group"
    Monitoring               = "true"
  }
}

resource "aws_security_group" "private_sg" {
  name        = "${var.project}_private_sg"
  description = "Allow inbound traffic"
  vpc_id      = "${data.aws_vpc.main.id}"
  tags = {
    Name                     = "${var.project}_private_sg"
    Type                     = "EC2 Security Group"
    Monitoring               = "true"
  }
}


#********* Variables **********

#variable project {}
