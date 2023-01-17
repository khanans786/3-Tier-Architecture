# Creating External LoadBalancer
resource "aws_lb" "external-elb" {
  name               = "External-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web-sg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-1.id]
}
resource "aws_lb_target_group" "external-elb" {
  name     = "ALB-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ProjectK-vpc.id
}


resource "aws_lb_target_group_attachment" "external-elb1" {
  target_group_arn = aws_lb_target_group.external-elb.arn
  target_id        = aws_instance.instance1.id
  port             = 80

  depends_on = [
    aws_instance.instance1,
  ]
}
resource "aws_lb_target_group_attachment" "external-elb2" {
  target_group_arn = aws_lb_target_group.external-elb.arn
  target_id        = aws_instance.instance2.id
  port             = 80
  depends_on = [
    aws_instance.instance2,
  ]
}
resource "aws_lb_listener" "external-elb" {
  load_balancer_arn = aws_lb.external-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external-elb.arn
  }
}