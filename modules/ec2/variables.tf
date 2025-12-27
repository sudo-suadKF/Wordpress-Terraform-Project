variable "instance_ami" {
  description = "Contains instance's AMI"
  type = string
}

variable "instance_type" {
  description = "Contains instance's type"
  type = string
}

variable "key_name" {
  description = "Contains instance's key name"
  type = string
}

variable "instance_subnet_id" {
  description = "Contains instance's subnet id"
  type = string
}

variable "ec2_sg_id" {
  description = "Contains EC2's SG ID"
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

variable "rds_port" {
  description = "Contains RDS's port"
  type = string
}

variable "rds_endpoint" {
  description = "Contains RDS's endpoint"
  type = string
}