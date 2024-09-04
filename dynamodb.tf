resource "aws_dynamodb_table" "global_counter_table" {
  name         = "GlobalCounterTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"

  attribute {
    name = "userId"
    type = "S"
  }

  # attribute {
  #   name = "incrementedAt"
  #   type = "N"
  # }

  ttl {
    attribute_name = "incrementedAt"
    enabled        = true
  }
}

resource "aws_dynamodb_table" "user_counter_table" {
  name         = "UserCounterTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"

  attribute {
    name = "userId"
    type = "S"
  }

  # attribute {
  #   name = "userCounter"
  #   type = "N"
  # }

  # attribute {
  #   name = "expires"
  #   type = "N"
  # }

  ttl {
    attribute_name = "expires"
    enabled        = true
  }
}

resource "aws_iam_policy" "appsync_dynamodb_policy" {
  name        = "AppSyncDynamoDBPolicy"
  
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:Scan"
      ],
      "Resource": [
        "${aws_dynamodb_table.global_counter_table.arn}",
        "${aws_dynamodb_table.user_counter_table.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "appsync_dynamodb_policy_attachment" {
  role       = aws_iam_role.appsync_role.name
  policy_arn = aws_iam_policy.appsync_dynamodb_policy.arn
}
