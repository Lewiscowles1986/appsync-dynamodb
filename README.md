# AWS AppSync serverless example with DynamoDB direct querying

This is an example of a DynamoDB integration to AWS AppSync with X-Ray tracing, pipeline resolvers to issue multiple writes on a single endpoint (no result aggregation); as well as individual resolvers (mostly for debugging).

## Goals

Demonstrate read and write to / from DynamoDB ephemeral data (this has been set to expire records after 30 days)

Avoid use of imperative code as much as possible

Avoid use of Lambdas or existing HTTP APIs


## Deploying

### commands

1. `terraform plan`
2. `terraform apply`

### Pre-requisites

- AWS account
- terraform (and basic knowledge how to use)
- Money, to pay AWS bill

## Usage

### Register user interaction

```graphql
mutation MyMutation($userId: ID!) {
  incrementGlobalCounter(userId: $userId)
  incrementUserCounter(userId: $userId)
}

```

### Get back interaction specific to a user

```graphql
query MyQueryWithUserData($userId: ID!) {
  userCount: getUserCount(userId: $userId),
  globalCount: getGlobalCount
}

```

### Get back the global count of unique users that have interacted

```graphql
query MyQueryForGlobalCount {
  globalCount: getGlobalCount
}

```

### Variables
```json
{
  "userId":"lewis"
}
```

## Notes

X-Ray and Cloudwatch logs are enabled here. They don't have to be, but are very useful to determine parallelism; and to troubleshoot the non-intuitive integrations with sparse documentation and cryptic error messages.
