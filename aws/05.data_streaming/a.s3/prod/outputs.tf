output "aws_s3_bucket_spark_id" {
    value = module.s3-log-spark.aws_s3_bucket_id
}

output "aws_s3_bucket_lake_id" {
    value = module.s3-data-lake.aws_s3_bucket_id
}
