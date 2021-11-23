resource "aws_vpc_endpoint" "week10-ec2-ep" {
	vpc_id = aws_vpc.week10-vpc.id
	service_name = "com.amazonaws.us-east-1.ec2"
	vpc_endpoint_type = "Interface"
	security_group_ids = [aws_security_group.week10-http-sg.id]
	private_dns_enabled = true
	subnet_ids = [aws_subnet.week10-pri-a.id, aws_subnet.week10-pri-b.id]
	
	tags = {
		Name = "week10-ec2-ep"
	}
}

resource "aws_vpc_endpoint" "week10-sqs-ep" {
	vpc_id = aws_vpc.week10-vpc.id
	service_name = "com.amazonaws.us-east-1.sqs" 
	vpc_endpoint_type = "Interface"
	security_group_ids = [aws_security_group.week10-http-sg.id]
	private_dns_enabled = true
	subnet_ids = [aws_subnet.week10-pri-a.id, aws_subnet.week10-pri-b.id]

	tags = {
		Name = "week10-sqs-ep"
	}
}
