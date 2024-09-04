resource "aws_appsync_datasource" "global_counter_dynamodb" {
  api_id           = aws_appsync_graphql_api.counter_api.id
  name             = "GlobalCounterDynamoDB"
  type             = "AMAZON_DYNAMODB"
  dynamodb_config {
    table_name = aws_dynamodb_table.global_counter_table.name
  }
  service_role_arn = aws_iam_role.appsync_role.arn
}

resource "aws_appsync_datasource" "user_counter_dynamodb" {
  api_id           = aws_appsync_graphql_api.counter_api.id
  name             = "UserCounterDynamoDB"
  type             = "AMAZON_DYNAMODB"
  dynamodb_config {
    table_name = aws_dynamodb_table.user_counter_table.name
  }
  service_role_arn = aws_iam_role.appsync_role.arn
}
