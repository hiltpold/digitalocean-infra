variable "do_token" {
  default = ""
  type    = string
}

variable "owner" {
  default = ""
  type    = string
}

variable "region" {
  default = ""
  type    = string
}

variable "vpc_id" {
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
