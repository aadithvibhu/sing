# Independent
###### if want to Two Private Ip address ############
# resource "aws_network_interface" "main" {
#   count           = 2
#   subnet_id       =  "${element(["${data.aws_subnet.private_subnet_1.id}", 
#   "${data.aws_subnet.private_subnet_2.id}"], count.index)}"
#   security_groups = ["${aws_security_group.private_sg.id}"]

#   attachment {
#     instance     = "${element(aws_instance.linux_instance.*.id, count.index)}"
#     device_index = 1
#   }
#}

## Dependent - You need to create new security group before attaching
# This will help to attach another security group to existing network interface of respective ec2 instance
# resource "aws_network_interface_sg_attachment" "sg_attachment" {
#   count                = 2
#   security_group_id    = "${aws_security_group.private_sg.id}"
#   network_interface_id = "${element(aws_instance.linux_instance.*.primary_network_interface_id, count.index)}"
# }