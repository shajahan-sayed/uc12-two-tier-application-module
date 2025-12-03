resource "aws_subnet" "public1" {
   vpc_id = aws_vpc.vpc_module.id
   cidr_block = var.public1_cidr
   map_public_ip_on_launch = true 
   availability_zone = var.availability_zone1

   tags = {
     Name = "public1"
   }
}
resource "aws_subnet" "public2" {
   vpc_id = aws_vpc.vpc_module.id
   cidr_block = var.public2_cidr
   map_public_ip_on_launch = true 
   availability_zone = var.availability_zone2

   tags = {
     Name = "public2"
   }
}
resource "aws_subnet" "private1" {
   vpc_id = aws_vpc.vpc_module.id
   cidr_block = var.private1_cidr
   map_public_ip_on_launch = true 
   availability_zone = var.availability_zone1

   tags = {
     Name = "private1"
   }
}
resource "aws_subnet" "private2" {
   vpc_id = aws_vpc.vpc_module.id
   cidr_block = var.private2_cidr
   availability_zone = var.availability_zone2

   tags = {
     Name = "private2"
   }
}
