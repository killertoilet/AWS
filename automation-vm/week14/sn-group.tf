resource "aws_db_subnet_group" "week14-subnet-group" {
	name = "week14-subnet-group"
	subnet_ids = [
		aws_subnet.week14-pri-a.id,
		aws_subnet.week14-pri-b.id
	]

	tags = {
		Name = "DB subnet group"
	}
}
