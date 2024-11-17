variable "vpc_cidr" {
  #default = "10.0.204.0/23"
}

variable "pvt_cidr" {
  type    = list(any)
  #default = ["10.0.204.128/26", "10.0.204.192/26"]
}

variable "pub_cidr" {
  type    = list(any)
  #default = ["10.0.204.0/26", "10.0.204.64/26"]
}