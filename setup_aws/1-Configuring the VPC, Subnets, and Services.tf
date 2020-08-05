/* Configuring the VPC, Subnets, and Services */

# 1.1 Create the VPC
resource "aws_vpc" "single_vpc" {
  cidr_block = var.vpc_Example_Application.cidr
  enable_dns_hostnames = var.vpc_Example_Application.edit_dns_hostnames

  tags = {
    Name = var.vpc_Example_Application.vpc_name
  }
}
# 1.2 Create IP Subnets

resource "aws_subnet" "Public_2a" {
  vpc_id            = aws_vpc.single_vpc.id
  cidr_block        = var.vpc_Example_Application.Public_2a
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.vpc_Example_Application.Public_2a_Name
  }
}

resource "aws_subnet" "FW_2a" {
  vpc_id            = aws_vpc.single_vpc.id
  cidr_block        = var.vpc_Example_Application.FW_2a
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.vpc_Example_Application.FW_2a_Name
  }
}

resource "aws_subnet" "Web_server_2a" {
  vpc_id            = aws_vpc.single_vpc.id
  cidr_block        = var.vpc_Example_Application.Web_server_2a
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.vpc_Example_Application.Web_server_2a_Name
  }
}

resource "aws_subnet" "Business_2a" {
  vpc_id            = aws_vpc.single_vpc.id
  cidr_block        = var.vpc_Example_Application.Business_2a
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.vpc_Example_Application.Business_2a_Name
  }
}

resource "aws_subnet" "DB_2a" {
  vpc_id            = aws_vpc.single_vpc.id
  cidr_block        = var.vpc_Example_Application.DB_2a
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.vpc_Example_Application.DB_2a_Name
  }
}

resource "aws_subnet" "Mgmt_2a" {
  vpc_id            = aws_vpc.single_vpc.id
  cidr_block        = var.vpc_Example_Application.Mgmt_2a
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.vpc_Example_Application.Mgmt_2a_Name
  }
}

//

resource "aws_subnet" "Public_2b" {
  vpc_id            = aws_vpc.single_vpc.id
  cidr_block        = var.vpc_Example_Application.Public_2b
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = var.vpc_Example_Application.Public_2b_Name
  }
}

resource "aws_subnet" "FW_2b" {
  vpc_id            = aws_vpc.single_vpc.id
  cidr_block        = var.vpc_Example_Application.FW_2b
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = var.vpc_Example_Application.FW_2b_Name
  }
}

resource "aws_subnet" "Web_server_2b" {
  vpc_id            = aws_vpc.single_vpc.id
  cidr_block        = var.vpc_Example_Application.Web_server_2b
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = var.vpc_Example_Application.Web_server_2b_Name
  }
}

resource "aws_subnet" "Business_2b" {
  vpc_id            = aws_vpc.single_vpc.id
  cidr_block        = var.vpc_Example_Application.Business_2b
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = var.vpc_Example_Application.Business_2b_Name
  }
}

resource "aws_subnet" "DB_2b" {
  vpc_id            = aws_vpc.single_vpc.id
  cidr_block        = var.vpc_Example_Application.DB_2b
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = var.vpc_Example_Application.DB_2b_Name
  }
}

resource "aws_subnet" "Mgmt_2b" {
  vpc_id            = aws_vpc.single_vpc.id
  cidr_block        = var.vpc_Example_Application.Mgmt_2b
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = var.vpc_Example_Application.Mgmt_2b_Name
  }
}

# 1.3 Create a VPC Internet Gateway
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = "${aws_vpc.single_vpc.id}"

  tags = {
    Name = var.vpc_Example_Application.igw_name
  }
}

# 1.4 Create VPC Route Tables
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.single_vpc.id

  route {
    cidr_block = var.vpc_Example_Application.default_destination_route
    gateway_id = aws_internet_gateway.vpc_igw.id
  }
  
  tags = {
    Name = var.vpc_Example_Application.public_route_table
  }
}

resource "aws_route_table_association" "public_route_table_ass" {
  subnet_id      = aws_subnet.Public_2a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_ass2" {
  subnet_id      = aws_subnet.Public_2b.id
  route_table_id = aws_route_table.public_route_table.id
}

//

resource "aws_route_table" "mgmt_route_table" {
  vpc_id = aws_vpc.single_vpc.id

  route {
    cidr_block = var.vpc_Example_Application.default_destination_route
    gateway_id = aws_internet_gateway.vpc_igw.id
  }
  
  tags = {
    Name = var.vpc_Example_Application.mgmt_route_table
  }
}

resource "aws_route_table_association" "mgmt_route_table_ass" {
  subnet_id      = aws_subnet.Mgmt_2a.id
  route_table_id = aws_route_table.mgmt_route_table.id
}

resource "aws_route_table_association" "mgmt_route_table_ass2" {
  subnet_id      = aws_subnet.Mgmt_2b.id
  route_table_id = aws_route_table.mgmt_route_table.id
}

# 1.5 Create Security Groups
resource "aws_security_group" "Firewall_Public" {
  name        = "SVPC_Firewall-Public"
  description = "Allow inbound applications from the internet."
  vpc_id      = aws_vpc.single_vpc.id

    //add default outbound rule
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    //add default for inbound
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  }

resource "aws_security_group" "Firewall_Mgmt" {
  name        = "SVPC_Firewall-Mgmt"
  description = "Allow inbound management to the firewall."
  vpc_id      = aws_vpc.single_vpc.id

    //add default outbound rule
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    //add default for inbound
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = var.ssh_https_access_cidr_blocks
    }

     ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = var.ssh_https_access_cidr_blocks
    }
  }


resource "aws_security_group" "Firewall_Private" {
  name        = "SVPC_Firewall-Private."
  description = "Allow inbound applications from the internet."
  vpc_id      = aws_vpc.single_vpc.id

    //add default outbound rule
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    //add default for inbound
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["${var.vpc_Example_Application.cidr}"]
    }
  }


# 1.6 Configure VPC Peering
resource "aws_vpc_peering_connection" "vm_series2managment_vpc_peering" {
  peer_vpc_id   = var.vpc_panorama_managment.vpc_id
  vpc_id        = aws_vpc.single_vpc.id
  auto_accept   = true

  tags = {
    Name = "VPC Peering between requester (where vm-series are) and existing management where panorama are"
  }
}

# Create security group inbound rule on Panorama Security group to allow traffic from single vpc

resource "aws_security_group_rule" "inboud_from_single_vpc" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.vpc_Example_Application.cidr]
  security_group_id = var.vpc_panorama_managment.panorama_sg
}

# Create Route for VM-Series firewalls to reach the Panorama’s VPC over the peer
resource "aws_route" "vm-series2management" {
  # ID of VPC 1 main route table.
  route_table_id = aws_route_table.mgmt_route_table.id

  # CIDR block / IP range for VPC.
  destination_cidr_block = var.vpc_panorama_managment.cidr

  # ID of VPC peering connection.
  vpc_peering_connection_id = aws_vpc_peering_connection.vm_series2managment_vpc_peering.id
}


# Create route for Panorama's VPC to reach VM-Series Firewalls over the peer
resource "aws_route" "management2vm-series" {
  # ID of VPC 2 main route table.
  route_table_id = var.vpc_panorama_managment.panorama_management_route_table

  # CIDR block / IP range for VPC.
  destination_cidr_block = aws_vpc.single_vpc.cidr_block

  # ID of VPC peering connection.
   vpc_peering_connection_id = aws_vpc_peering_connection.vm_series2managment_vpc_peering.id
}

