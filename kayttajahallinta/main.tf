#Nimetään provider
provider "aws" {
  region = "eu-central-1" #kova koodattuna, mutta myöhemmin mapattuna
  #access_key = ""
  #secret_key = ""
}

#archieve lambda:
data "archive_file" "luo_kayttaja" {
  type = "zip"
  source_file = "src/luo_kayttaja.py"
  output_path = "src/luo_kayttaja.zip"
}

#Lambda funktio:
resource "aws_lambda_function" "create_user" {
  function_name = "luo_kayttaja"
  handler = "luo_kayttaja.create_user"
  role = aws_iam_role.role_for_create_user_lambda.arn
  runtime = "python3.7"
  filename = data.archive_file.luo_kayttaja.output_path
  source_code_hash = data.archive_file.luo_kayttaja.output_base64sha256
}


#Rooli "create_user" lambdalle.-----------SPESIFOI MYÖHEMMIN TARKKA RESURSSI
resource "aws_iam_role" "role_for_create_user_lambda" {
  name = "iam_for_create_user_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "x"
    }
  ]
}
EOF
}

#Attachement for policy: role_for_create_user_lambda
resource "aws_iam_role_policy_attachment" "lambda_logs1" {
  role       = aws_iam_role.role_for_create_user_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

#Attachement for policy: role_for_create_user_lambda
resource "aws_iam_role_policy_attachment" "lambda_post1" {
  role       = aws_iam_role.role_for_create_user_lambda.name
  policy_arn = aws_iam_policy.lambda_post_to_dynamo.arn
}


#"lambda_logging" mahdollistaa
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}


#"lambda_put_to_dynamo" mahdollistaa POST metodin DynamoDB tauluun XXXX
resource "aws_iam_policy" "lambda_post_to_dynamo" {
  name        = "lambda_post_to_dynamo"
  description = "IAM policy for WRITE PutItem from a lambda to DynamoDB table XXX"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action":"dynamodb:PutItem",
      "Resource": "*"
      "Effect": "Allow"
    }
  ]
}
EOF
}
