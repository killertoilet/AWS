resource "aws_security_group" "automation-ssh-sg" {
	name = "automation-ssh-sg" 
	description = "AllowSSHinboundtraffic"
	vpc_id = aws_vpc.automation-vpc.id#ReplacewithreferencetoVPC

	ingress = [
		{description = "SSH from VPC"
		from_port = 22 
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]

		#Notnormallynecessary.
		ipv6_cidr_blocks=[]
		prefix_list_ids=[]
		security_groups=[]
		self=false
		}
		]

	egress = [
		{
		description = "Allowalloutbound"
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks=["0.0.0.0/0"]

		#Notnormallynecessary.
		ipv6_cidr_blocks=[]
		prefix_list_ids=[]
		security_groups=[]
		self=false}
		]
	tags={
		Name = "automation-ssh-sg"
		}
	}
