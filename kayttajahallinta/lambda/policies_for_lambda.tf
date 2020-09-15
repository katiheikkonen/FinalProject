#Tuodaan moduuli dynamo_tables, jotta voidaan referoida politikkoihin taulun arn:
module "dynamo_table_name" {
  source = "../dynamo_tables/"
}

#"lambda_put_to_dynamo" mahdollistaa POST metodin DynamoDB tauluun "Userdata":
resource "aws_iam_policy" "lambda_post_to_dynamo" {
  name        = "lambda_post_to_dynamo"
  description = "IAM policy for WRITE PutItem from a lambda to DynamoDB table UserData"

  policy = data.aws_iam_policy_document.put_item.json
}

#Policy document ylempää POST metodia varten
data "aws_iam_policy_document" "put_item" {
  statement {
    sid = "1as"
    effect = "Allow"
    actions = [
      "dynamodb:PutItem",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [module.dynamo_table_name.dynamo_table_userdata_arn, "arn:aws:logs:*:*:*"] #referoidaan moduulilla tuotua arnia
  }
}


#"lambda_delete_from_dynamo" mahdollistaa DELETE metodin DynamoDB tauluun "Userdata":
resource "aws_iam_policy" "lambda_delete_from_dynamo" {
  name        = "lambda_delete_from_dynamo"
  description = "IAM policy for WRITE DeleteItem from a lambda to DynamoDB table UserData"

  policy = data.aws_iam_policy_document.delete_item.json
}

#Policy document ylempää DELETE metodia varten
data "aws_iam_policy_document" "delete_item" {
  statement {
    sid = "1ss"
    effect = "Allow"
    actions = [
      "dynamodb:DeleteItem",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [module.dynamo_table_name.dynamo_table_userdata_arn, "arn:aws:logs:*:*:*"] #referoidaan moduulilla tuotua arnia
  }
}


#"lambda_get_from_dynamo" mahdollistaa GET metodin DynamoDB tauluun "Userdata":
resource "aws_iam_policy" "lambda_get_from_dynamo" {
  name        = "lambda_get_from_dynamo"
  description = "IAM policy for READ GetItem from a lambda to DynamoDB table UserData"

  policy = data.aws_iam_policy_document.get_item.json
}

#Policy document ylempää GET metodia varten
data "aws_iam_policy_document" "get_item" {
  statement {
    sid = "1dd"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [module.dynamo_table_name.dynamo_table_userdata_arn, "arn:aws:logs:*:*:*"] #referoidaan moduulilla tuotua arnia
  }
}


#"lambda_update_dynamo" mahdollistaa UPDATE/ PUT metodin DynamoDB tauluun "Userdata":
resource "aws_iam_policy" "lambda_update_dynamo" {
  name        = "lambda_update_dynamo"
  description = "IAM policy for READ GetItem from a lambda to DynamoDB table UserData"

  policy = data.aws_iam_policy_document.update_item.json
}

#Policy document ylempää UPDATE/ PUT metodia varten
data "aws_iam_policy_document" "update_item" {
  statement {
    sid = "1xx"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:UpdateItem",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [module.dynamo_table_name.dynamo_table_userdata_arn, "arn:aws:logs:*:*:*"] #referoidaan moduulilla tuotua arnia
  }
}