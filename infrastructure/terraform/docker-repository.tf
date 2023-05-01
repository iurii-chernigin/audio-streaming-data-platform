# resource "google_artifact_registry_repository" "main" {
#   location      = "us-central1"
#   repository_id = "main"
#   format        = "DOCKER"
#   project       = var.project_id
# }