resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert-manager" {
  name = "cert-manager"

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "cert-manager"

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [kubernetes_namespace.cert-manager]
}


resource "kubernetes_manifest" "letsencrypt_issuer_staging" {
  manifest = yamldecode(templatefile(
    "${path.module}/conf/letsencrypt-issuer.tmpl.yaml",
    {
      "name"   = "letsencrypt-staging"
      "email"  = var.letsencrypt_email
      "server" = "https://acme-staging-v02.api.letsencrypt.org/directory"
    }
  ))

  depends_on = [helm_release.cert-manager]
}

resource "kubernetes_manifest" "letsencrypt_issuer_production" {
  manifest = yamldecode(templatefile(
    "${path.module}/conf/letsencrypt-issuer.tmpl.yaml",
    {
      "name"   = "letsencrypt-production"
      "email"  = var.letsencrypt_email
      "server" = "https://acme-v02.api.letsencrypt.org/directory"
    }
  ))

  depends_on = [helm_release.cert-manager]
}
