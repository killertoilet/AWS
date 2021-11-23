resource "aws_security_group" "week11-ssh-pri-sg" {
  name        = "week11-ssh-pri-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.week11-vpc.id

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = []

      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [aws_security_group.week11-ssh-sg.id]
      self             = false
    }
  ]

  egress = [
    {
      description      = "Allow all outbound"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]

      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "automation-ssh-sg"
  }
}

resource "aws_iam_instance_profile" "week11-profile" {
  name = "week11-profile"
  role = aws_iam_role.week11-role.name
  tags = {}
}


resource "aws_instance" "week11-worker-vm" {
  ami                    = "ami-0168b9285893a7395"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.week11-pri-a.id
  vpc_security_group_ids = [aws_security_group.week11-ssh-pri-sg.id]
  key_name               = "ECE592.pem"
  iam_instance_profile   = aws_iam_instance_profile.week11-profile.name
  user_data 		 = file("cloudinit.txt")
  tags = {
    Name = "week11-worker-vm"
  }
}
