resource "kubernetes_secret" "postgres_secret" {
  metadata {
    name      = "mypostgres-secret"
    namespace = "default"
  }
  data = {
    superUserPassword       = var.super_user_password
    replicationUserPassword = var.replication_user_password
  }
  type = "Opaque"
}

resource "kubectl_manifest" "kubegres" {
  for_each  = toset(data.kubectl_path_documents.docs.documents)
  yaml_body = each.value
}

