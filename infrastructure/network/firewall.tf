resource "google_compute_firewall" "allow_ssh_iap_range" {
  project = local.project_id
  name    = "allow-ssh"
  network = google_compute_network.main.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}