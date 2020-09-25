#  Error alarm for lambda_archive_to_s3

resource "aws_cloudwatch_metric_alarm" "LambdaErrorArchiveToS3" {
  alarm_name = "LambdaErrorArchiveToS3"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "Errors"
  namespace = "AWS/Lambda"
  period = "60"
  statistic = "Sum"
  threshold = "1"
  alarm_description = "Alarm for loppuprojekti Lambdas when there is at least one error"
  treat_missing_data = "notBreaching"
  dimensions = {
    FunctionName = aws_lambda_function.post_to_s3_archive_lambda.function_name
  }
  alarm_actions = [
  aws_sns_topic.alarm_notifications.arn]
}
#  Error alarm for lambda_get_from_s3

resource "aws_cloudwatch_metric_alarm" "LambdaErrorGetFromS3" {
  alarm_name = "LambdaErrorGetFromS3"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "Errors"
  namespace = "AWS/Lambda"
  period = "60"
  statistic = "Sum"
  threshold = "1"
  alarm_description = "Alarm for loppuprojekti Lambdas when there is at least one error"
  treat_missing_data = "notBreaching"
  dimensions = {
    FunctionName = aws_lambda_function.get_from_s3_lambda.function_name
  }
  alarm_actions = [
  aws_sns_topic.alarm_notifications.arn]
}
#  Error alarm for lambda_if_neg_send_to_sns

resource "aws_cloudwatch_metric_alarm" "LambdaErrorIfNegSendToSns" {
  alarm_name = "LambdaErrorIfNegSendToSns"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "Errors"
  namespace = "AWS/Lambda"
  period = "60"
  statistic = "Sum"
  threshold = "1"
  alarm_description = "Alarm for loppuprojekti Lambdas when there is at least one error"
  treat_missing_data = "notBreaching"
  dimensions = {
    FunctionName = aws_lambda_function.if_negative_then_sns_lambda.function_name
  }
  alarm_actions = [
  aws_sns_topic.alarm_notifications.arn]
}
#  Error alarm for lambda_invoke_stepfunction

resource "aws_cloudwatch_metric_alarm" "LambdaErrorInvokeStepfunction" {
  alarm_name = "LambdaErrorInvokeStepfunction"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "Errors"
  namespace = "AWS/Lambda"
  period = "60"
  statistic = "Sum"
  threshold = "1"
  alarm_description = "Alarm for loppuprojekti Lambdas when there is at least one error"
  treat_missing_data = "notBreaching"
  dimensions = {
    FunctionName = aws_lambda_function.invoke_stepfunction.function_name
  }
  alarm_actions = [
  aws_sns_topic.alarm_notifications.arn]
}
#  Error alarm for lambda_post_to_comprehend

resource "aws_cloudwatch_metric_alarm" "LambdaErrorPostToComprehend" {
  alarm_name = "LambdaErrorPostToComprehend"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "Errors"
  namespace = "AWS/Lambda"
  period = "60"
  statistic = "Sum"
  threshold = "1"
  alarm_description = "Alarm for loppuprojekti Lambdas when there is at least one error"
  treat_missing_data = "notBreaching"
  dimensions = {
    FunctionName = aws_lambda_function.comprehend_lambda.function_name
  }
  alarm_actions = [
  aws_sns_topic.alarm_notifications.arn]
}
#  Error alarm for lambda_post_to_dynamodb

resource "aws_cloudwatch_metric_alarm" "LambdaErrorPostToDynamoDB" {
  alarm_name = "LambdaErrorPostToDynamoDB"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "Errors"
  namespace = "AWS/Lambda"
  period = "60"
  statistic = "Sum"
  threshold = "1"
  alarm_description = "Alarm for loppuprojekti Lambdas when there is at least one error"
  treat_missing_data = "notBreaching"
  dimensions = {
    FunctionName = aws_lambda_function.post_to_dynamodb.function_name
  }
  alarm_actions = [
  aws_sns_topic.alarm_notifications.arn]
}