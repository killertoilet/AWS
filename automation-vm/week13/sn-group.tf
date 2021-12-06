resource "aws_db_subnet_group" "week13-subnet-group" {
	name = "week13-subnet-group"
	subnet_ids = [
		aws_subnet.week13-pri-a.id,
		aws_subnet.week13-pri-b.id
	]

	tags = {
		Name = "DB subnet group"
	}
}
