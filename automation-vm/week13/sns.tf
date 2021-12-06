resource "aws_sns_topic" "week13-sns" {
	name = "week13-sns"
	kms_master_key_id = "alias/aws/sns"

}

resource "aws_sns_topic_subscription" "week13-sns-mail" {
	protocol = "email"
	endpoint = "7kuiker@gmail.com"
	topic_arn = aws_sns_topic.week13-sns.arn
}
