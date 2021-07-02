# After the role has been created in the invited member account, login to the master account and create the following policy:
#
# (change YYYYYYYYYYYY to the ID of the invited member account)


resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_exec.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : [
          "sts:AssumeRole"
        ],
        "Resource" : [
          "arn:aws:iam::${var.miam_invited_account_id}:role/OrganizationAccountAccessRole"
        ]
      }
    ]
  })
  providers = {
    aws = aws.master
  }
}
