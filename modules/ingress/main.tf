resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "ingress-nginx" {
  name = "ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  values = [
    file("${var.value_file}")
  ]

  depends_on = [kubernetes_namespace.ingress]
}

resource "kubectl_manifest" "ingress" {
  for_each  = toset(data.kubectl_path_documents.docs.documents)
  yaml_body = each.value
}

