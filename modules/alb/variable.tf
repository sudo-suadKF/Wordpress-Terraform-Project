variable "alb_sg_id" {
    description = "Contains ALBs SG id"
    type = string
}

variable "public_subnet1_id" {
    description = "Contains Public Subnet 1 ID"
    type = string
}

variable "public_subnet2_id" {
    description = "Contains Public Subnet 2 ID"
    type = string
}

variable "cert_arn" {
  description = "Contains Certs ARN"
  type = string
}

variable "vpc_id" {
  description = "Contains VPC's ID"
  type = string
}

variable "ec2_1_id" {
  description = "Contains ec2 instance 1's ID"
  type = string
}

variable "ec2_2_id" {
  description = "Contains ec2 instance 2's ID"
  type = string
}

