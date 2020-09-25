#  Luodaan SNS topic alarmeja varten

resource "aws_sns_topic" "alarm_notifications" {
  name = "alarm_notifications"
}

output "alarm_notifications" {
  value = aws_sns_topic.alarm_notifications.arn
}