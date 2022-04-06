variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cidr_block" {
  type = string
}

variable "subnets" {
  type    = list(string)
  default = []
}