/* 6-Deploying Outbound Security */


#6.3 Configure AWS Route Tables

resource "aws_route_table" "private_route_table_a" {
  vpc_id = aws_vpc.single_vpc.id

  route {
    cidr_block = var.private_route_table_a.route
    network_interface_id = module.ngfw_a.eni_trust_id
  }
  
  tags = {
    Name = var.private_route_table_a.name
  }
}

resource "aws_route_table_association" "private_route_table_weba" {
  subnet_id      = aws_subnet.Web_server_2a.id
  route_table_id = aws_route_table.private_route_table_a.id
}
resource "aws_route_table_association" "private_route_table_busa" {
  subnet_id      = aws_subnet.Business_2a.id
  route_table_id = aws_route_table.private_route_table_a.id
}
resource "aws_route_table_association" "private_route_table_dba" {
  subnet_id      = aws_subnet.DB_2a.id
  route_table_id = aws_route_table.private_route_table_a.id
}

//

resource "aws_route_table" "private_route_table_b" {
  vpc_id = aws_vpc.single_vpc.id

  route {
    cidr_block = var.private_route_table_b.route
    network_interface_id = module.ngfw_b.eni_trust_id
  }
  
  tags = {
    Name = var.private_route_table_b.name
  }
}

resource "aws_route_table_association" "private_route_table_webb" {
  subnet_id      = aws_subnet.Web_server_2b.id
  route_table_id = aws_route_table.private_route_table_b.id
}
resource "aws_route_table_association" "private_route_table_busb" {
  subnet_id      = aws_subnet.Business_2b.id
  route_table_id = aws_route_table.private_route_table_b.id
}
resource "aws_route_table_association" "private_route_table_dbb" {
  subnet_id      = aws_subnet.DB_2b.id
  route_table_id = aws_route_table.private_route_table_b.id
}

