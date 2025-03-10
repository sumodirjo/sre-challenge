resource "google_service_account" "gke_nodepool_sa" {
  account_id   = "nodepool-sa"
  display_name = "Service Account for GKE Nodepool"
  project = local.project_id
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "~> 33.0"

  project_id              = local.project_id
  name                    = local.cluster_name
  regional                = false
  region                  = local.region
  zones                   = [ local.zone ]
  network                 = data.google_compute_network.network.name
  subnetwork              = data.google_compute_subnetwork.subnetwork.name
  ip_range_pods           = "pod-network"
  ip_range_services       = "service-network"
  create_service_account  = false
  service_account         = google_service_account.gke_nodepool_sa.email
  enable_private_endpoint = true
  enable_private_nodes    = true
  master_ipv4_cidr_block  = local.master_ipv4_cidr_block
  deletion_protection     = false

  master_authorized_networks = [
    {
      cidr_block   = data.google_compute_subnetwork.subnetwork.ip_cidr_range
      display_name = "VPC"
    },
    {
      cidr_block   = data.google_compute_subnetwork.app_subnetwork.ip_cidr_range
      display_name = "app-subnetwork"
    },
  ]

  logging_service = "none"
  monitoring_service = "none"

  node_pools = [
    {
      name                        = "node-pool-1"
      machine_type                = "e2-medium"
      node_locations              = "asia-southeast2-a"
      min_count                   = 0
      max_count                   = 2
      local_ssd_count             = 0
      spot                        = true
      disk_size_gb                = 10
      disk_type                   = "pd-ssd"
      image_type                  = "COS_CONTAINERD"
      auto_repair                 = true
      auto_upgrade                = true
      service_account             = google_service_account.gke_nodepool_sa.email
      preemptible                 = false
      initial_node_count          = 0
      logging_service = "none"
      monitoring_service = "none"
    },
    {
      name                        = "node-pool-2"
      machine_type                = "e2-medium"
      node_locations              = "asia-southeast2-a"
      min_count                   = 0
      max_count                   = 2
      local_ssd_count             = 0
      spot                        = true
      disk_size_gb                = 10
      disk_type                   = "pd-ssd"
      image_type                  = "COS_CONTAINERD"
      auto_repair                 = true
      auto_upgrade                = true
      service_account             = google_service_account.gke_nodepool_sa.email
      preemptible                 = false
      initial_node_count          = 0
    },
  ]


  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]

    node-pool-1 = [
      {
        key    = "monitoring"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]

  }
  }