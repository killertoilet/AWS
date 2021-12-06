resource "aws_vpc_endpoint" "week14-sm-ep" {
	vpc_id = aws_vpc.week14-vpc.id
	service_name = "com.amazonaws.us-east-1.secretsmanager"
	vpc_endpoint_type = "Interface"
	security_group_ids = [aws_security_group.week14-http-sg.id]
	private_dns_enabled = true
	subnet_ids = [aws_subnet.week14-pri-a.id, aws_subnet.week14-pri-b.id]
	
	tags = {
		Name = "week14-sm-ep"
	}
}


