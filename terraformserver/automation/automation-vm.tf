resource "aws_instance" "automation-vm" {

	
	ami = data.aws_ami.latest-ubuntu.id
	instance_type = "t2.micro"
	subnet_id = aws_subnet.automation-subnet-a.id
	vpc_security_group_ids =[aws_security_group.automation-ssh-sg.id]
	iam_instance_profile = aws_iam_instance_profile.automation-profile.name
	key_name = "ECE592.pem"

	tags = {
		Name = "automation-vm"
		}

}

data "aws_ami" "latest-ubuntu" {
	most_recent = true
	owners = ["137112412989"] # Amazon (found from the AMI lookup page)
	filter {
		name   = "name"
		values = ["amzn2-ami-hvm-*"]
	}
}


resource "aws_iam_instance_profile" "automation-profile" {
	name = "automation-profile"
	role = aws_iam_role.automation-role.name
	tags = {}
}
