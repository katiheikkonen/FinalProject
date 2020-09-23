#  Luodaan State Machine ja sen vaiheet

module "lambda_functions" {
  source = "../lambda_functions/"
}


#  Tällä hetkellä tehdyt kokeilut oikeasta toteutuksesta löytyy eu-central-1 Kati-Test-Machine

resource "aws_sfn_state_machine" "sentimental_analysis_state_machine" {
  name = "sentimental-analysis-state-machine"
  role_arn = aws_iam_role.iam_for_state_machine_sentimental_analysis.arn

  #  Toistaiseksi definition vielä malliesimerkki, mutta tähän voi liittää State Machinen lopullisessa muodossa.
  definition = jsonencode({
    "StartAt":"GetFromS3",
    "States": {
      "GetFromS3": {
        "Type": "Task",
        "Resource": module.lambda_functions.get_from_s3_arn,
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
             "Resource": module.lambda_functions.post_to_s3_archive_arn,
             "End": true
           }
          }
        },
        {
          "StartAt": "SentimentAnalysis",
          "States": {
           "SentimentAnalysis": {
             "Type": "Task",
             "Resource": module.lambda_functions.comprehend_arn,
             "End": true
           }
          }
        }
      ]
    },
      "PutToDynamoAndSNS": {
        "Type": "Task",
        "Resource": module.lambda_functions.dynamodb_arn,
        "End": true
      }
    },
  })
}
