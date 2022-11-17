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
    ingress_class_name = "nginx"
  }
}
