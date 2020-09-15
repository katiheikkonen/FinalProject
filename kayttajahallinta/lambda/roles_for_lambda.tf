#Rooli "create_user" lambdalle, jotta käyttäjä voi luoda itselleen tilin------------------------------------------------
resource "aws_iam_role" "role_for_create_user_lambda" {
  name = "iam_for_create_user_lambda"
  assume_role_policy = data.aws_iam_policy_document.put_item.json
}

#Liitetään POST roolille policy, joka oikeuttaa PutItemin "userdata" dynamo tauluun:
resource "aws_iam_role_policy_attachment" "lambda_post1" {
  role       = aws_iam_role.role_for_create_user_lambda.name
  policy_arn = aws_iam_policy.lambda_post_to_dynamo.arn
}


#Rooli "delete_user" lambdalle, jotta käyttäjä voi poistaa itseltään tilin------------------------------------------------
resource "aws_iam_role" "role_for_delete_user_lambda" {
  name = "iam_for_delete_user_lambda"
  assume_role_policy = data.aws_iam_policy_document.delete_item.json
}

#Liitetään DELETE roolille policy, joka oikeuttaa DeleteItemin "userdata" dynamo tauluun:
resource "aws_iam_role_policy_attachment" "lambda_delete1" {
  role       = aws_iam_role.role_for_delete_user_lambda.name
  policy_arn = aws_iam_policy.lambda_delete_from_dynamo.arn
}


#Rooli "get_user" lambdalle, jotta käyttäjä voi saada tietonsa------------------------------------------------
resource "aws_iam_role" "role_for_get_user_lambda" {
  name = "iam_for_get_user_lambda"
  assume_role_policy = data.aws_iam_policy_document.get_item.json
}

//#Liitetään GET roolille policy, joka oikeuttaa logata CloudWatchiin
//resource "aws_iam_role_policy_attachment" "lambda_logs3" {
//  role       = aws_iam_role.role_for_get_user_lambda.name
//  policy_arn = aws_iam_policy.lambda_logging.arn
//}

#Liitetään GET roolille policy, joka oikeuttaa GetItemin "userdata" dynamo tauluun:
resource "aws_iam_role_policy_attachment" "lambda_get1" {
  role       = aws_iam_role.role_for_get_user_lambda.name
  policy_arn = aws_iam_policy.lambda_get_from_dynamo.arn
}


#Rooli "update_user" lambdalle, jotta käyttäjä voi päivittää tietojaan------------------------------------------------
resource "aws_iam_role" "role_for_update_user_lambda" {
  name = "iam_for_update_user_lambda"
  assume_role_policy = data.aws_iam_policy_document.update_item.json
}


#Liitetään UPDATE roolille policy, joka oikeuttaa päivittää tietoja "userdata" dynamo tauluun:
resource "aws_iam_role_policy_attachment" "lambda_put1" {
  role       = aws_iam_role.role_for_update_user_lambda.name
  policy_arn = aws_iam_policy.lambda_update_dynamo.arn
}