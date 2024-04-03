resource "google_dataproc_cluster" "finder-batch-prod" {
  project  = var.project
  name     = var.name
  region   = var.region
  graceful_decommission_timeout = "120s"
  labels = {
    vm_instance = var.name
  }

  cluster_config {

    master_config {
      num_instances = var.master_num_instances
      machine_type  = var.master_machine_type
      disk_config {
        boot_disk_type    = "pd-balanced"
        boot_disk_size_gb = var.boot_disk_size_gb
      }
    }

    worker_config {
      num_instances    = var.worker_num_instances
      machine_type     = var.worker_machine_type
      disk_config {
        boot_disk_type    = "pd-balanced"
        boot_disk_size_gb = var.boot_disk_size_gb
      }
    }

    preemptible_worker_config {
        num_instances = var.preemptible_worker_num_instances  
        disk_config {
            boot_disk_type    = "pd-balanced"
            boot_disk_size_gb = var.boot_disk_size_gb
        }
    }


    # Override or set some custom properties
    software_config {
      image_version = var.image_version

      # Other Spark configurations
      override_properties = {
        "spark:spark.driver.defaultJavaOptions" = "-XX:+UseG1GC -verbose:gc -XX:OnOutOfMemoryError='kill -9 %p' -Dio.netty.tryReflectionSetAccessible=true",
        "spark:spark.driver.extraJavaOptions" = "-XX:+UseG1GC -verbose:gc -XX:OnOutOfMemoryError='kill -9 %p' -Dio.netty.tryReflectionSetAccessible=true",
        "spark:spark.dynamicAllocation.enabled" = "true",
        "spark:spark.executor.defaultJavaOptions" = "-XX:+UseG1GC -verbose:gc -XX:OnOutOfMemoryError='kill -9 %p' -Dio.netty.tryReflectionSetAccessible=true",
        "spark:spark.executor.extraJavaOptions" = "-XX:+UseG1GC -verbose:gc -XX:OnOutOfMemoryError='kill -9 %p' -Dio.netty.tryReflectionSetAccessible=true",
        "spark:spark.history.fs.cleaner.enabled" = "true",
        "spark:spark.history.fs.cleaner.interval" = "1h",
        "spark:spark.history.fs.cleaner.maxAge" = "48h",
        "spark:spark.rdd.compress" = "true",
        "yarn:yarn.log-aggregation.retain-seconds" = "86400",
        "spark:spark.log4j.logger.org.apache.spark.streaming" = "WARN,DRFA-stderr,DRFA-stdout",
        "spark:spark.log4j.rootCategory" = "WARN,console"
      }
    }

    gce_cluster_config {
      subnetwork   = var.subnetwork
      tags         = var.tags
    }

    # You can define multiple initialization_action blocks
    initialization_action {
      script      = "gs://dataproc-initialization-actions/stackdriver/stackdriver.sh"
      timeout_sec = 500
    }
  }
}

