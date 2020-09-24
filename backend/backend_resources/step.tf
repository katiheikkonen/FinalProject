#  Luodaan State Machine ja sen vaiheet
resource "aws_sfn_state_machine" "sentimental_analysis_state_machine" {
  name = var.state_machine_name
  role_arn = aws_iam_role.iam_for_state_machine_sentimental_analysis.arn

  #Step machine:
  definition = jsonencode({
    "StartAt":"GetFromS3",
    "States": {
      "GetFromS3": {
        "Type": "Task",
        "Resource": aws_lambda_function.get_from_s3_lambda.arn
        "Next": "SentimentalAnalysisAndArchival"
    },

      "SentimentalAnalysisAndArchival": {
      "Type": "Parallel",
      "Next": "PutToDynamoAndSNS",
      "Branches": [{
          "StartAt": "Archival",
          "States": {
           "Archival": {
             "Type": "Task",
             "Resource": aws_lambda_function.post_to_s3_archive_lambda.arn
             "End": true
           }
          }
        },
        {
          "StartAt": "SentimentAnalysis",
          "States": {
           "SentimentAnalysis": {
             "Type": "Task",
             "Resource": aws_lambda_function.comprehend_lambda.arn
             "End": true
           }
          }
        }
      ]
    },
      "PutToDynamoAndSNS": {
        "Type": "Task",
        "Resource": aws_lambda_function.post_to_dynamodb.arn
        "Next": "PostToSNS"
      }
      "PostToSNS": {
        "Type": "Task",
        "Resource": aws_lambda_function.if_negative_then_sns_lambda.arn
        "End": true
      }
    },
  })
}

output "state_machine_arn" {
  value = aws_sfn_state_machine.sentimental_analysis_state_machine.arn
}
