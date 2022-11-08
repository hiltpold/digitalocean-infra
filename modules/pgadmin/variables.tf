variable "manifest_pattern" {
  default = "./manifests/*.yaml"
  type    = string
}

variable "pgadmin_password" {
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
