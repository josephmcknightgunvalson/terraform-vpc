variable "region" {
  type    = string
  default = "us-east-1"
}

variable "name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "private_subnets" {
  type    = list(string)
  default = []
}

variable "public_subnets" {
  type    = list(string)
  default = []
}

variable "secondary_cidr_blocks" {
  type    = list(string)
  default = []
}