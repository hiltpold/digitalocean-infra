variable "super_user_password" {
  default = ""
  type    = string
}

variable "replication_user_password" {
  default = ""
  type    = string
}

variable "manifest_pattern" {
  default = ""
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
