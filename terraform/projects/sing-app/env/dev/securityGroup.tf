# Security Groups
#****************

## you can create seperate security if required, Make using default sg as public
# resource "aws_security_group" "public_sg" {
#   name        = "${var.project}_public_sg"
#   description = "Allow inbound traffic"
#   vpc_id      = "${data.aws_vpc.main.id}"
#   tags = {
#     Name                     = "${var.project}_public_sg"
#     Type                     = "EC2 Security Group"
#     Monitoring               = "true"
#   }
# }

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

### 
resource "aws_default_security_group" "public_sg" {
  vpc_id = "${data.aws_vpc.main.id}"

  ingress {
    protocol  = -1
    from_port = 0
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name                     = "${var.project}_public_sg"
    Type                     = "EC2 Security Group"
    Monitoring               = "true"
  }
}

#********* Variables **********

#variable project {}
