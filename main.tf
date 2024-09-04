resource "aws_appsync_graphql_api" "counter_api" {
  name = "CounterAPI"
  authentication_type = "API_KEY"
  
  schema = file("schema.graphql")

  log_config {
    field_log_level = "ALL"  # Set the level of logging. Options are NONE, ERROR, ALL.
    cloudwatch_logs_role_arn = aws_iam_role.appsync_logging_role.arn
  }

  xray_enabled = true
}


# Create an API key for the AppSync API
resource "aws_appsync_api_key" "api_key" {
  api_id = aws_appsync_graphql_api.counter_api.id
  expires = timeadd(timestamp(), "2592000s")  # This sets the expiration 30 days from now
}
