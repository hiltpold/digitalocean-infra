variable "manifest_pattern" {
  default = "./manifests/*.yaml"
  type    = string
}
variable "value_file" {
  default = "./manifests/ingress.yaml"
  type    = string
}
variable "kubernetes_cluster_name" {
  default = "dolos"
  type    = string
}

variable "kubernetes_worker_nodes" {
  default = []
  type    = set(any)
}

variable "kubernetes_host" {
  default = ""
  type    = string
}

variable "kubernetes_token" {
  default = ""
  type    = string
}

variable "kubernetes_ca_certificate" {
  default = ""
  type    = string
}

