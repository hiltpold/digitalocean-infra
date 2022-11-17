/*
    Lakelandcup UI
*/
resource "kubernetes_deployment" "lakelandcup-ui" {
  metadata {
    name = "lakelandcup-ui"
    labels = {
      app = "lakelandcup-ui"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "lakelandcup-ui"
      }
    }

    template {
      metadata {
        labels = {
          app = "lakelandcup-ui"
        }
      }

      spec {
        container {
          image = "registry.digitalocean.com/hiltpold/lakelandcup/lakelandcup-ui:latest"
          name  = "lakelandcup-ui"

          port {
            container_port = 80
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "lakelandcup-ui-service" {
  metadata {
    name = "lakelandcup-ui-service"
  }
  spec {
    selector = {
      app = "lakelandcup-ui"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}

/*
    Lakelandcup Gateway
*/

resource "kubernetes_deployment" "lakelandcup-api-gateway" {
  metadata {
    name = "lakelandcup-api-gatway"
    labels = {
      app = "lakelandcup-api-gateway"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "lakelandcup-api-gateway"
      }
    }

    template {
      metadata {
        labels = {
          app = "lakelandcup-api-gateway"
        }
      }

      spec {
        container {
          image = "registry.digitalocean.com/hiltpold/lakelandcup/lakelandcup-api-gateway:latest"
          name  = "lakelandcup-api-gateway"

          port {
            container_port = 50000
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "lakelandcup-api-gateway-service" {
  metadata {
    name = "lakelandcup-api-gateway-service"
  }
  spec {
    selector = {
      app = "lakelandcup-api-gateway"
    }
    port {
      port        = 50000
      target_port = 50000
    }
  }
}

/*
    Lakelandcup Gateway
*/

resource "kubernetes_deployment" "lakelandcup-auth-service" {
  metadata {
    name = "lakelandcup-auth-service"
    labels = {
      app = "lakelandcup-auth-service"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "lakelandcup-auth-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "lakelandcup-auth-service"
        }
      }

      spec {
        container {
          image = "registry.digitalocean.com/hiltpold/lakelandcup/lakelandcup-auth-service:latest"
          name  = "lakelandcup-auth-service"

          port {
            container_port = 50010
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "lakelandcup-api-gateway-service" {
  metadata {
    name = "lakelandcup-api-gateway-service"
  }
  spec {
    selector = {
      app = "lakelandcup-api-gateway"
    }
    port {
      port        = 50010
      target_port = 50010
    }
  }
}
