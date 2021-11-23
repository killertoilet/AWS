resource "aws_launch_template" "week11-bastion-lt" {
	name = "week11-bastion-lt"
	image_id = "ami-02e136e904f3da870"
	instance_type = "t2.micro"
	key_name = "ECE592.pem"

	network_interfaces {
		security_groups = [aws_security_group.week11-ssh-sg.id]
		subnet_id = aws_subnet.week11-pub-a.id
	}

	tag_specifications {
		resource_type = "instance"
		tags = {
			Name = "week11-bastion-vm"
		}
	}
}
