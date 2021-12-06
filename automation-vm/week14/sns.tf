resource "aws_sns_topic" "week14-sns" {
	name = "week14-sns"
	

}

resource "aws_sns_topic_subscription" "week14-sns-mail" {
	protocol = "email"
	endpoint = "7kuiker@gmail.com"
	topic_arn = aws_sns_topic.week14-sns.arn
}
