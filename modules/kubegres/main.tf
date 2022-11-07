resource "kubernetes_secret" "postgres_secret" {
  metadata {
    name      = "postgres-secret"
    namespace = "default"
  }
  data = {
    super_user_password       = var.super_user_password
    replication_user_password = var.replication_user_password
  }
  type = "Opaque"
}

resource "kubectl_manifest" "kubegres" {
  for_each  = toset(data.kubectl_path_documents.docs.documents)
  yaml_body = each.value
}

