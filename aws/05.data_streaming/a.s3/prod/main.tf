module "s3-data-lake" {
  source    = "../module"
  bucket_id = var.s3_burket_lake_id
  phase     = var.phase
}

module "s3-log-spark" {
  source    = "../module"
  bucket_id = var.s3_burket_spark_id
  phase     = var.phase
}