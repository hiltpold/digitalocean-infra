variable "project_name" {
  default = ""
  type    = string
}

variable "letsencrypt_email" {
  default = ""
  type    = string
}

variable "letsencrypt_issuer_template" {
  default = "./conf/letsencript-issuer.yaml"
  type    = string
}

variable "server_values" {
  default = "./conf/metrics-server-values.yaml"
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
  default = ""
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

