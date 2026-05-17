variable "instance_name" {
  type        = string
  description = "Instance name"
  nullable    = false
}

variable "instance_zone" {
  type        = string
  description = "Yandex Cloud compute default zone"
  default     = "ru-central1-a"
}

variable "instance_cores" {
  default     = 2
  type        = number
  description = "Instance cores quantity"
  nullable    = false
}

variable "instance_memory" {
  default     = 2
  type        = number
  description = "Instance memory amount"
  nullable    = false
}

variable "instance_image_family" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "Image family for boot disk"
}

variable "instance_disk_name" {
  type        = string
  description = "Instance disk name"
  nullable    = false
}

variable "instance_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Instance disk name"
  nullable    = false
}

variable "instance_disk_size" {
  default     = 30
  type        = number
  description = "Instance disk size"
  nullable    = false
}

variable "instance_subnet_id" {
  type        = string
  description = "Instance network interface subnet"
  nullable    = false
}

variable "instance_nat" {
  default     = false
  type        = bool
  description = "Instance NAT enable/disable"
  nullable    = false
}

variable "instance_user" {
  type        = string
  description = "Instance user"
  nullable    = false
}