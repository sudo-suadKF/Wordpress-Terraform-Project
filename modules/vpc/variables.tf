variable "vpc_cidr" {
    description = "Contains cidr block for vpc"
    type = string
}

variable "public_subnet1_cidr" {
    description = "Contains cidr block for public subnet 1"
    type = string
}

variable "public_subnet2_cidr" {
    description = "Contains cidr block for public subnet 2"
    type = string
}

variable "private_subnet1_cidr" {
    description = "Contains cidr block for private subnet 1"
    type = string
}

variable "private_subnet2_cidr" {
    description = "Contains cidr block for public subnet 2"
    type = string
}

variable "az1" {
    description = "Contains availability zone 1"
    type = string
}

variable "az2" {
    description = "Contains availability zone 2"
    type = string
}

variable "internet_cidr" {
  description = "Contains internets cidr block"
  type = string
}

