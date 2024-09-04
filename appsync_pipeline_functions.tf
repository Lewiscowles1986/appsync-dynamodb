resource "aws_appsync_function" "increment_global_counter_function" {
  api_id = aws_appsync_graphql_api.counter_api.id
  data_source = aws_appsync_datasource.global_counter_dynamodb.name
  name = "IncrementGlobalCounterFunction"

  request_mapping_template = file("mutations/increment_global_counter.mutation")

  response_mapping_template = <<EOF
null
EOF
}

resource "aws_appsync_function" "increment_user_counter_function" {
  api_id = aws_appsync_graphql_api.counter_api.id
  data_source = aws_appsync_datasource.user_counter_dynamodb.name
  name = "IncrementUserCounterFunction"

  request_mapping_template = file("mutations/increment_user_counter.mutation")

  response_mapping_template = <<EOF
null
EOF
}
