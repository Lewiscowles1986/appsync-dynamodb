resource "aws_appsync_resolver" "get_user_count" {
  api_id      = aws_appsync_graphql_api.counter_api.id
  type        = "Query"
  field       = "getUserCount"
  data_source = aws_appsync_datasource.user_counter_dynamodb.name

  request_template = <<EOF
{
  "version": "2018-05-29",
  "operation": "GetItem",
  "key": {
    "userId": {
      "S": "$context.arguments.userId"
    }
  }
}
EOF

  response_template = <<EOF
#if($ctx.result.userCounter)
$util.toJson($ctx.result.userCounter)
#else
$util.toJson(0)
#end
EOF
}

resource "aws_appsync_resolver" "get_global_count" {
  api_id      = aws_appsync_graphql_api.counter_api.id
  type        = "Query"
  field       = "getGlobalCount"
  data_source = aws_appsync_datasource.global_counter_dynamodb.name

  request_template = <<EOF
{
  "version": "2018-05-29",
  "operation": "Scan"
}
EOF

  response_template = <<EOF
$ctx.result.items.size()
EOF
}
