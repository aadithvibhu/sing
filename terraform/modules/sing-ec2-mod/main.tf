
########################################
resource "aws_instance" "linux_instance" {
  count 	                     = "${var.instance_count}"
  ami                          = "${lookup(var.linux_ami, var.aws_region)}"
  instance_type  	             = "${var.instance_type}"
  disable_api_termination      = false
  monitoring                   = true
  user_data    	 	             = "${var.user_data}"
  iam_instance_profile         = "${var.iam_instance_profile}"
  key_name                     = "${var.key_name}"
  subnet_id                    = "${var.subnet_id}"
  associate_public_ip_address  = "${var.public_ip}"
  security_groups              = ["${aws_security_group.private_sg.id}"]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.volume_size}"
    delete_on_termination = true
  }

  tags			  = {
    Name                  = format("${var.instance_name}-%02d", count.index + 1)
    Type                  = "EC2 Instance"
    Monitoring            = "true"
    Environment           = "${var.environment}"
    Project               = "${var.project}"
	 }

  depends_on            = [var.depends_on_value]


  #provisioner "file" {
  #  source      = "${var.src_local_file_loc}"
  #  destination = "${var.db_inventory}"
#
#   connection {
#    type     = "ssh"
#    user     = "ec2-user"
#    private_key = "${file("/home/ec2-user/key")}"
#    host     = "${element(aws_instance.linux_instance.*.private_ip, count.index)}"
#  }
#}
}


data "template_file" "hosts" {
    template = "${file("hosts.tpl")}"
    vars = {
       webserverip = "${join("\n", aws_instance.linux_instance.*.public_ip)}"
      #alb = "${aws_lb.alb.dns_name}"
      = "${aws_lb.wlb.dns_name}"
    }
}

resource "local_file" "ansible_inventory" {
  content  = "${data.template_file.hosts.rendered}"
  filename = "/apps/ansible-ps/playbooks/hosts"
}

#resource "aws_network_interface" "main" {
# subnet_id       = "${var.subnet_id}"
#}

#resource "aws_network_interface_sg_attachment" "sg_attachment" {
#  count                = "${var.instance_count}"
#  security_group_id    = "${aws_security_group.private_sg.id}"
#  network_interface_id = "${element(aws_instance.linux_instance.*.primary_network_interface_id, count.index)}"
#}


###################################
#variables
#*********
variable linux_ami {}
variable aws_region {}
variable vpc_id {}
variable instance_count {}
variable instance_type {}
variable instance_name {}
variable subnet_id {}
variable subnet_type {}
variable volume_size {}
variable user_data {}
variable iam_instance_profile {
  default = "ec2admin"
}
variable key_name {
  default = "kp_devops"
}
variable environment {}
variable project {}
variable public_ip {}
variable depends_on_value {}
variable db_inventory {}
variable src_local_file_loc {}
variable security_groups {}
#######################################o###
#outputs
output "public_ip" {
  value = aws_instance.linux_instance.*.public_ip
}

output "instanceid" {
  value = aws_instance.linux_instance.*.id
}
