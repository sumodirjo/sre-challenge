resource "google_compute_network" "main" {
  name                    = "main-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke_subnetwork" {
  name          = "gke-subnetwork"
  ip_cidr_range = "172.20.0.0/24"
  region        = "asia-southeast2"
  network       = google_compute_network.main.id
  secondary_ip_range {
    range_name    = "pod-network"
    ip_cidr_range = "100.64.0.0/20"
  }
  secondary_ip_range {
    range_name    = "service-network"
    ip_cidr_range = "172.20.2.0/24"
  }
}

resource "google_compute_subnetwork" "app_subnetwork" {
  name          = "app-subnetwork"
  ip_cidr_range = "172.21.0.0/24"
  region        = "asia-southeast2"
  network       = google_compute_network.main.id
}


resource "google_compute_router" "router" {
  project = local.project_id
  name    = "jakarta-router"
  network = google_compute_network.main.id
  region  = "asia-southeast2"
}
module "cloud-nat" {
  source  = "terraform-google-modules/cloud-nat/google"
  version = "~> 5.0"

  project_id                         = local.project_id
  region                             = "asia-southeast2"
  router                             = google_compute_router.router.name
  name                               = "jakarta-cloud-nat"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}