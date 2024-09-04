resource "aws_cloudwatch_log_group" "appsync_log_group" {
  name              = "/aws/appsync/apis/${aws_appsync_graphql_api.counter_api.name}"
  retention_in_days = 30
}

resource "aws_iam_role" "appsync_logging_role" {
  name = "AppSyncLoggingRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "appsync.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "appsync_logging_policy" {
  name = "AppSyncLoggingPolicy"
  role = aws_iam_role.appsync_logging_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}
