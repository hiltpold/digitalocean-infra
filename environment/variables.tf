variable "do_token" {
  default = ""
  type    = string
}

variable "region" {
  default = ""
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

variable "pgadmin_password" {
  default = ""
  type    = string
}
