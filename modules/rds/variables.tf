variable "private_subnet1_id" {
  description = "Contains Private subnet 1 ID"
  type = string
}

variable "private_subnet2_id" {
  description = "Contains Private subnet 2 ID"
  type = string
}

variable "rds_sg_id" {
  description = "Contains RDS SG ID"
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