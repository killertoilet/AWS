resource "aws_instance" "week9-bastion" {


  ami                    = "ami-02e136e904f3da870"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.week9-pub-a.id
  vpc_security_group_ids = [aws_security_group.week9-ssh-sg.id]
  key_name               = "ECE592.pem"

  tags = {
    Name = "week9-bastion"
  }

}

resource "aws_security_group" "week9-ssh-sg" {
  name        = "week9-ssh-sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.week9-vpc.id

  ingress = [
    {
      description      = "ssh"
      from_port        = 22
      to_port          = 22
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
    Name = "allow_ssh"
  }
}
