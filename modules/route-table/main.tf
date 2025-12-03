resource "aws_route_table" "route_module" {
   vpc_id = aws_vpc.vpc_module.id

   tags = {
     Name = "route_module"
   }
}

resource "aws_route" "module_route" {
  route_table_id = aws_route_table.route_module.id
  gateway_id = aws_internet_gateway.igw_module.id
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_route_table_association" "public1" {
   route_table_id = aws_route_table.route_module.id
   subnet_id = aws_subnet.public1.id

   tags = {
     Name = "public1"
   }
}
resource "aws_route_table_association" "public2" {
   route_table_id = aws_route_table.route_module.id
   subnet_id = aws_subnet.public2.id

   tags = {
     Name = "public2"
   }
}

resource "aws_eip" "eip_module" {
   domain = "vpc"

   tags = {
        Name = "eip_module"
   }
 }

 resource "aws_nat_gateway" "nat_module" {
     subnet_id = aws_subnet.public1.id
     allocation_id = aws_eip.eip_module.id

     tags = {
        Name = "nat_module"
     }
  }

  resource "aws_route_table" "private_route" {
      vpc_id = aws_vpc.vpc_module.id

      tags = { 
        Name = "private_route"
      }
   }

   resource "aws_route" "route_private" {
      route_table_id = aws_route_table.private_route.id
      nat_gateway_id = aws_nat_gateway.nat_module.id
      destination_cidr_block     = "0.0.0.0/0"
   }

  resource "aws_route_table_association" "private1" {
    subnet_id = aws_subnet.private1.id
    route_table_id = aws_route_table.private_route.id

    tags = {
         Name = "private1"
    }
  }
  resource "aws_route_table_association" "private2" {
    subnet_id = aws_subnet.private2.id
    route_table_id = aws_route_table.private_route.id

      tags = {
         Name = "private2"
      }
  }
     
    
  

   
