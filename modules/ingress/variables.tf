variable "manifest_pattern" {
  default = "./manifests/*.yaml"
  type    = string
}

variable "value_file" {
  default = "./manifests/ingress.yaml"
  type    = string
}

variable "project_name" {
  default = ""
  type    = string
}

variable "environment" {
  default = "dev"
  type    = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Allowed values for input_parameter are \"dev\", \"test\", or \"prod\"."
  }
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

