resource "aws_appsync_resolver" "increment_counter" {
  api_id      = aws_appsync_graphql_api.counter_api.id
  type        = "Mutation"
  field       = "incrementGlobalCounter"
  data_source = aws_appsync_datasource.global_counter_dynamodb.name

  request_template = file("mutations/increment_global_counter.mutation")

  response_template = <<EOF
true
EOF

}

resource "aws_appsync_resolver" "increment_user_counter" {
  api_id      = aws_appsync_graphql_api.counter_api.id
  type        = "Mutation"
  field       = "incrementUserCounter"
  data_source = aws_appsync_datasource.user_counter_dynamodb.name

  request_template = file("mutations/increment_user_counter.mutation")

  response_template = <<EOF
#if($ctx.error)
  $util.error($ctx.error.message, $ctx.error.type)
#else
  true
#end
EOF

}

resource "aws_appsync_resolver" "increment_counter_pipeline" {
  api_id = aws_appsync_graphql_api.counter_api.id
  type   = "Mutation"
  field  = "incrementCounter"
  kind   = "PIPELINE"

  # Link the two functions to this pipeline
  pipeline_config {
    functions = [
      aws_appsync_function.increment_global_counter_function.function_id,
      aws_appsync_function.increment_user_counter_function.function_id
    ]
  }

  request_template = <<EOF
{
  "version": "2018-05-29",
  "payload": {}
}
EOF

  response_template = <<EOF
#if($ctx.error)
  $util.error($ctx.error.message, $ctx.error.type)
#else
  true
#end
EOF
}
