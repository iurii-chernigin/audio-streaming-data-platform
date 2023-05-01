# resource "google_compute_firewall" "rules" {
#   project     = var.project_id
#   name        = "workstation-to-gke-cluster"
#   network     = "default"
#   description = "Rules allowing connection from workstation"

#   allow {
#     protocol  = "tcp"
#     ports     = ["22", "9092", "9093", "9094", "9095"]
#   }

#   source_ranges = ["0.0.0.0/0"]
#   target_tags = ["gke-node"]
# }