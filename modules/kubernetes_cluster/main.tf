resource "digitalocean_kubernetes_cluster" "k8s" {
  name     = "${var.project_name}-k8s"
  region   = var.region
  version  = data.digitalocean_kubernetes_versions.version.latest_version
  vpc_uuid = var.vpc_id

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 1
    auto_scale = false
  }
}

/*
resource "digitalocean_container_registry_docker_credentials" "docker_registry_ca" {
  registry_name = var.owner
}

resource "kubernetes_secret" "docker_secret" {
  metadata {
    name = "docker-cfg"
  }

  data = {
    ".dockerconfigjson" = digitalocean_container_registry_docker_credentials.docker_registry_ca.docker_credentials
  }

  type = "kubernetes.io/dockerconfigjson"
}
*/
