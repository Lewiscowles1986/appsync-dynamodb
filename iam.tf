resource "aws_iam_role" "appsync_role" {
  name = "AppSyncDynamoDBAccessRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "appsync.amazonaws.com"
      }
    }
  ]
}
EOF
}
