resource "aws_launch_template" "week14-bastion-lt" {
	name = "week14-bastion-lt"
	image_id = "ami-02e136e904f3da870"
	instance_type = "t2.micro"
	key_name = "ECE592.pem"

	network_interfaces {
		security_groups = [aws_security_group.week14-ssh-sg.id]
		subnet_id = aws_subnet.week14-pub-a.id
	}

	tag_specifications {
		resource_type = "instance"
		tags = {
			Name = "week14-bastion-vm"
		}
	}
}
