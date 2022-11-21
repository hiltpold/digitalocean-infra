resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "ingress-nginx" {
  name = "${var.project_name}-helm-ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  values = [
    file("${var.value_file}")
  ]

  depends_on = [kubernetes_namespace.ingress]
}

resource "kubernetes_ingress_v1" "nginx_ingress" {
  metadata {
    name = "nginx-ingress"
    annotations = {
      #"cert-manager.io/cluster-issuer" = "letsencrypt-staging"
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"
      #nginx.ingress.kubernetes.io/rewrite-target: /$2
    }
  }
  spec {
    rule {
      host = "hiltpold.tech"
      http {
        path {
          path = "/"
          backend {
            service {
              name = "lakelandcup-ui-service"
              port {
                number = 80
              }
            }
          }
        }
        path {
          path = "/v1/"
          backend {
            service {
              name = "lakelandcup-api-gateway-service"
              port {
                number = 50000
              }
            }
          }
        }
      }
    }
    rule {
      host = "pgadmin.hiltpold.tech"
      http {
        path {
          path = "/"
          backend {
            service {
              name = "pgadmin-service"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
    tls {
      hosts       = ["hiltpold.tech", "pgadmin.hiltpold.tech"]
      secret_name = "hiltpold-tech-tls-secret"
    }
    ingress_class_name = "nginx"
  }
}
