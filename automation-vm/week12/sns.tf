resource "aws_sns_topic" "week12-sns" {
	name = "week12-sns"
	kms_master_key_id = "alias/aws/sns"

}

resource "aws_sns_topic_subscription" "week12-sns-mail" {
	protocol = "email"
	endpoint = "7kuiker@gmail.com"
	topic_arn = aws_sns_topic.week12-sns.arn
}
