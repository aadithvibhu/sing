resource "aws_lb" "wlb" {
  name               = "${var.project}-wlb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["${data.aws_subnet.public_subnet.id}", "${data.aws_subnet.private_subnet_2.id}"]
  #security_groups    = ["${aws_security_group.private_sg.id}"]

  tags = {
    Name = "${var.project}-wlb"
  }
}
resource "aws_lb_target_group" "wlb_target_group" {
  name        = "wlb-to-ip"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "${data.aws_vpc.main.id}"
  
 health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 6
    timeout             = 20
    interval            = 60
    path                = "/index.html"
  }


}

resource "aws_lb_target_group_attachment" "wlb_target_attach" {
  count            = 2
  target_group_arn = "${aws_lb_target_group.wlb_target_group.arn}"
  target_id        = "${element(aws_instance.linux_instance.*.id, count.index)}"
  port             = 80

}

resource "aws_lb_listener" "wlb_listener" {
  load_balancer_arn = "${aws_lb.wlb.arn}"
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.wlb_target_group.arn}"
  }
}
#*******Variables**********
#variable subnet_ids {}
#variable project {}
#variable sg_id {}
#variable vpc_id {}

