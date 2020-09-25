resource aws_iam_user "tr" {
  name = "tim.rohwedder"
}

resource aws_iam_group "GlobalAdministrators" {
  name = "GlobalAdministrators"
}

resource aws_iam_policy "FullAccess" {
  name        = "FullAccess"
  description = "grants full access to all AWS resources"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource aws_iam_group_policy_attachment "GlobalAdministrators" {
  group      = aws_iam_group.GlobalAdministrators.name
  policy_arn = aws_iam_policy.FullAccess.arn
}

resource aws_iam_user_group_membership "tr" {
  user = aws_iam_user.tr.name
  groups = [
    aws_iam_group.GlobalAdministrators.name,
  ]
}

resource aws_iam_account_password_policy "strict" {
  allow_users_to_change_password = true
  hard_expiry                    = false
  max_password_age               = 365
  minimum_password_length        = 14
  password_reuse_prevention      = 5
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
}
