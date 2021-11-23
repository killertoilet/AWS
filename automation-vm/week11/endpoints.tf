resource "aws_vpc_endpoint" "week11-ec2-ep" {
	vpc_id = aws_vpc.week11-vpc.id
	service_name = "com.amazonaws.us-east-1.ec2"
	vpc_endpoint_type = "Interface"
	security_group_ids = [aws_security_group.week11-http-sg.id]
	private_dns_enabled = true
	subnet_ids = [aws_subnet.week11-pri-a.id, aws_subnet.week11-pri-b.id]
	
	tags = {
		Name = "week11-ec2-ep"
	}
}

resource "aws_vpc_endpoint" "week11-sqs-ep" {
	vpc_id = aws_vpc.week11-vpc.id
	service_name = "com.amazonaws.us-east-1.sqs" 
	vpc_endpoint_type = "Interface"
	security_group_ids = [aws_security_group.week11-http-sg.id]
	private_dns_enabled = true
	subnet_ids = [aws_subnet.week11-pri-a.id, aws_subnet.week11-pri-b.id]

	tags = {
		Name = "week11-sqs-ep"
	}
}
