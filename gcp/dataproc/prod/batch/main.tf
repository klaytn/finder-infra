module "dataproc_batch" {
  source               = "../../../modules/dataproc/batch"
  project              = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  subnetwork           = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets["asia-northeast3/sb-finder-prod-shared"].id
  region               = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]
  master_machine_type  = "e2-highmem-16"
  worker_machine_type  = "e2-standard-4"
  name                 = "finder-batch-prod"
  tags                 = ["finder-streaming-batch", "dataproc"]
  image_version        = "2.2-debian12"
  boot_disk_size_gb    = 30
  master_num_instances = 1
  worker_num_instances = 30
}