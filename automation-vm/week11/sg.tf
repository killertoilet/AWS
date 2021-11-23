resource "aws_security_group" "week11-http-sg" {
  name        = "week11-http-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.week11-vpc.id

  ingress = [
    {
      description      = "http"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
	
      ipv6_cidr_blocks = []
      security_groups = [aws_security_group.week11-ssh-pri-sg.id]
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
    Name = "allow_ssh"
  }
}
