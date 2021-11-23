resource "aws_autoscaling_group" "week11-bastion-asg" {
	name = "week11-bastion-asg"
	max_size = 1
	min_size = 1
	desired_capacity = 1

	launch_template {
		id = aws_launch_template.week11-bastion-lt.id
		version = "$Latest"
	}
}
