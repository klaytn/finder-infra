data "terraform_remote_state" "foundation" {
  backend = "s3"
  config = {
    bucket = var.s3_bucket
    key    = var.s3_foundation_key
    region = var.aws_region
    profile = var.aws_profile_name
  }
}

data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = var.s3_bucket
    key    = var.s3_s3_key
    region = var.aws_region
    profile = var.aws_profile_name
  }
}

module "emr" {
  source = "terraform-aws-modules/emr/aws"

  name = var.emr_name

  release_label = "emr-6.7.0"

  applications  = ["Spark", "Hadoop"]

  auto_termination_policy = {
    idle_timeout = 3600
  }

  configurations_json = jsonencode(
  [
  {
    "Classification": "spark",
    "Properties": {
      "maximizeResourceAllocation": "true"
    }
  },
  {
    "Classification": "spark-hive-site",
    "Properties": {
      "hive.metastore.client.factory.class": "com.amazonaws.glue.catalog.metastore.AWSGlueDataCatalogHiveClientFactory"
    }
  },
  {
    "Classification": "spark-env",
    "Configurations": [
      {
        "Classification": "export",
        "Properties": {
          "JAVA_HOME": "/usr/lib/jvm/java-11-amazon-corretto.aarch64"
        }
      }
    ]
  },
  {
    "Classification": "spark-defaults",
    "Properties": {
      "spark.executorEnv.JAVA_HOME": "/usr/lib/jvm/java-11-amazon-corretto.aarch64",
      "spark.dynamicAllocation.enabled": "false",
      "spark.executor.defaultJavaOptions": "-XX:+UseG1GC -verbose:gc -XX:OnOutOfMemoryError='kill -9 %p' -Dio.netty.tryReflectionSetAccessible=true",
      "spark.executor.extraJavaOptions": "-XX:+UseG1GC -verbose:gc -XX:OnOutOfMemoryError='kill -9 %p' -Dio.netty.tryReflectionSetAccessible=true",
      "spark.driver.defaultJavaOptions": "-XX:+UseG1GC -verbose:gc -XX:OnOutOfMemoryError='kill -9 %p' -Dio.netty.tryReflectionSetAccessible=true",
      "spark.driver.extraJavaOptions": "-XX:+UseG1GC -verbose:gc -XX:OnOutOfMemoryError='kill -9 %p' -Dio.netty.tryReflectionSetAccessible=true",
      "spark.rdd.compress": "true",
      "spark.history.fs.cleaner.enabled": "true",
      "spark.history.fs.cleaner.maxAge": "48h",
      "spark.history.fs.cleaner.interval": "1h"
    }
  },
  {
    "Classification": "hadoop-env",
    "Configurations": [
      {
        "Classification": "export",
        "Properties": {
          "JAVA_HOME": "/usr/lib/jvm/java-11-amazon-corretto.aarch64"
        }
      }
    ]
  },
  {

    "Classification": "yarn-site",
    "Properties": {
      "yarn.log-aggregation.retain-seconds": "86400"
    }
  },
  {
    "Classification": "spark-log4j",
    "Properties": {
      "log4j.rootCategory": "WARN,console",
      "log4j.logger.org.apache.spark.streaming": "WARN,DRFA-stderr,DRFA-stdout"
    }
  }
  ]  
  )

  master_instance_fleet = {
    name                      = "${var.emr_name}-master"
    target_on_demand_capacity = 1
    instance_type_configs = [
      {
        instance_type = "m6g.2xlarge"
        ebs_config = {
            size                 = 62
            type                 = "gp2"
            volumes_per_instance = 4
          }          
      },
    ]
  }

  core_instance_fleet = {
    name                      = "${var.emr_name}-core"
    target_on_demand_capacity = 11
    target_spot_capacity      = 10
    instance_type_configs = [
      {
        instance_type     = "m6g.2xlarge"
        weighted_capacity = 1
        ebs_config = {
          size                 = 32
          type                 = "gp2"
          volumes_per_instance = 4
        }
      },
    ]
    launch_specifications = {
      spot_specification = {
        allocation_strategy      = "capacity-optimized"
        block_duration_minutes   = 0
        timeout_action           = "SWITCH_TO_ON_DEMAND"
        timeout_duration_minutes = 5
      }
    }
  }

  ebs_root_volume_size = 10

  ec2_attributes = {
    "subnet_id": data.terraform_remote_state.foundation.outputs.private_2_subnet_info.id[0]
    }

  vpc_id = data.terraform_remote_state.foundation.outputs.vpc_info.vpc_id

  list_steps_states  = ["PENDING", "RUNNING", "FAILED", "INTERRUPTED"]

  log_uri            = "s3://${data.terraform_remote_state.s3.outputs.aws_s3_bucket_spark_id}/emr/"

  scale_down_behavior    = "TERMINATE_AT_TASK_COMPLETION"
  step_concurrency_level = 20
  termination_protection = false
  visible_to_all_users   = true

  tags = {
    Terraform   = "true"
    Environment = var.phase
  }

}