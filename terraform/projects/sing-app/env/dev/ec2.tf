resource "aws_instance" "linux_instance" {
  count 	                     =  2
  ami                          = "${lookup(var.linux_ami, var.aws_region)}"
  instance_type  	             = "t2.micro"
  disable_api_termination      = false
  monitoring                   = true
  user_data    	 	             = file("../../../../scripts/apache.sh")
  iam_instance_profile         = "ec2admin"
  key_name                     = "devops"
  subnet_id                    = "${element(["${data.aws_subnet.private_subnet_1.id}", "${data.aws_subnet.private_subnet_2.id}"],
            count.index)}"
  associate_public_ip_address  = "true"
  security_groups              = ["${aws_security_group.private_sg.id}"]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  tags			  = {
    Name                  = format("${var.instance_name}-%02d", count.index + 1)
    Type                  = "EC2 Instance"
    Monitoring            = "true"
    Environment           = "${var.environment}"
    Project               = "${var.project}"
	 }

}

#Variables

variable instance_name {
  default = "webserver"
}

variable environment {
  default = "dev"
}

variable project {
  default = "sing"
}


variable "aws_region" {
  default = "ap-southeast-1"
}

variable "linux_ami" {
   type = map(string)
   default = {
    ap-southeast-1 = "ami-0adbe59da7d24a349"
  }
}

