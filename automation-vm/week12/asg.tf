resource "aws_autoscaling_group" "week12-bastion-asg" {
	name = "week12-bastion-asg"
	max_size = 1
	min_size = 1
	desired_capacity = 1

	launch_template {
		id = aws_launch_template.week12-bastion-lt.id
		version = "$Latest"
	}
}
