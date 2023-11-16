resource "google_compute_instance" "en_cypress" {
  project      = var.project
  name         = "finder-en-cypress-prod"
  machine_type = "e2-standard-8"
  zone         = var.zone
  tags         = ["ssh", "finder-en-node"]

  boot_disk {
    initialize_params {
      image         = "ubuntu-os-cloud/ubuntu-2004-lts"
      size          = 12288
    }
  }

  network_interface {
    subnetwork       = var.subnetwork
    access_config {}
  
   }

   metadata ={
     VmDnsSetting="GlobalOnly"
   }
}
