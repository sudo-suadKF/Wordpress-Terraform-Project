variable "vpc_cidr" {
    description = "Contains cidr block for vpc"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
    description = "Contains cidr block for public subnet 1"
    type = string
    default = "10.0.0.0/18"
}

variable "public_subnet2_cidr" {
    description = "Contains cidr block for public subnet 2"
    type = string
    default = "10.0.64.0/18"
}

variable "private_subnet1_cidr" {
    description = "Contains cidr block for private subnet 1"
    type = string
    default = "10.0.128.0/18"
}

variable "private_subnet2_cidr" {
    description = "Contains cidr block for public subnet 2"
    type = string
    default = "10.0.192.0/18"
}

variable "az1" {
    description = "Contains availability zone 1"
    type = string
    default = "eu-west-2a"
}

variable "az2" {
    description = "Contains availability zone 2"
    type = string
    default = "eu-west-2b"
}

variable "my_ip" {
  description = "Contains my IP address"
  type = string
}

variable "internet_cidr" {
  description = "Contains internets cidr block"
  type = string
  default = "0.0.0.0/0"
}

variable "alb_domain_name" {
  description = "Contains ALBs domain name"
  type = string
  default = "alb.sudosuad.co.uk"
}

variable "hosted_zone_name" {
  description = "Contains hosted zone name"
  type = string
  default = "sudosuad.co.uk"
}

variable "instance_ami" {
  description = "Contains instance's AMI"
  type = string
  default = "ami-0a0ff88d0f3f85a14"
}

variable "instance_type" {
  description = "Contains instance's type"
  type = string
  default = "t3.micro"
}

variable "key_name" {
  description = "Contains instance's key name"
  type = string
}

variable "db_name" {
  description = "Contains database name"
  type = string
}

variable "username" {
  description = "Contains RDS username"
  type = string
}

variable "password" {
  description = "Contains RDS password"
  type = string
}