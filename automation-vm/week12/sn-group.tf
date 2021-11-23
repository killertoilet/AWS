resource "aws_db_subnet_group" "week12-subnet-group" {
	name = "week12-subnet-group"
	subnet_ids = [
		aws_subnet.week12-pri-a.id,
		aws_subnet.week12-pri-b.id
	]

	tags = {
		Name = "DB subnet group"
	}
}
