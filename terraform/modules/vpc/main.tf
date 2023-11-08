resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

data "aws_availability_zones" "available_zones" {}

resource "aws_subnet" "my_subnet" {
  count      = length(var.subnet_cidrs)
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidrs[count.index]
  #availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1d"], count.index)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${data.aws_availability_zones.available_zones.names[count.index]}-Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}


resource "aws_route_table" "custom_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.project_name}-route-table"
  }
}

# Associate the custom route table with the subnets
resource "aws_route_table_association" "subnet_associations" {
  count          = length(aws_subnet.my_subnet)
  subnet_id      = aws_subnet.my_subnet[count.index].id
  route_table_id = aws_route_table.custom_route_table.id
}

resource "aws_security_group" "eks_node_security_group" {
  name_prefix = "eks-node-sg"
  description = "Security Group for Amazon EKS Nodes"
  vpc_id      = aws_vpc.my_vpc.id

  # Inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add more inbound rules as needed

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project_name}-EKS-SG"
  }
}
