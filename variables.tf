# Used to retrieve outputs from other state files.
# The "access_key" variable is sensitive and should be passed using
# a .TFVARS file or other secure method.

variable "state_sa_name" {}

variable "container_name" {}

# Storage Account Access Key
variable "access_key" {}

# Resources name prefix
variable "prefix" {}

variable "root_cert_path" {
    type = string
}

