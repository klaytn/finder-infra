resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket
}

resource "aws_dynamodb_table" "this" {
  name         = var.dynamodb_table
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
