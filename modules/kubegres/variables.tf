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

variable "super_user_password" {
  default = ""
  type    = string
}

variable "replication_user_password" {
  default = ""
  type    = string
}

variable "manifest_pattern" {
  default = "./manifests/*.yaml"
  type    = string
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
