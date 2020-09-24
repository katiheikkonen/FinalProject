#  Yhdistetään policyt tarvittavaan rooliin ja annetaan rooli State Machinelle

resource "aws_iam_role" "iam_for_state_machine_sentimental_analysis" {
  name = "iam_for_state_machine_sentimental_analysis_ver2"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "states.eu-central-1.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "1"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "state_machine_attachment" {
  role       = aws_iam_role.iam_for_state_machine_sentimental_analysis.name
  policy_arn = aws_iam_policy.state_machine_iam_policy_ver2.arn
}

output "arn_for_state_machine_role" {
  value = aws_iam_role.iam_for_state_machine_sentimental_analysis.arn
}