resource "google_service_account" "bastion_sa" {
  account_id   = "bastion-sa"
  display_name = "Service Account for Bastion Instance"
  project = local.project_id
}

resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = "e2-micro"
  zone         = "asia-southeast2-a"
  project = local.project_id

  boot_disk {
    initialize_params {
      image = "ubuntu-2404-noble-amd64-v20241004"
      type = "pd-ssd"
      size = "10"
    }
  }

  network_interface {
    network = "main-network"
    subnetwork = data.google_compute_subnetwork.app_subnetwork.id
    access_config {}
  }
  service_account {
    email  = google_service_account.bastion_sa.email
    scopes = ["cloud-platform"]
  }
  metadata = {
    enable-oslogin = "TRUE"
  }
  tags = ["bastion"]
}