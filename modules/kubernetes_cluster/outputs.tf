output "kubernetes_host" {
  description = "Kubernetes Host"
  value       = digitalocean_kubernetes_cluster.dolos.endpoint
}

output "kubernetes_token" {
  description = "Kubernetes Token"
  value       = digitalocean_kubernetes_cluster.dolos.kube_config[0].token
}

output "kubernetes_ca_certificate" {
  description = "Kubernetes CA certificate"
  value       = base64decode(digitalocean_kubernetes_cluster.dolos.kube_config[0].cluster_ca_certificate)
}

output "cluster_name" {
  description = "Name of the cluster"
  value       = digitalocean_kubernetes_cluster.dolos.name
}

output "worker_nodes" {
  description = "List of node pools containing the workers"
  value       = flatten([for pool in digitalocean_kubernetes_cluster.dolos.node_pool : pool.nodes])
}
