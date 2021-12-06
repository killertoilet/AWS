resource "aws_subnet" "week13-pub-a" {

  vpc_id                  = aws_vpc.week13-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "week13-pub-a"
  }
}



