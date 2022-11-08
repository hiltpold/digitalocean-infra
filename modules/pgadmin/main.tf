resource "kubernetes_secret" "pgadmin_secret" {
  metadata {
    name      = "pgadmin-secret"
    namespace = "default"
  }
  data = {
    pgadmin_password = var.pgadmin_password
  }
  type = "Opaque"
}

resource "kubectl_manifest" "kubegres" {
  for_each  = toset(data.kubectl_path_documents.docs.documents)
  yaml_body = each.value
}

