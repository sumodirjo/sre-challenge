data "google_compute_network" "network" {
  name = local.network_name
  project = local.project_id
}

data "google_compute_subnetwork" "subnetwork" {
  name    = local.subnet_name
  project = local.project_id
  region  = local.region
}

data "google_compute_subnetwork" "app_subnetwork" {
  name    = "app-subnetwork"
  project = local.project_id
  region  = local.region
}
