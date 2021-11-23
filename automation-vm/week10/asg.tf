resource "aws_autoscaling_group" "week10-bastion-asg" {
	name = "week10-bastion-asg"
	max_size = 1
	min_size = 1
	desired_capacity = 1

	launch_template {
		id = aws_launch_template.week10-bastion-lt.id
		version = "$Latest"
	}
}
