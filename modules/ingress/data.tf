data "kubectl_path_documents" "docs" {
  pattern = var.manifest_pattern
}
