variable "cloud_id" {
  type        = string
  description = "YC Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "YC Folder ID"
}

variable "zone" {
  type        = string
  description = "Zone"
}

variable "project" {
  type        = string
  description = "Name of project (cloud)"
}

variable "environment" {
  type        = string
  description = "Name of environment"
}

variable "subnet_v4_cidr_blocks" {
  type        = string
  description = "Subnet IP V4 CIDR blocks"
}
