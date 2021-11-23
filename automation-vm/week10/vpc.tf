resource "aws_vpc" "week10-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "week10-vpc"
  }
}

resource "aws_subnet" "week10-pri-a" {
	vpc_id = aws_vpc.week10-vpc.id
	cidr_block = "10.0.0.0/24"
	map_public_ip_on_launch = false
	availability_zone = "us-east-1a"
	tags = {
		Name = "week10-pri-a"
	}
}

resource "aws_subnet" "week10-pri-b" {
	vpc_id = aws_vpc.week10-vpc.id
	cidr_block = "10.0.1.0/24"
	map_public_ip_on_launch = false
	availability_zone = "us-east-1b"
	tags = {	
		Name = "week10-pri-b"
	}
}

resource "aws_route_table" "week10-pri-rt" {
	vpc_id = aws_vpc.week10-vpc.id
	route = []
	tags = {
		Name = "week10-pri-rt"
	}
}

resource "aws_route_table_association" "a" {
	subnet_id = aws_subnet.week10-pri-a.id
	route_table_id = aws_route_table.week10-pri-rt.id
}

resource "aws_route_table_association" "b" {
	subnet_id = aws_subnet.week10-pri-b.id
	route_table_id = aws_route_table.week10-pri-rt.id
}

resource "aws_internet_gateway" "week10-igw" {
	vpc_id = aws_vpc.week10-vpc.id

	tags = {
		Name = "week10-igw"
	}
}

resource "aws_default_route_table" "week10-rt" {
  default_route_table_id = aws_vpc.week10-vpc.default_route_table_id
  route = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.week10-igw.id
      destination_prefix_list_id = ""
      egress_only_gateway_id = ""
      instance_id = ""
      ipv6_cidr_block = ""
      nat_gateway_id = ""
      network_interface_id = ""
      transit_gateway_id = ""
      vpc_endpoint_id = ""
      vpc_peering_connection_id = ""
    }
  ]
  tags = {
    Name = "week10-rt"
  }
}
