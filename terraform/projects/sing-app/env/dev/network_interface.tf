# resource "aws_network_interface" "main" {
#   count           = 2
#   subnet_id       =  "${element(["${data.aws_subnet.private_subnet_1.id}", 
#   "${data.aws_subnet.private_subnet_2.id}"], count.index)}"

#    depends_on = ["aws_security_group.instance_security_group"]
# }

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  count                = 2
  security_group_id    = "${aws_security_group.private_sg.id}"
  network_interface_id = "${element(aws_instance.linux_instance.*.primary_network_interface_id, count.index)}"
}