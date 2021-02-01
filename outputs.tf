output "bucket_name" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.bucket.bucket
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table used as a lock table."
  value       = aws_dynamodb_table.lock_table.id
}
