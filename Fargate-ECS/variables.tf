variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cidr" {
  description = "CIDR of the VPC. This should be overwritten"
  type        = string
  default     = "0.0.0.0/0"
}

variable "private_subnet" {
  description = "Private subnet for fragate cluster. This should be overwritten"
  type        = string
  default     = "0.0.0.0/0"
}

variable "public_subnet" {
  description = "Public subnet for fragate cluster. This should be overwritten"
  type        = string
  default     = "0.0.0.0/0"
}