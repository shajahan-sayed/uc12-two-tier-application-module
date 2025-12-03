resource "aws_security_group" "alb_sg1" {
  vpc_id = aws_vpc.vpc_module.id

  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = "0.0.0.0/0"
  }

  resource "aws_alb" "alb_module" {
     name = "alb_module"
     load_balancer_type = "application"
     subnet_ids = [ 
                    aws_subnet.public1.id,
                    aws_subnet.public2.id
                  ]
     security_groups = [aws_security_group.alb_module.id]

     enable_deletion_protection = false

  tags = {
    Name = "alb_module"
  }
}

resource "aws_lb_target_group" "app_module" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_module.id

  tags = {
    Name = "app_module"
  }
}
resource "aws_lb_listener" "module" {
   load_balancer_arn = aws_lb.alb_module.id
   port = 80
   protocol = "HTTP"
   
   default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_module.arn
  }
}
