resource "aws_internet_gateway" "automation-igw" {

  vpc_id = aws_vpc.automation-vpc.id

  tags = {
    Name = "automation-igw"
  }
}
