resource "aws_security_group" "ec2_sg1" {
   vpc_id = aws_vpc.vpc_module.id

   ingress {
     description = "allow http port"
     from_port = 80
     to_port = 80
     protocol = "tcp"
     security_groups = [aws_security_group.alb-sg1.id]
    }
    ingress { 
      description = "allowing ssh port" 
      from_port = 22
      to_port  = 22
      protocol = "tcp"
    }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "ec2_sg1"
    }
  }

resource "aws_instance" "ec2_alb" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.ec2_sg1.id]

    user_data = var.user_data
    
    tags = {
      Name = "ec2_alb"
    }
  }
