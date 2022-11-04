output "kubernetes_host" {
  description = "Kubernetes Host"
  value       = digitalocean_kubernetes_cluster.calypso.endpoint
}

output "kubernetes_token" {
  description = "Kubernetes Token"
  value       = digitalocean_kubernetes_cluster.calypso.kube_config[0].token
}

output "kubernetes_ca_certificate" {
  description = "Kubernetes CA certificate"
  value       = base64decode(digitalocean_kubernetes_cluster.calypso.kube_config[0].cluster_ca_certificate)
}
