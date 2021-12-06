resource "aws_security_group" "week14-rds-sg" {
  name        = "week14-rds-sg"
  description = "DB sg"
  vpc_id      = aws_vpc.week14-vpc.id

  ingress = [
    {
      description      = "MySQL"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
	
      ipv6_cidr_blocks = []
      security_groups = []	
      prefix_list_ids = []
      self = false
     
    }
  ]

  egress = [
    {
      description = "allow outbound"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups =  []
      prefix_list_ids = []
      self = false
    }
  ]

  tags = {
    Name = "allow_MySQL_Access"
  }
}
