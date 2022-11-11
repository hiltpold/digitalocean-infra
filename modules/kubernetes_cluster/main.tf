resource "digitalocean_kubernetes_cluster" "dolos" {
  name     = "dolos"
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
