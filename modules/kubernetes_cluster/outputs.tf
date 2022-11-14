output "kubernetes_host" {
  description = "Kubernetes Host"
  value       = digitalocean_kubernetes_cluster.k8s.endpoint
}

output "kubernetes_token" {
  description = "Kubernetes Token"
  value       = digitalocean_kubernetes_cluster.k8s.kube_config[0].token
}

output "kubernetes_ca_certificate" {
  description = "Kubernetes CA certificate"
  value       = base64decode(digitalocean_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate)
}

output "cluster_urn" {
  description = "URN of the cluster"
  value       = digitalocean_kubernetes_cluster.k8s.urn
}

output "cluster_name" {
  description = "Name of the cluster"
  value       = digitalocean_kubernetes_cluster.k8s.name
}

output "worker_nodes" {
  description = "List of node pools containing the workers"
  value       = tolist(flatten(digitalocean_kubernetes_cluster.k8s.node_pool.*.nodes))
}
