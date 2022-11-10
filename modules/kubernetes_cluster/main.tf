resource "digitalocean_kubernetes_cluster" "calypso" {
  name   = "calypso"
  region = var.region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.24.4-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    node_count = 1
    auto_scale = false
  }
}

/*
module "kubgres" {
  source = "../kubegres"

  kubernetes_host           = digitalocean_kubernetes_cluster.calypso.endpoint
  kubernetes_token          = digitalocean_kubernetes_cluster.calypso.kube_config[0].token
  kubernetes_ca_certificate = base64decode(digitalocean_kubernetes_cluster.calypso.kube_config[0].cluster_ca_certificate)
}
*/
